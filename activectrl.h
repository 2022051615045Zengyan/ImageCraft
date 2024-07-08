/** activectrl.h
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: control menu actions
 * Funtion: refresh and TakeAFullScreenshot
 * modified by Zengyan on 2024-6-24
 *  added  verticallyFlip,horizontallyFlip functions
 *   Modified by Zengyan on 2024-6-25
 * added rotation function
 * Modified by Zengyan on 2024-6-26
 * added uesr-defined rotation function
 */
#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QSettings>
#include <QStack>
#include "editor.h"
#include <opencv4/opencv2/core/mat.hpp>

namespace cv {
class Mat;
}

class ActiveCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(ActiveCtrl)

    Q_PROPERTY(QString savePath READ savePath WRITE setSavePath NOTIFY savePathChanged FINAL)
    Q_PROPERTY(Editor* currentEditor READ currentEditor WRITE setCurrentEditor NOTIFY
                   currentEditorChanged FINAL)
    Q_PROPERTY(QObject* newDialogBox READ newDialogBox WRITE setNewDialogBox NOTIFY
                   newDialogBoxChanged FINAL)
    Q_PROPERTY(QObject* currentLayer READ currentLayer WRITE setCurrentLayer NOTIFY
                   currentLayerChanged FINAL)
    Q_PROPERTY(QObject* savePathDialod READ savePathDialod WRITE setSavePathDialod NOTIFY
                   savePathDialodChanged FINAL)
    Q_PROPERTY(QStringList recentFiles READ recentFiles WRITE setRecentFiles NOTIFY
                   recentFilesChanged FINAL)
    Q_PROPERTY(QObject* failToSave READ failToSave WRITE setFailToSave NOTIFY failToSaveChanged FINAL)
    Q_PROPERTY(QObject* openDialogBox READ openDialogBox WRITE setOpenDialogBox NOTIFY
                   openDialogBoxChanged FINAL)
    Q_PROPERTY(QObject* sharePage READ sharePage WRITE setSharePage NOTIFY sharePageChanged FINAL)

    Q_PROPERTY(bool modified READ modified WRITE setModified NOTIFY modifiedChanged FINAL)
    Q_PROPERTY(QSize size READ size WRITE setSize NOTIFY sizeChanged FINAL)
    Q_PROPERTY(
        int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged FINAL)
    Q_PROPERTY(QObject* exportPathDialog READ exportPathDialog WRITE setExportPathDialog NOTIFY
                   exportPathDialogChanged FINAL)
    Q_PROPERTY(QObject* askSaveDialog READ askSaveDialog WRITE setAskSaveDialog NOTIFY
                   askSaveDialogChanged FINAL)

    Q_PROPERTY(int YScale READ YScale WRITE setYScale NOTIFY YScaleChanged FINAL)
    Q_PROPERTY(int XScale READ XScale WRITE setXScale NOTIFY XScaleChanged FINAL)
    Q_PROPERTY(QObject* flip READ flip WRITE setFlip NOTIFY flipChanged FINAL)
    Q_PROPERTY(QObject* currentImageView READ currentImageView WRITE setCurrentImageView NOTIFY
                   currentImageViewChanged FINAL)
    Q_PROPERTY(double anglenum READ anglenum WRITE setAnglenum NOTIFY anglenumChanged FINAL)
    Q_PROPERTY(QObject* rotationDialogBox READ rotationDialogBox WRITE setRotationDialogBox NOTIFY
                   rotationDialogBoxChanged FINAL)
    Q_PROPERTY(QObject* rightMenu READ rightMenu WRITE setRightMenu NOTIFY rightMenuChanged FINAL)
    Q_PROPERTY(
        int lcenterWidth READ lcenterWidth WRITE setLcenterWidth NOTIFY lcenterWidthChanged FINAL)
    Q_PROPERTY(int lcenterHeight READ lcenterHeight WRITE setLcenterHeight NOTIFY
                   lcenterHeightChanged FINAL)
    Q_PROPERTY(Filter currentFilter READ getCurrentFilter WRITE setCurrentFilter NOTIFY
                   currentFilterChanged FINAL)
public:
    //图层修改类型
    enum OperationType {
        MoveLayer,
        ScaleLayer,
        AddLayer,
        ReMoveLayer,
        ModifiedLayer,
        VisibleLayer,
        FlipXLayer,
        FlipYLayer,
        SpinLayer,

    };

    enum Filter {
        EmbossFilter,
        OilPaintFilter,
        OverexposureFilter,
        DiffusionFilter,
        GaussianBlurFilter,
        MotionBlurFilter,
        EnhancedBlurFilter,
        LensBlurFilter,
        WaveFilter,
        RippleFilter,
        WaterRippleFilter,
        SqueezeFilter,
        ShearFilter,
        USMSharpeningFilter,
        StabilizationFilter,
        EdgeSharpeningFilter,
        PixelationFilter,
        CrystallizeFilter,
        MosaicFilter
    };

    Q_ENUM(OperationType)
    Q_ENUM(Filter)

    explicit ActiveCtrl(QObject* parent = nullptr);

    Q_INVOKABLE void open();
    Q_INVOKABLE void newImage();
    Q_INVOKABLE void save();
    Q_INVOKABLE void saveAs();
    Q_INVOKABLE void close();
    Q_INVOKABLE void closeAll();
    Q_INVOKABLE void addRecentFiles(const QString& filePath);
    Q_INVOKABLE void getAngle(double angle);
    Q_INVOKABLE void openDialog();
    Q_INVOKABLE void rotation(const QString& rotationstyle, double rotationangle);
    Q_INVOKABLE void leftRotation();
    Q_INVOKABLE void rightRotation();
    Q_INVOKABLE void verticallyFlip();
    Q_INVOKABLE void horizontallyFlip();

    Q_INVOKABLE void refresh();
    Q_INVOKABLE void takeAFullScreenshot();

    Q_INVOKABLE void exportImage();
    Q_INVOKABLE void exitWindow();

    Q_INVOKABLE void popRightMenu(QVariant x, QVariant y);
    Q_INVOKABLE void deleteLayer();

    Q_INVOKABLE void applyEmbossFilter();
    Q_INVOKABLE void applyOilPaintFilter();
    Q_INVOKABLE void applyOverexposureFilter();
    Q_INVOKABLE void applyDiffusionFilter();
    Q_INVOKABLE void applyMosaicFilter();
    Q_INVOKABLE void applyGaussianBlurFilter();
    Q_INVOKABLE void applyMotionBlurFilter();
    Q_INVOKABLE void applyEnhancedBlurFilter();
    Q_INVOKABLE void applyLensBlurFilter();
    Q_INVOKABLE void applyWaveFilter();
    Q_INVOKABLE void applyRippleFilter();
    Q_INVOKABLE void applySqueezeFilter();
    Q_INVOKABLE void applyShearFilter();
    Q_INVOKABLE void applyWaterRippleFilter();
    Q_INVOKABLE void applyUSMSharpeningFilter();
    Q_INVOKABLE void applyEdgeSharpeningFilter();
    Q_INVOKABLE void applyStabilizationFilter();
    Q_INVOKABLE void applyPixelationFilter();
    Q_INVOKABLE void applyCrystallizeFilter();

    Q_INVOKABLE void resetToOriginalImage();
    Q_INVOKABLE void resetToPreviousFilter();

    //撤销操作
    Q_INVOKABLE void undo();
    Q_INVOKABLE void redo();

    Editor* currentEditor() const;
    void setCurrentEditor(Editor* newCurrentEditor);

    QObject* newDialogBox() const;
    void setNewDialogBox(QObject* newNewDialogBox);

    QObject* currentLayer() const;
    void setCurrentLayer(QObject* newCurrentLayer);

    QObject* savePathDialod() const;
    void setSavePathDialod(QObject* newSavePathDialod);

    QString savePath() const;
    void setSavePath(const QString& newSavePath);

    bool modified() const;
    void setModified(bool newModified);

    QSize size() const;
    void setSize(const QSize& newSize);

    QStringList recentFiles() const;
    void setRecentFiles(const QStringList& newRecentFiles);

    QObject* failToSave() const;
    void setFailToSave(QObject* newFailToSave);

    QObject* openDialogBox() const;
    void setOpenDialogBox(QObject* newOpenDialogBox);

    QObject* sharePage() const;
    void setSharePage(QObject* newSharePage);

    int currentIndex() const;
    void setCurrentIndex(int newCurrentIndex);

    QObject* exportPathDialog() const;
    void setExportPathDialog(QObject* newExportPathDialog);

    QObject* askSaveDialog() const;
    void setAskSaveDialog(QObject* newAskSaveDialog);

    int YScale() const;
    void setYScale(int newYScale);

    int XScale() const;
    void setXScale(int newXScale);

    QObject* flip() const;
    void setFlip(QObject* newFlip);

    QObject* currentImageView() const;
    void setCurrentImageView(QObject* newCurrentImageView);

    double anglenum() const;
    void setAnglenum(double newAnglenum);

    QObject* rotationDialogBox() const;
    void setRotationDialogBox(QObject* newRotationDialogBox);

    QObject* rightMenu() const;
    void setRightMenu(QObject* newRightMenu);

    int windowHeight() const;
    void setWindowHeight(int newWindowHeight);

    int windowWidth() const;
    void setWindowWidth(int newWindowWidth);

    int lcenterWidth() const;
    void setLcenterWidth(int newLcenterWidth);

    int lcenterHeight() const;
    void setLcenterHeight(int newLcenterHeight);

    Filter getCurrentFilter() const;
    void setCurrentFilter(Filter newCurrentFilter);

signals:

    void dialogBoxChanged();

    void currentEditorChanged();

    void newDialogBoxChanged();

    void currentLayerChanged();

    void savePathDialodChanged();

    void savePathChanged();

    void modifiedChanged();

    void sizeChanged();

    void recentFilesChanged();

    void failToSaveChanged();

    void openDialogBoxChanged();

    void sharePageChanged();

    void currentIndexChanged();

    void refreshSignal();

    void exportPathDialogChanged();

    void askSaveDialogChanged();

    void saved();

    void closed();
    void YScaleChanged();

    void XScaleChanged();

    void flipChanged();

    void closeAlled();

    void currentImageViewChanged();

    void anglenumChanged();

    void rotationDialogBoxChanged();

    void rightMenuChanged();

    void lcenterWidthChanged();

    void lcenterHeightChanged();

    void currentFilterChanged();

private slots:
    void openSlot();
    void saveAsSlot();
    void exportSlot();
    void askSave_saveSlot();
    void askSave_discardSlot();
    void askSave_cancelSlot();
    void closeAllSlot();
    void exitSlot();

private:
    QString m_savePath;
    bool m_modified;
    QSize m_size;
    qsizetype m_recentFileNum;
    QStringList m_recentFiles;
    QSettings m_setting;
    QScreen* m_screen;
    int m_currentIndex;
    int m_lcenterHeight;
    int m_lcenterWidth;

    Editor* m_currentEditor = nullptr;
    QObject* m_currentLayer = nullptr;
    QString m_originalImageUrl;
    QObject* m_rotationDialogBox = nullptr;
    QObject* m_openDialogBox = nullptr;
    QObject* m_newDialogBox = nullptr;
    QObject* m_savePathDialod = nullptr;
    QObject* m_failToSave = nullptr;
    QObject* m_sharePage = nullptr;
    QObject* m_exportPathDialog = nullptr;
    QObject* m_askSaveDialog = nullptr;
    QObject* m_rightMenu = nullptr;
    int m_YScale;
    int m_XScale;
    double m_anglenum;
    QObject* m_flip = nullptr;
    QObject* m_currentImageView = nullptr;

    void loadRecentFiles();
    void saveRecentFiles();
    cv::Mat QImageToCvMat(const QImage& image);
    QImage CvMatToQImage(const cv::Mat& mat);

    QImage m_originalImage;
    Filter m_currentFilter;
};
