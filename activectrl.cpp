/** activectrl.cpp
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: control menu actions
 * Funtion: refresh and TakeAFullScreenshot
 *
 * Modified by RenTianxiang on 2024-6-20
 * Reorganized the logical structure to save and save as
 * Added export finction
 * 
 * Modified by RenTianxiang on 2024-6-21
 * Added the ability to close the picture prompt to save
 *  modified by Zengyan on 2024-6-24
 *  added  verticallyFlip,horizontallyFlip functions
 * 
 * Modified by RenTianxiang on 2024-6-22
 * Added a new exit prompt to save the modified picture
 *
 * Modified by RenTianxiang on 2024-6-24
 *      Finished moving the layer undo and redo
 */
#include "activectrl.h"
#include <QDesktopServices>
#include <QFileInfo>
#include <QGuiApplication>
#include <QJSValue>
#include <QMetaObject>
#include <QPixmap>
#include <QQmlProperty>
#include <QQuickItemGrabResult>
#include <QScreen>
#include <QStandardPaths>
#include <opencv4/opencv2/opencv.hpp>

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
    QObject::disconnect(m_openDialogBox, SIGNAL(accepted()), this, SLOT(openSlot()));
}

void ActiveCtrl::saveAsSlot()
{
    QString savePath = QQmlProperty::read(m_savePathDialod, "selectedFile").toString();
    if (savePath.isEmpty()) {
        qDebug() << "empty savePath!!!";
    } else {
        m_savePath = savePath.mid(7);
        QFileInfo fileInfo(m_savePath);
        QString ext = fileInfo.suffix().toLower();
        std::vector<int> compression_params;
        if (ext == "jpg" || ext == "jpeg") {
            compression_params.push_back(cv::IMWRITE_JPEG_QUALITY);
            compression_params.push_back(95); // JPEG质量 (1-100)
        } else if (ext == "png") {
            compression_params.push_back(cv::IMWRITE_PNG_COMPRESSION);
            compression_params.push_back(3); // PNG压缩级别 (0-9)
        } else if (ext == "bmp") {
            // BMP 不需要额外的参数
        } else {
            // 默认保存为 PNG 格式
            m_savePath += ".png";
            compression_params.push_back(cv::IMWRITE_PNG_COMPRESSION);
            compression_params.push_back(3);
        }
        QQuickItem *quickItem = qobject_cast<QQuickItem *>(m_currentLayer);
        if (quickItem) {
            QSharedPointer<QQuickItemGrabResult> grabResult = quickItem->grabToImage(m_size);
            QObject::connect(grabResult.data(), &QQuickItemGrabResult::ready, [=, this]() {
                QImage image = grabResult->image();
                cv::Mat matImage = QImageToCvMat(image);
                if (cv::imwrite(m_savePath.toStdString(), matImage, compression_params)) {
                    QMetaObject::invokeMethod(m_currentLayer, "setModified", Q_ARG(bool, false));
                    qDebug() << "Save success to: " << m_savePath;

                    int lastIndexOfSlash = m_savePath.lastIndexOf('/') + 1;
                    QString fileName = m_savePath.mid(lastIndexOfSlash);
                    QString a = "pageName";
                    QString b = "pixUrl";
                    QMetaObject::invokeMethod(m_sharePage,
                                              "setProperty",
                                              Q_ARG(int, m_currentIndex),
                                              Q_ARG(QString, a),
                                              Q_ARG(QVariant, QVariant::fromValue(fileName)));

                    QMetaObject::invokeMethod(m_sharePage,
                                              "setProperty",
                                              Q_ARG(int, m_currentIndex),
                                              Q_ARG(QString, b),
                                              Q_ARG(QVariant, QVariant::fromValue(m_savePath)));
                    addRecentFiles(savePath);
                } else {
                    QMetaObject::invokeMethod(m_failToSave, "open", Qt::AutoConnection);
                }
            });
        } else {
            qDebug() << m_currentEditor << " is not a QQuickItem type!!";
        }
    }
    disconnect(m_savePathDialod, SIGNAL(accepted()), this, SLOT(saveAsSlot()));
}

void ActiveCtrl::exportSlot()
{
    QString fileName = QQmlProperty::read(m_exportPathDialog, "selectedFile").toString().mid(7);
    if (fileName.isEmpty()) {
        qDebug() << "empty exportPath!!!";
    } else {
        QFileInfo fileInfo(fileName);
        QString ext = fileInfo.suffix().toLower();
        std::vector<int> compression_params;
        if (ext == "jpg" || ext == "jpeg") {
            compression_params.push_back(cv::IMWRITE_JPEG_QUALITY);
            compression_params.push_back(95); // JPEG质量 (1-100)
        } else if (ext == "png") {
            compression_params.push_back(cv::IMWRITE_PNG_COMPRESSION);
            compression_params.push_back(3); // PNG压缩级别 (0-9)
        } else if (ext == "bmp") {
            // BMP 不需要额外的参数
        } else {
            // 默认保存为 PNG 格式
            fileName += ".png";
            compression_params.push_back(cv::IMWRITE_PNG_COMPRESSION);
            compression_params.push_back(3);
        }

        // 保存图像
        QQuickItem *quickItem = qobject_cast<QQuickItem *>(m_currentLayer);
        if (quickItem) {
            QSharedPointer<QQuickItemGrabResult> grabResult = quickItem->grabToImage(m_size);
            QObject::connect(grabResult.data(), &QQuickItemGrabResult::ready, [=, this]() {
                QImage image = grabResult->image();
                cv::Mat matImage = QImageToCvMat(image);
                if (cv::imwrite(fileName.toStdString(), matImage, compression_params)) {
                    QMetaObject::invokeMethod(m_currentLayer, "setModified", Q_ARG(bool, false));
                    qDebug() << "Save success to: " << fileName;
                } else {
                    QMetaObject::invokeMethod(m_failToSave, "open", Qt::AutoConnection);
                }
            });
        } else {
            qDebug() << m_currentEditor << " is not a QQuickItem type!!";
        }
    }
}

//询问保存修改后，用户选择保存的处理逻辑
void ActiveCtrl::askSave_saveSlot()
{
    connect(
        this,
        &ActiveCtrl::saved,
        this,
        [=, this]() {
            QMetaObject::invokeMethod(m_sharePage,
                                      "removeElement",
                                      Q_ARG(QVariant, QVariant::fromValue(m_currentIndex)),
                                      Q_ARG(QVariant, QVariant::fromValue(1)));
            disconnect(m_askSaveDialog, SIGNAL(saveClicked()), this, SLOT(askSave_saveSlot()));
            disconnect(m_askSaveDialog, SIGNAL(discardClicked()), this, SLOT(askSave_discardSlot()));
            disconnect(m_askSaveDialog, SIGNAL(cancelClicked()), this, SLOT(askSave_cancelSlot()));
            emit closed();
        },
        Qt::SingleShotConnection);
    save();
}

//询问保存修改后，用户选择不保存的处理逻辑
void ActiveCtrl::askSave_discardSlot()
{
    QMetaObject::invokeMethod(m_sharePage,
                              "removeElement",
                              Q_ARG(QVariant, QVariant::fromValue(m_currentIndex)),
                              Q_ARG(QVariant, QVariant::fromValue(1)));

    disconnect(m_askSaveDialog, SIGNAL(saveClicked()), this, SLOT(askSave_saveSlot()));
    disconnect(m_askSaveDialog, SIGNAL(discardClicked()), this, SLOT(askSave_discardSlot()));
    disconnect(m_askSaveDialog, SIGNAL(cancelClicked()), this, SLOT(askSave_cancelSlot()));
    emit closed();
}

void ActiveCtrl::askSave_cancelSlot()
{
    disconnect(this, &ActiveCtrl::closeAlled, this, &ActiveCtrl::exitSlot);
    disconnect(m_askSaveDialog, SIGNAL(saveClicked()), this, SLOT(askSave_saveSlot()));
    disconnect(m_askSaveDialog, SIGNAL(discardClicked()), this, SLOT(askSave_discardSlot()));
    disconnect(m_askSaveDialog, SIGNAL(cancelClicked()), this, SLOT(askSave_cancelSlot()));
    disconnect(this, &ActiveCtrl::closed, this, &ActiveCtrl::closeAllSlot);
}

void ActiveCtrl::closeAllSlot()
{
    closeAll();
}
QObject *ActiveCtrl::flip() const
{
    return m_flip;
}

void ActiveCtrl::setFlip(QObject *newFlip)
{
    if (m_flip == newFlip)
        return;
    m_flip = newFlip;
    emit flipChanged();
}

int ActiveCtrl::XScale() const
{
    return m_XScale;
}

void ActiveCtrl::setXScale(int newXScale)
{
    if (m_XScale == newXScale)
        return;
    m_XScale = newXScale;
    emit XScaleChanged();
}

int ActiveCtrl::YScale() const
{
    return m_YScale;
}

void ActiveCtrl::setYScale(int newYScale)
{
    if (m_YScale == newYScale)
        return;
    m_YScale = newYScale;
    emit YScaleChanged();
}
void ActiveCtrl::exitSlot()
{
    QCoreApplication::exit();
}

QObject *ActiveCtrl::askSaveDialog() const
{
    return m_askSaveDialog;
}

void ActiveCtrl::setAskSaveDialog(QObject *newAskSaveDialog)
{
    if (m_askSaveDialog == newAskSaveDialog)
        return;
    m_askSaveDialog = newAskSaveDialog;
    emit askSaveDialogChanged();
}

QObject *ActiveCtrl::exportPathDialog() const
{
    return m_exportPathDialog;
}

void ActiveCtrl::setExportPathDialog(QObject *newExportPathDialog)
{
    if (m_exportPathDialog == newExportPathDialog)
        return;
    m_exportPathDialog = newExportPathDialog;
    emit exportPathDialogChanged();
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
    QMetaObject::invokeMethod(m_openDialogBox, "open", Qt::AutoConnection);
    QObject::connect(m_openDialogBox, SIGNAL(accepted()), this, SLOT(openSlot()));
}

void ActiveCtrl::newImage()
{
    QMetaObject::invokeMethod(m_newDialogBox, "open", Qt::AutoConnection);
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
                    QMetaObject::invokeMethod(m_currentLayer, "setModified", Q_ARG(bool, false));
                    qDebug() << "Save success to: " << m_savePath;
                    emit saved();
                } else {
                    QMetaObject::invokeMethod(m_failToSave, "open", Qt::AutoConnection);
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
    QMetaObject::invokeMethod(m_savePathDialod, "open", Qt::DirectConnection);
    connect(m_savePathDialod, SIGNAL(accepted()), this, SLOT(saveAsSlot()));
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

void ActiveCtrl::verticallyFlip()
{
    if (m_YScale == 1)
        m_flip->setProperty("yScale", -1);
    else
        m_flip->setProperty("yScale", 1);
}

void ActiveCtrl::horizontallyFlip()
{
    if (m_XScale == 1)
        m_flip->setProperty("xScale", -1);
    else
        m_flip->setProperty("xScale", 1);
}

void ActiveCtrl::yScaleState(int yScale)
{
    m_YScale = yScale;
}

void ActiveCtrl::xScaleState(int xScale)
{
    m_XScale = xScale;
}

void ActiveCtrl::close()
{
    if (!m_sharePage) {
        return;
    }
    if (m_currentIndex != -1) {
        if (m_modified) {
            connect(m_askSaveDialog, SIGNAL(saveClicked()), this, SLOT(askSave_saveSlot()));
            connect(m_askSaveDialog, SIGNAL(discardClicked()), this, SLOT(askSave_discardSlot()));
            connect(m_askSaveDialog, SIGNAL(cancelClicked()), this, SLOT(askSave_cancelSlot()));
            QMetaObject::invokeMethod(m_askSaveDialog, "openDialog", Qt::DirectConnection);
            return;
        } else {
            QMetaObject::invokeMethod(m_sharePage,
                                      "removeElement",
                                      Q_ARG(QVariant, QVariant::fromValue(m_currentIndex)),
                                      Q_ARG(QVariant, QVariant::fromValue(1)));
            emit closed();
            return;
        }
    } else {
        qDebug() << "关闭失败!";
        return;
    }
}

void ActiveCtrl::closeAll()
{
    if (!m_sharePage) {
        return;
    }
    int num = QQmlProperty::read(m_sharePage, "count").toInt();
    if (num == 0) {
        emit closeAlled();
        return;
    }
    connect(this, &ActiveCtrl::closed, this, &ActiveCtrl::closeAllSlot, Qt::SingleShotConnection);
    close();
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

void ActiveCtrl::takeAFullScreenshot()
{
    QScreen *screen = QGuiApplication::primaryScreen();
    if (!screen) {
        qDebug() << "获取主屏幕错误";
        return;
    }
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
    QString fileName = "untitled";
    QMetaObject::invokeMethod(m_sharePage, //调用方法，后面是传参
                              "addElement",
                              Q_ARG(QVariant, QVariant::fromValue(fileName)),
                              Q_ARG(QVariant, QVariant::fromValue(filePath)));
}
void ActiveCtrl::exportImage()
{
    m_exportPathDialog->metaObject()->invokeMethod(m_exportPathDialog, "open", Qt::DirectConnection);

    connect(m_exportPathDialog, SIGNAL(accepted()), this, SLOT(exportSlot()));
}

void ActiveCtrl::exitWindow()
{
    connect(this, &ActiveCtrl::closeAlled, this, &ActiveCtrl::exitSlot);
    closeAll();
}

//撤销
void ActiveCtrl::undo()
{
    if (!m_currentLayer) {
        return;
    }
    QVariant index;
    QMetaObject::invokeMethod(m_currentLayer, "undoStackPop", qReturnArg(index));
    QVariant actionAndParams;
    QMetaObject::invokeMethod(m_currentLayer,
                              "getUndoActionAndParams",
                              qReturnArg(actionAndParams),
                              Q_ARG(QVariant, index));

    if (actionAndParams.isNull()) {
        return;
    }

    OperationType action;
    QVariantMap params;
    if (actionAndParams.isValid() && actionAndParams.canConvert(QMetaType::QVariantMap)) {
        QVariantMap map = actionAndParams.toMap();
        action = static_cast<OperationType>(map["action"].toInt());
        params = map["params"].toMap();
    }

    switch (action) {
    case AddLayer:
        if (index.toInt() == 0) {
            break;
        }
        QMetaObject::invokeMethod(m_currentLayer, "removeLayer", Q_ARG(QVariant, index));
        break;
    case MoveLayer:
        QMetaObject::invokeMethod(m_currentLayer,
                                  "moveLayer",
                                  Q_ARG(QVariant, index),
                                  Q_ARG(QVariant, params["oldX"]),
                                  Q_ARG(QVariant, params["oldY"]));
        break;
    default:
        qDebug() << action;
    }
}

//重做
void ActiveCtrl::redo()
{
    if (!m_currentLayer) {
        return;
    }
    QVariant index;
    QMetaObject::invokeMethod(m_currentLayer, "redoStackPop", qReturnArg(index));

    if (index.toInt() == -2) //上一次撤销是删除图层的操作  特殊处理
    {
        QMetaObject::invokeMethod(m_currentLayer, "deletedStackPop", Qt::AutoConnection);
    } else {
        QVariant actionAndParams;
        QMetaObject::invokeMethod(m_currentLayer,
                                  "getRedoActionAndParams",
                                  qReturnArg(actionAndParams),
                                  Q_ARG(QVariant, index));
        if (actionAndParams.isNull()) {
            return;
        }

        OperationType action;
        QVariantMap params;
        if (actionAndParams.isValid() && actionAndParams.canConvert(QMetaType::QVariantMap)) {
            QVariantMap map = actionAndParams.toMap();
            action = static_cast<OperationType>(map["action"].toInt());
            params = map["params"].toMap();
        }

        switch (action) {
        case MoveLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "moveLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["newX"]),
                                      Q_ARG(QVariant, params["newY"]));
            break;
        default:
            qDebug() << action;
        }
    }
}

cv::Mat ActiveCtrl::QImageToCvMat(const QImage &image)
{
    cv::Mat mat;
    switch (image.format()) {
    case QImage::Format_ARGB32:
    case QImage::Format_ARGB32_Premultiplied:
        mat = cv::Mat(image.height(),
                      image.width(),
                      CV_8UC4,
                      const_cast<uchar *>(image.bits()),
                      image.bytesPerLine());
        cv::cvtColor(mat, mat, cv::COLOR_RGB2BGR); // 转换颜色通道顺序
        break;
    case QImage::Format_RGB32:
        mat = cv::Mat(image.height(),
                      image.width(),
                      CV_8UC4,
                      const_cast<uchar *>(image.bits()),
                      image.bytesPerLine());
        cv::cvtColor(mat, mat, cv::COLOR_RGB2BGR); // 转换颜色通道顺序
        break;
    case QImage::Format_RGB888:
        mat = cv::Mat(image.height(),
                      image.width(),
                      CV_8UC3,
                      const_cast<uchar *>(image.bits()),
                      image.bytesPerLine());
        cv::cvtColor(mat, mat, cv::COLOR_RGB2BGR); // 转换颜色通道顺序
        break;
    case QImage::Format_Grayscale8:
        mat = cv::Mat(image.height(),
                      image.width(),
                      CV_8UC1,
                      const_cast<uchar *>(image.bits()),
                      image.bytesPerLine());
        break;
    case QImage::Format_RGBA8888_Premultiplied:
        mat = cv::Mat(image.height(),
                      image.width(),
                      CV_8UC4,
                      const_cast<uchar *>(image.bits()),
                      image.bytesPerLine());
        cv::cvtColor(mat, mat, cv::COLOR_RGB2BGR); // 转换颜色通道顺序
        break;
    default:
        qDebug() << "QImage format not supported for conversion to cv::Mat:" << image.format();
        break;
    }
    return mat;
}
