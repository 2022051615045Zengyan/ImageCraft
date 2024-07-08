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
 *      
 *Modified by RenTianxiang on 2024-6-25
 *      Zoom and Settings invisible undo and redo completed
 *  Modified by Zengyan on 2024-6-25
 * added rotation function
 *  Modified by Zengyan on 2024-6-26
 * added uesr-defined rotation function
 * 
 * Modified by RenTianxiang on 2024-7-6
 *      Finished modified the layer and remove the layer undo and redo
 *      added remove layer
 * modified by Zengyan on 2024-7-8
 * finished maintoolBar,lefttoolBar...status changes
 * added convertToMonochromeDithered,convertToGray,applyGaussianBlur,oppositedColor function
 */
#include "activectrl.h"
#include <QDesktopServices>
#include <QFileInfo>
#include <QGuiApplication>
#include <QJSValue>
#include <QMetaObject>
#include <QPainter>
#include <QPixmap>
#include <QQmlProperty>
#include <QQuickItemGrabResult>
#include <QScreen>
#include <QStandardPaths>
#include <QtTypes>
#include <opencv4/opencv2/core.hpp>
#include <opencv4/opencv2/imgproc.hpp>
#include <opencv4/opencv2/opencv.hpp>
#include <opencv4/opencv2/xphoto.hpp>

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
                    QMetaObject::invokeMethod(m_currentLayer, "setModified", Q_ARG(QVariant, false));
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
                    QMetaObject::invokeMethod(m_currentLayer, "setModified", Q_ARG(QVariant, false));
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

QObject *ActiveCtrl::toolBar() const
{
    return m_toolBar;
}

void ActiveCtrl::setToolBar(QObject *newToolBar)
{
    if (m_toolBar == newToolBar)
        return;
    m_toolBar = newToolBar;
    emit toolBarChanged();
}

QObject *ActiveCtrl::footer() const
{
    return m_footer;
}

void ActiveCtrl::setFooter(QObject *newFooter)
{
    if (m_footer == newFooter)
        return;
    m_footer = newFooter;
    emit footerChanged();
}

int ActiveCtrl::lcenterHeight() const
{
    return m_lcenterHeight;
}

void ActiveCtrl::setLcenterHeight(int newLcenterHeight)
{
    if (m_lcenterHeight == newLcenterHeight)
        return;
    m_lcenterHeight = newLcenterHeight;
    emit lcenterHeightChanged();
}

int ActiveCtrl::lcenterWidth() const
{
    return m_lcenterWidth;
}

void ActiveCtrl::setLcenterWidth(int newLcenterWidth)
{
    if (m_lcenterWidth == newLcenterWidth)
        return;
    m_lcenterWidth = newLcenterWidth;
    emit lcenterWidthChanged();
}

QObject *ActiveCtrl::rightMenu() const
{
    return m_rightMenu;
}

void ActiveCtrl::setRightMenu(QObject *newRightMenu)
{
    if (m_rightMenu == newRightMenu)
        return;
    m_rightMenu = newRightMenu;
    emit rightMenuChanged();
}

QObject *ActiveCtrl::rotationDialogBox() const
{
    return m_rotationDialogBox;
}

void ActiveCtrl::setRotationDialogBox(QObject *newRotationDialogBox)
{
    if (m_rotationDialogBox == newRotationDialogBox)
        return;
    m_rotationDialogBox = newRotationDialogBox;
    emit rotationDialogBoxChanged();
}

double ActiveCtrl::anglenum() const
{
    return m_anglenum;
}

void ActiveCtrl::setAnglenum(double newAnglenum)
{
    if (qFuzzyCompare(m_anglenum, newAnglenum))
        return;
    m_anglenum = newAnglenum;
    emit anglenumChanged();
}

QObject *ActiveCtrl::currentImageView() const
{
    return m_currentImageView;
}

void ActiveCtrl::setCurrentImageView(QObject *newCurrentImageView)
{
    if (m_currentImageView == newCurrentImageView)
        return;
    m_currentImageView = newCurrentImageView;
    emit currentImageViewChanged();
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
    m_originalImage = QImage();
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
                    QMetaObject::invokeMethod(m_currentLayer, "setModified", Q_ARG(QVariant, false));
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

void ActiveCtrl::getAngle(double angle)
{
    m_anglenum = angle;
}

void ActiveCtrl::openDialog()
{
    QMetaObject::invokeMethod(m_rotationDialogBox, "open", Qt::AutoConnection);
}

void ActiveCtrl::rotation(const QString &rotationstyle, double rotationangle)
{
    if (!m_currentImageView)
        return;
    if (rotationstyle == "Turn anticlockwise")
        m_anglenum = m_anglenum - rotationangle;
    else
        m_anglenum = m_anglenum + rotationangle;
    m_currentImageView->setProperty("currentAngle", m_anglenum);
}

void ActiveCtrl::leftRotation()
{
    m_anglenum = m_anglenum + 90;
    qDebug() << m_anglenum;
    m_currentImageView->setProperty("currentAngle", m_anglenum);
}

void ActiveCtrl::rightRotation()
{
    m_anglenum = m_anglenum - 90;
    m_currentImageView->setProperty("currentAngle", m_anglenum);
}

void ActiveCtrl::verticallyFlip()
{
    int yScale = QQmlProperty::read(m_flip, "yScale").toInt();
    yScale = -yScale;
    m_flip->setProperty("yScale", yScale);
}

void ActiveCtrl::horizontallyFlip()
{
    int xScale = QQmlProperty::read(m_flip, "xScale").toInt();
    xScale = -xScale;
    m_flip->setProperty("xScale", xScale);
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

void ActiveCtrl::popRightMenu(QVariant x, QVariant y)
{
    m_rightMenu->setProperty("x", x);
    m_rightMenu->setProperty("y", y);
    QMetaObject::invokeMethod(m_rightMenu, "show", Qt::AutoConnection);
}

void ActiveCtrl::deleteLayer()
{
    if (!m_currentImageView || !m_currentLayer) {
        return;
    }
    QVariant key = QQmlProperty::read(m_currentImageView, "key");
    QVariant index;
    QMetaObject::invokeMethod(m_currentLayer,
                              "findIndexBykey",
                              qReturnArg(index),
                              Q_ARG(QVariant, key));
    QVariant oldModified = QQmlProperty::read(m_currentLayer, "oldModified").toBool();
    QVariant newModified = QQmlProperty::read(m_currentLayer, "newModified").toBool();
    QMetaObject::invokeMethod(m_currentLayer,
                              "saveKeyAndModified",
                              Q_ARG(QVariant, key),
                              Q_ARG(QVariant, oldModified),
                              Q_ARG(QVariant, newModified));

    QMetaObject::invokeMethod(m_currentImageView, "modified", Qt::AutoConnection);
    QVariant flag = true;
    QMetaObject::invokeMethod(m_currentLayer,
                              "removeLayer",
                              Q_ARG(QVariant, index),
                              Q_ARG(QVariant, flag));
    qDebug() << index << key;
}

//撤销
void ActiveCtrl::undo()
{
    if (!m_currentLayer) {
        return;
    }
    QVariant index;
    QMetaObject::invokeMethod(m_currentLayer, "undoStackPop", qReturnArg(index));

    if (index.toInt() == -2) //上一次撤销是删除图层的操作  特殊处理
    {
        QVariant flag = true;
        QMetaObject::invokeMethod(m_currentLayer, "deletedStackPop", Q_ARG(QVariant, flag));
    } else {
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
        case AddLayer: {
            if (index.toInt() == 0) {
                break;
            }
            QVariant flag = false;
            QMetaObject::invokeMethod(m_currentLayer,
                                      "removeLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, flag));
            break;
        }
        case MoveLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "moveLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["oldX"]),
                                      Q_ARG(QVariant, params["oldY"]));
            break;
        case ScaleLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "scaleLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["oldScale"]));
            break;
        case VisibleLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "setVisibleLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["visible"]));
            break;
        case FlipXLayer: {
            int xScale = params["xScale"].toInt();
            QVariant variantXScale = -xScale;
            QMetaObject::invokeMethod(m_currentLayer,
                                      "flipXLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, variantXScale));
            break;
        }
        case FlipYLayer: {
            int yScale = params["yScale"].toInt();
            QVariant variantYScale = -yScale;
            QMetaObject::invokeMethod(m_currentLayer,
                                      "flipYLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, variantYScale));
            break;
        }
        case SpinLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "spinLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["oldAngle"]));
            break;
        case ModifiedLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "modifiedLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["oldImage"]));
            break;
        default:
            qDebug() << action;
            break;
        }
    }
}

//重做
void ActiveCtrl::redo()
{
    if (!m_currentLayer || !m_currentImageView) {
        return;
    }
    QVariant index;
    QMetaObject::invokeMethod(m_currentLayer, "redoStackPop", qReturnArg(index));

    if (index.toInt() == -2) //上一次撤销是删除图层的操作  特殊处理
    {
        QVariant flag = false;
        QMetaObject::invokeMethod(m_currentLayer, "deletedStackPop", Q_ARG(QVariant, flag));
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
        case ScaleLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "scaleLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["newScale"]));
            break;
        case VisibleLayer: {
            bool visible = params["visible"].toBool();
            QVariant variantVisible = !visible;
            QMetaObject::invokeMethod(m_currentLayer,
                                      "setVisibleLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, variantVisible));
            break;
        }
        case FlipXLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "flipXLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["xScale"]));
            break;
        case FlipYLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "flipYLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["yScale"]));
            break;
        case SpinLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "spinLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["newAngle"]));
            break;
        case ModifiedLayer:
            QMetaObject::invokeMethod(m_currentLayer,
                                      "modifiedLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, params["newImage"]));
            break;
        case ReMoveLayer: {
            QMetaObject::invokeMethod(m_currentImageView, "popUndoStack", Qt::AutoConnection);
            QVariant flag = true;
            QMetaObject::invokeMethod(m_currentLayer,
                                      "removeLayer",
                                      Q_ARG(QVariant, index),
                                      Q_ARG(QVariant, flag));
            break;
        }
        default:
            qDebug() << action;
            break;
        }
    }
}

void ActiveCtrl::oppositedColor()
{
    if (m_currentEditor) {
        QImage invertedImage(m_currentEditor->image());

        for (int y = 0; y < invertedImage.height(); ++y) {
            for (int x = 0; x < invertedImage.width(); ++x) {
                QRgb pixel = invertedImage.pixel(x, y);
                invertedImage.setPixel(x,
                                       y,
                                       qRgb(255 - qRed(pixel),
                                            255 - qGreen(pixel),
                                            255 - qBlue(pixel)));
            }
        }

        m_currentEditor->setImage(invertedImage);
    }
}

void ActiveCtrl::convertToGray()
{
    if (m_currentEditor) {
        QImage grayImage(m_currentEditor->image().size(), QImage::Format_Grayscale8);
        QPainter painter(&grayImage);
        painter.drawImage(0, 0, m_currentEditor->image());
        painter.end();
        m_currentEditor->setImage(grayImage);
    }
}

void ActiveCtrl::convertToMonochromeDithered()
{
    if (m_currentEditor) {
        QImage monoImage(m_currentEditor->image().size(), QImage::Format_Mono);
        QPainter painter(&monoImage);
        painter.drawImage(0, 0, m_currentEditor->image().convertToFormat(QImage::Format_Mono));
        m_currentEditor->setImage(monoImage);
    }
}

void ActiveCtrl::applyGaussianBlur()
{
    if (m_currentEditor) {
        QImage inputImage(m_currentEditor->image());
        // Convert QImage to Mat
        cv::Mat inputMat = QImageToCvMat(inputImage);
        // Apply Gaussian blur using OpenCV
        cv::Mat blurredMat;
        int radius = 25;
        cv::GaussianBlur(inputMat,
                         blurredMat,
                         cv::Size(2 * radius + 1, 2 * radius + 1),
                         radius / 2.0);

        // Convert Mat back to QImage
        QImage outputImage = matToQImage(blurredMat);
        m_currentEditor->setImage(outputImage);
    }
}

void ActiveCtrl::footerVisible()
{
    if (m_footer) {
        bool vis = m_footer->property("statusvisible").value<bool>();
        if (vis)
            m_footer->setProperty("statusvisible", false);
        else
            m_footer->setProperty("statusvisible", true);
    }
}

void ActiveCtrl::lefttoolbarDisplay()
{
    if (m_toolBar) {
        bool vis = m_toolBar->property("toolbarvisible").value<bool>();
        if (vis) {
            m_toolBar->setProperty("toolbarvisible", false);
        } else {
            m_toolBar->setProperty("toolbarvisible", true);
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

QImage ActiveCtrl::matToQImage(const cv::Mat &mat)
{
    // Convert the OpenCV Mat to QImage
    QImage image(mat.cols, mat.rows, QImage::Format_RGB888);
    uchar *data = image.bits();
    int channels = mat.channels();
    for (int y = 0; y < mat.rows; ++y) {
        uchar *row_ptr = const_cast<uchar *>(mat.ptr<const uchar>(y));
        for (int x = 0; x < mat.cols; ++x) {
            for (int c = 0; c < channels; ++c) {
                data[y * mat.cols * channels + x * channels + c] = row_ptr[x * channels + c];
            }
        }
    }
    return image;
}
QImage ActiveCtrl::CvMatToQImage(const cv::Mat &mat)
{
    cv::Mat matRGBA;
    cv::cvtColor(mat, matRGBA, cv::COLOR_BGR2BGRA);
    return QImage(matRGBA.data, matRGBA.cols, matRGBA.rows, matRGBA.step, QImage::Format_RGBA8888);
}

ActiveCtrl::Filter ActiveCtrl::getCurrentFilter() const
{
    return m_currentFilter;
}

void ActiveCtrl::setCurrentFilter(ActiveCtrl::Filter newCurrentFilter)
{
    if (m_currentFilter == newCurrentFilter)
        return;
    m_currentFilter = newCurrentFilter;
    emit currentFilterChanged();
}

//浮雕效果
void ActiveCtrl::applyEmbossFilter()
{
    m_currentFilter = EmbossFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat gray, dst;
        cv::cvtColor(srcMat, gray, cv::COLOR_BGR2GRAY);
        //定义浮雕效果的卷积核
        cv::Mat kernel = (cv::Mat_<float>(3, 3) << -2, -1, 0, -1, 1, 1, 0, 1, 2);
        //对灰度图像应用卷积核
        cv::filter2D(gray, dst, CV_32F, kernel);
        //结果归一化到0-255范围
        cv::normalize(dst, dst, 0, 255, cv::NORM_MINMAX, CV_8U);
        cv::cvtColor(dst, dst, cv::COLOR_GRAY2BGR);

        QImage resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyOilPaintFilter()
{
    m_currentFilter = OilPaintFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dstMat;
        cv::xphoto::oilPainting(srcMat,
                                dstMat,
                                5,
                                2.5); //邻域大小(越大越模糊），动态比例应该是色彩的交叠程度）
        // 调整颜色，更贴合原图颜色
        cv::Mat correctedMat, srcLab;
        cv::cvtColor(dstMat, correctedMat, cv::COLOR_BGR2Lab);
        cv::cvtColor(srcMat, srcLab, cv::COLOR_BGR2Lab);

        std::vector<cv::Mat> channels;
        cv::split(correctedMat, channels);
        std::vector<cv::Mat> srcChannels;
        cv::split(srcLab, srcChannels);

        // 使用原图的 a 和 b 通道替换油画滤镜结果的 a 和 b 通道
        channels[1] = srcChannels[1];
        channels[2] = srcChannels[2];

        cv::merge(channels, correctedMat);
        cv::cvtColor(correctedMat, dstMat, cv::COLOR_Lab2BGR);

        QImage resultImage = CvMatToQImage(dstMat);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyOverexposureFilter()
{
    m_currentFilter = OilPaintFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dstMat;
        srcMat.convertTo(dstMat, -1, 1.5, 50);
        QImage resultImage = CvMatToQImage(dstMat);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyDiffusionFilter()
{
    m_currentFilter = DiffusionFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dstMat = srcMat.clone();
        int radius = 5; // 扩散半径，可调节大小以改变扩散效果
        // 确保随机数生成器的种子值唯一
        std::srand(std::time(nullptr));
        // 遍历每个像素并随机选择一个相邻的像素值
        for (int y = 0; y < srcMat.rows; y++) {
            for (int x = 0; x < srcMat.cols; x++) {
                int randX = x + (std::rand() % (2 * radius + 1)) - radius;
                int randY = y + (std::rand() % (2 * radius + 1)) - radius;
                // 确保随机坐标在图像边界内
                randX = std::min(std::max(randX, 0), srcMat.cols - 1);
                randY = std::min(std::max(randY, 0), srcMat.rows - 1);
                dstMat.at<cv::Vec3b>(y, x) = srcMat.at<cv::Vec3b>(randY, randX);
            }
        }
        QImage resultImage = CvMatToQImage(dstMat);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyGaussianBlurFilter()
{
    m_currentFilter = GaussianBlurFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dst;

        // 应用高斯模糊
        int kernelSize = 15; // 可以调整这个值来改变模糊的强度
        double sigmaX = 0;   // 计算高斯核的标准差。如果为0它会自动计算
        cv::GaussianBlur(srcMat, dst, cv::Size(kernelSize, kernelSize), sigmaX);

        QImage resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyMotionBlurFilter()
{
    m_currentFilter = MotionBlurFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dst;

        // 动感模糊卷积核
        int kernelSize = 15; // 可以调整这个值来改变模糊的强度
        cv::Mat kernel = cv::Mat::zeros(kernelSize, kernelSize, CV_32F);
        for (int i = 0; i < kernelSize; ++i) {
            kernel.at<float>(i, i) = 1.0 / kernelSize;
        }

        // 应用动感模糊卷积核
        cv::filter2D(srcMat, dst, -1, kernel);

        QImage resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyEnhancedBlurFilter()
{
    m_currentFilter = EnhancedBlurFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    cv::Mat dst;
    QImage resultImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        // 多次更强烈的高斯模糊来模拟进一步模糊
        for (int i = 0; i < 3; i++) {
            cv::GaussianBlur(srcMat, dst, cv::Size(31, 31), 0);
        }
        resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    resultImage = CvMatToQImage(dst);
    m_currentEditor->setImage(resultImage);
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyLensBlurFilter()
{
    m_currentFilter = LensBlurFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        dst = srcMat.clone(); // Clone srcMat to dst
        // 中心点和模糊强度
        cv::Point center(srcMat.cols / 2, srcMat.rows / 2);
        int strength = 15; // 模糊强度，可以根据需要调整
        // 创建径向模糊效果
        for (int i = 0; i < strength; ++i) {
            double alpha = (double) i / strength;
            cv::addWeighted(srcMat, alpha, dst, 1 - alpha, 0, dst); // Update dst in-place
        }
        resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
        emit m_currentEditor->imageStatusChanged();
    }
}

void ActiveCtrl::applyWaveFilter()
{
    m_currentFilter = WaveFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dst = srcMat.clone();
        // 波浪效果参数
        int waveLength = 20; // 波长
        int amplitude = 15;  // 振幅
        // 应用波浪效果
        for (int y = 0; y < srcMat.rows; ++y) {
            for (int x = 0; x < srcMat.cols; ++x) {
                int newX = x + amplitude * sin(2 * CV_PI * y / waveLength);
                int newY = y + amplitude * sin(2 * CV_PI * x / waveLength);
                if (newX >= 0 && newX < srcMat.cols && newY >= 0 && newY < srcMat.rows) {
                    dst.at<cv::Vec3b>(newY, newX) = srcMat.at<cv::Vec3b>(y, x);
                }
            }
        }
        QImage resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyRippleFilter()
{
    m_currentFilter = RippleFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dst = srcMat.clone();
        // 波纹效果参数
        double amplitude = 20.0; // 振幅
        double frequency = 20.0; // 频率
        // 应用水平波纹效果
        for (int y = 0; y < srcMat.rows; ++y) {
            for (int x = 0; x < srcMat.cols; ++x) {
                int newX = x + amplitude * sin(2 * CV_PI * y / frequency);
                int newY = y;

                if (newX >= 0 && newX < srcMat.cols) {
                    dst.at<cv::Vec3b>(newY, newX) = srcMat.at<cv::Vec3b>(y, x);
                }
            }
        }
        QImage resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applySqueezeFilter()
{
    m_currentFilter = SqueezeFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dst = srcMat.clone();
        double factor = 0.2; // 挤压因子，调整挤压的强度
        int centerX = srcMat.cols / 2;
        int squeezeWidth = srcMat.cols * factor;
        for (int y = 0; y < srcMat.rows; ++y) {
            for (int x = 0; x < srcMat.cols; ++x) {
                int newX;
                if (x < centerX) {
                    newX = x + static_cast<int>(factor * x);
                } else {
                    newX = x + static_cast<int>(factor * (x - srcMat.cols));
                }
                if (newX >= 0 && newX < srcMat.cols) {
                    dst.at<cv::Vec3b>(y, newX) = srcMat.at<cv::Vec3b>(y, x);
                }
            }
        }
        QImage resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyShearFilter()
{
    m_currentFilter = ShearFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        dst = srcMat.clone();
        // 定义仿射变换矩阵
        cv::Mat M = cv::Mat::eye(2, 3, CV_32F);
        // 设置切变方向和切变因子
        int shearDirection = 0;   // 选择沿x轴正向切变
        float shearFactor = 0.2f; // 设置切变因子
        // 根据切变方向设置仿射变换参数
        switch (shearDirection) {
        case 0: // 沿x轴正向切变
            M.at<float>(0, 1) = shearFactor;
            break;
        case 1: // 沿x轴负向切变
            M.at<float>(0, 1) = -shearFactor;
            break;
        case 2: // 沿y轴正向切变
            M.at<float>(1, 0) = shearFactor;
            break;
        case 3: // 沿y轴负向切变
            M.at<float>(1, 0) = -shearFactor;
            break;
        }
        // 应用仿射变换
        cv::warpAffine(srcMat, dst, M, srcMat.size());

        // 转换为QImage并设置给编辑器
        resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }

    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyWaterRippleFilter()
{
    m_currentFilter = WaterRippleFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        dst = srcMat.clone();
        // 定义水波参数
        float amplitude = 10.0f; // 振幅
        float frequency = 0.1f;  // 频率
        float phaseShift = 0.0f; // 相位偏移
        // 创建和初始化输出图像
        dst = cv::Mat::zeros(srcMat.size(), srcMat.type());
        // 循环遍历图像每个像素，模拟波动效果
        for (int i = 0; i < dst.rows; ++i) {
            for (int j = 0; j < dst.cols; ++j) {
                // 计算波浪效果的偏移量
                float offset_x = amplitude * sin(2 * CV_PI * i * frequency + phaseShift);
                float offset_y = amplitude * cos(2 * CV_PI * j * frequency + phaseShift);
                // 计算波浪后的像素位置
                int new_i = i + offset_x;
                int new_j = j + offset_y;
                if (new_i >= 0 && new_i < srcMat.rows && new_j >= 0 && new_j < srcMat.cols) {
                    dst.at<cv::Vec3b>(i, j) = srcMat.at<cv::Vec3b>(new_i, new_j);
                }
            }
        }
        resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }

    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyUSMSharpeningFilter()
{
    m_currentFilter = USMSharpeningFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);

        // 先高斯模糊
        cv::Mat blurred;
        double sigma = 1.5; // Adjust sigma value as needed
        cv::GaussianBlur(srcMat, blurred, cv::Size(0, 0), sigma);
        // 计算细节图像
        cv::Mat detailImage = srcMat - blurred;
        // 把细节图像乘增强因子，得到锐化后的图片
        double k = 1.5;
        cv::Mat sharpened = srcMat + k * detailImage;
        cv::normalize(sharpened, sharpened, 0, 255, cv::NORM_MINMAX);
        resultImage = CvMatToQImage(sharpened);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyEdgeSharpeningFilter()
{
    m_currentFilter = EdgeSharpeningFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        //转换为灰度图片
        cv::Mat gray;
        cv::cvtColor(srcMat, gray, cv::COLOR_BGR2GRAY);
        //应用拉普拉斯算子检测图片边缘
        cv::Mat edges;
        cv::Laplacian(gray, edges, CV_16S, 3);
        cv::convertScaleAbs(edges, edges);
        // 把边缘转换为BGR格式
        cv::Mat edgesBGR;
        cv::cvtColor(edges, edgesBGR, cv::COLOR_GRAY2BGR);
        // 添加边缘到原图
        cv::Mat sharpened = srcMat + edgesBGR;
        resultImage = CvMatToQImage(sharpened);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyStabilizationFilter()
{
    m_currentFilter = StabilizationFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        //用平滑的高斯模糊减少噪点
        cv::GaussianBlur(srcMat, dst, cv::Size(5, 5), 0);
        resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }

    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyPixelationFilter()
{
    m_currentFilter = PixelationFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        dst = srcMat.clone();
        int blockSize = 5; // 彩块大小，根据需要调整
        for (int y = 0; y < srcMat.rows; y += blockSize) {
            for (int x = 0; x < srcMat.cols; x += blockSize) {
                // 计算当前块的平均颜色
                cv::Rect rect(x, y, blockSize, blockSize);
                rect = rect & cv::Rect(0, 0, srcMat.cols, srcMat.rows); // 确保不越界
                cv::Mat block = srcMat(rect);
                cv::Scalar avgColor = cv::mean(block);
                // 将平均颜色填充到当前块中
                dst(rect).setTo(avgColor);
            }
        }
        resultImage = CvMatToQImage(dst);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyCrystallizeFilter()
{
    m_currentFilter = CrystallizeFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    QImage resultImage;
    cv::Mat dst;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        dst = srcMat.clone();

        int cellSize = 20; // 晶格大小，可以根据需要调整
        for (int y = 0; y < srcMat.rows; y += cellSize) {
            for (int x = 0; x < srcMat.cols; x += cellSize) {
                // 计算当前晶格的中心点
                int centerX = x + cellSize / 2;
                int centerY = y + cellSize / 2;
                // 确保中心点在图像边界内
                if (centerX >= srcMat.cols)
                    centerX = srcMat.cols - 1;
                if (centerY >= srcMat.rows)
                    centerY = srcMat.rows - 1;
                // 获取中心点的颜色
                cv::Vec3b centerColor = srcMat.at<cv::Vec3b>(centerY, centerX);
                // 填充当前晶格
                for (int i = y; i < y + cellSize && i < srcMat.rows; ++i) {
                    for (int j = x; j < x + cellSize && j < srcMat.cols; ++j) {
                        dst.at<cv::Vec3b>(i, j) = centerColor;
                    }
                }
            }
        }
        resultImage = CvMatToQImage(dst);
        currentEditor()->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::applyMosaicFilter()
{
    m_currentFilter = MosaicFilter;
    if (m_originalImage.isNull() && m_currentEditor) {
        m_originalImage = m_currentEditor->image();
    }
    QImage targetImage = m_originalImage;
    if (!targetImage.isNull()) {
        cv::Mat srcMat = QImageToCvMat(targetImage);
        cv::Mat dstMat = srcMat.clone();
        int mosaicSize = 10; // 拼接块的大小，可调整
        // 遍历每个块
        for (int y = 0; y < srcMat.rows; y += mosaicSize) {
            for (int x = 0; x < srcMat.cols; x += mosaicSize) {
                // 确定当前块的宽度和高度（处理边缘情况）
                int blockWidth = std::min(mosaicSize, srcMat.cols - x);
                int blockHeight = std::min(mosaicSize, srcMat.rows - y);
                // 计算块的平均颜色
                cv::Rect blockRect(x, y, blockWidth, blockHeight);
                cv::Mat block = srcMat(blockRect);
                cv::Scalar blockMeanColor = cv::mean(block);
                // 将当前块设置为平均颜色
                dstMat(blockRect).setTo(blockMeanColor);
            }
        }
        QImage resultImage = CvMatToQImage(dstMat);
        m_currentEditor->setImage(resultImage);
    }
    emit m_currentEditor->imageStatusChanged();
}

void ActiveCtrl::resetToOriginalImage()
{
    if (!m_originalImage.isNull() && m_currentEditor) {
        m_currentEditor->setImage(m_originalImage);
        emit m_currentEditor->imageStatusChanged();
    }
}

void ActiveCtrl::resetToPreviousFilter()
{
    switch (m_currentFilter) {
    case EmbossFilter:
        applyEmbossFilter();
        break;
    case OilPaintFilter:
        applyOilPaintFilter();
        break;
    case OverexposureFilter:
        applyOverexposureFilter();
        break;
    case DiffusionFilter:
        applyDiffusionFilter();
        break;
    case GaussianBlurFilter:
        applyGaussianBlurFilter();
        break;
    case MotionBlurFilter:
        applyMotionBlurFilter();
        break;
    case EnhancedBlurFilter:
        applyEnhancedBlurFilter();
        break;
    case LensBlurFilter:
        applyLensBlurFilter();
        break;
    case WaveFilter:
        applyWaveFilter();
        break;
    case RippleFilter:
        applyRippleFilter();
        break;
    case WaterRippleFilter:
        applyWaterRippleFilter();
        break;
    case SqueezeFilter:
        applySqueezeFilter();
        break;
    case ShearFilter:
        applyShearFilter();
        break;
    case USMSharpeningFilter:
        applyUSMSharpeningFilter();
        break;
    case StabilizationFilter:
        applyStabilizationFilter();
        break;
    case EdgeSharpeningFilter:
        applyEdgeSharpeningFilter();
        break;
    case PixelationFilter:
        applyPixelationFilter();
        break;
    case MosaicFilter:
        applyMosaicFilter();
        break;
    }
    emit m_currentEditor->imageStatusChanged();
}
