/** activectrl.cpp
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: control menu actions
 * Funtion: refresh and TakeAFullScreenshot
 */
#include "activectrl.h"
#include <QDesktopServices>
#include <QGuiApplication>
#include <QMetaObject>
#include <QPixmap>
#include <QQmlProperty>
#include <QQuickItemGrabResult>
#include <QScreen>
#include <QStandardPaths>

ActiveCtrl::ActiveCtrl(QObject *parent)
    : QObject{parent}
    , m_setting("cqnu", "ImageCraft")
{
    loadRecentFiles();
    m_recentFileNum = 10;
}

QString ActiveCtrl::savePath() const
{
    return m_savePath;
}

void ActiveCtrl::setSavePath(const QString &newSavePath)
{
    if (m_savePath == newSavePath)
        return;
    m_savePath = newSavePath;
    emit savePathChanged();
}

bool ActiveCtrl::modified() const
{
    return m_modified;
}

void ActiveCtrl::setModified(bool newModified)
{
    if (m_modified == newModified)
        return;
    m_modified = newModified;
    emit modifiedChanged();
}

QSize ActiveCtrl::size() const
{
    return m_size;
}

void ActiveCtrl::setSize(const QSize &newSize)
{
    if (m_size == newSize)
        return;
    m_size = newSize;
    emit sizeChanged();
}

QStringList ActiveCtrl::recentFiles() const
{
    return m_recentFiles;
}

void ActiveCtrl::setRecentFiles(const QStringList &newRecentFiles)
{
    if (m_recentFiles == newRecentFiles)
        return;
    m_recentFiles = newRecentFiles;
    emit recentFilesChanged();
}

QObject *ActiveCtrl::failToSave() const
{
    return m_failToSave;
}

void ActiveCtrl::setFailToSave(QObject *newFailToSave)
{
    if (m_failToSave == newFailToSave)
        return;
    m_failToSave = newFailToSave;
    emit failToSaveChanged();
}

QObject *ActiveCtrl::openDialogBox() const
{
    return m_openDialogBox;
}

void ActiveCtrl::setOpenDialogBox(QObject *newOpenDialogBox)
{
    if (m_openDialogBox == newOpenDialogBox)
        return;
    m_openDialogBox = newOpenDialogBox;
    emit openDialogBoxChanged();
}

QObject *ActiveCtrl::sharePage() const
{
    return m_sharePage;
}

void ActiveCtrl::setSharePage(QObject *newSharePage)
{
    if (m_sharePage == newSharePage)
        return;
    m_sharePage = newSharePage;
    emit sharePageChanged();
}

void ActiveCtrl::openSlot()
{
    QString imageUrl = QQmlProperty::read(m_openDialogBox, "selectedFile").toString();

    int lastIndexOfSlash = imageUrl.lastIndexOf('/') + 1;
    QString fileName = imageUrl.mid(lastIndexOfSlash);

    addRecentFiles(imageUrl);

    QMetaObject::invokeMethod(m_sharePage,
                              "addElement",
                              Q_ARG(QVariant, QVariant::fromValue(fileName)),
                              Q_ARG(QVariant, QVariant::fromValue(imageUrl)));
}

int ActiveCtrl::currentIndex() const
{
    return m_currentIndex;
}

void ActiveCtrl::setCurrentIndex(int newCurrentIndex)
{
    if (m_currentIndex == newCurrentIndex)
        return;
    m_currentIndex = newCurrentIndex;
    emit currentIndexChanged();
}

void ActiveCtrl::loadRecentFiles()
{
    m_recentFiles = m_setting.value("recentFiles").toStringList();
}

void ActiveCtrl::saveRecentFiles()
{
    m_setting.setValue("recentFiles", m_recentFiles);
}

QObject *ActiveCtrl::savePathDialod() const
{
    return m_savePathDialod;
}

void ActiveCtrl::setSavePathDialod(QObject *newSavePathDialod)
{
    if (m_savePathDialod == newSavePathDialod)
        return;
    m_savePathDialod = newSavePathDialod;
    emit savePathDialodChanged();
}

QObject *ActiveCtrl::currentLayer() const
{
    return m_currentLayer;
}

void ActiveCtrl::setCurrentLayer(QObject *newCurrentLayer)
{
    if (m_currentLayer == newCurrentLayer)
        return;
    m_currentLayer = newCurrentLayer;
    emit currentLayerChanged();
}

QObject *ActiveCtrl::newDialogBox() const
{
    return m_newDialogBox;
}

void ActiveCtrl::setNewDialogBox(QObject *newNewDialogBox)
{
    if (m_newDialogBox == newNewDialogBox)
        return;
    m_newDialogBox = newNewDialogBox;
    emit newDialogBoxChanged();
}

Editor *ActiveCtrl::currentEditor() const
{
    return m_currentEditor;
}

void ActiveCtrl::setCurrentEditor(Editor *newCurrentEditor)
{
    if (m_currentEditor == newCurrentEditor)
        return;
    m_currentEditor = newCurrentEditor;
    emit currentEditorChanged();
}

void ActiveCtrl::open()
{
    m_openDialogBox->metaObject()->invokeMethod(m_openDialogBox, "open", Qt::AutoConnection);
    QObject::connect(m_openDialogBox, SIGNAL(accepted()), this, SLOT(openSlot()));
}

void ActiveCtrl::newImage()
{
    m_newDialogBox->metaObject()->invokeMethod(m_newDialogBox, "open", Qt::AutoConnection);
}

void ActiveCtrl::save()
{
    if (!m_currentLayer || (!m_modified && !m_savePath.isEmpty())) {
        return;
    }
    if (m_savePath.isEmpty()) {
        saveAs();
    } else {
        QQuickItem *quickItem = qobject_cast<QQuickItem *>(m_currentLayer);
        if (quickItem) {
            QSharedPointer<QQuickItemGrabResult> grabResult = quickItem->grabToImage(m_size);
            QObject::connect(grabResult.data(), &QQuickItemGrabResult::ready, [=, this]() {
                QImage image = grabResult->image();
                if (image.save(m_savePath)) {
                    m_currentLayer->setProperty("isModified_", false);
                    qDebug() << "Save success to: " << m_savePath;
                } else {
                    m_failToSave->metaObject()->invokeMethod(m_failToSave,
                                                             "open",
                                                             Qt::AutoConnection);
                }
            });
        } else {
            qDebug() << m_currentEditor << " is not a QQuickItem type!!";
        }
    }
}

void ActiveCtrl::saveAs()
{
    if (!m_currentLayer) {
        return;
    }
    m_savePathDialod->metaObject()->invokeMethod(m_savePathDialod, "open", Qt::DirectConnection);
}

void ActiveCtrl::addRecentFiles(const QString &filePath)
{
    if (!m_recentFiles.contains(filePath)) {
        m_recentFiles.prepend(filePath);
        if (m_recentFiles.size() > m_recentFileNum) {
            m_recentFiles.removeLast();
        }
    } else {
        m_recentFiles.removeAll(filePath);
        m_recentFiles.prepend(filePath);
    }

    saveRecentFiles();
    emit recentFilesChanged();
}

void ActiveCtrl::close()
{
    if (!m_sharePage) {
        return;
    }
    if (m_currentIndex != -1) {
        m_sharePage->metaObject()->invokeMethod(m_sharePage,
                                                "removeElement",
                                                Q_ARG(QVariant, QVariant::fromValue(m_currentIndex)),
                                                Q_ARG(QVariant, QVariant::fromValue(1)));
        m_currentLayer = nullptr;
        emit currentLayerChanged();
    } else {
        qDebug() << "关闭失败!";
    }
}

void ActiveCtrl::closeAll()
{
    if (!m_sharePage) {
        return;
    }
    if (m_currentIndex != -1) {
        m_sharePage->metaObject()->invokeMethod(m_sharePage, "clear", Qt::DirectConnection);
        m_currentLayer = nullptr;
        emit currentLayerChanged();
    } else {
        qDebug() << "关闭全部失败!!";
    }
}

void ActiveCtrl::refresh()
{
    QString imageUrl;
    QString fileName;

    QVariant rv;
    QMetaObject::invokeMethod(m_sharePage, //调用方法，后面是传参
                              "getElementImage",
                              Q_RETURN_ARG(QVariant, rv),
                              Q_ARG(QVariant, QVariant::fromValue(m_currentIndex)));
    imageUrl = rv.toString();

    int lastIndexOfSlash = imageUrl.lastIndexOf('/') + 1;
    fileName = imageUrl.mid(lastIndexOfSlash);

    QMetaObject::invokeMethod(m_sharePage, //调用方法，后面是传参
                              "replaceElement",
                              Q_ARG(QVariant, QVariant::fromValue(m_currentIndex)),
                              Q_ARG(QVariant, QVariant::fromValue(fileName)),
                              Q_ARG(QVariant, QVariant::fromValue(imageUrl)));

    emit refreshSignal();
}

void ActiveCtrl::TakeAFullScreenshot()
{
    QScreen *screen = QGuiApplication::primaryScreen();
    if (!screen) {
        qDebug() << "获取主屏幕错误";
        return;
    }
    qDebug() << screen;
    QPixmap pixmap = screen->grabWindow(0);

    if (pixmap.isNull()) {
        qDebug() << "获取失败！";
        return;
    }

    QString tempPath = QStandardPaths::writableLocation(QStandardPaths::TempLocation);
    if (tempPath.isEmpty()) {
        qDebug() << "获取临时文件路径失败";
        return;
    }
    QString filePath = tempPath + "/screenshot_"
                       + QDateTime::currentDateTime().toString("yyyyMMdd_HHmmss") + ".png";
    if (!pixmap.save(filePath)) {
        qDebug() << "没能成功把路径保存到:" << filePath;
        return;
    }

    filePath = "file://" + filePath;
    int lastIndexOfSlash = filePath.lastIndexOf('/') + 1;
    QString fileName = filePath.mid(lastIndexOfSlash);
    QMetaObject::invokeMethod(m_sharePage, //调用方法，后面是传参
                              "addElement",
                              Q_ARG(QVariant, QVariant::fromValue(fileName)),
                              Q_ARG(QVariant, QVariant::fromValue(filePath)));
}
