/** toolctrl.h
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 * modified by Zengyan on 2014-6-20
 *      added getpiontposition
 * modified by Zengyan on 2014-6-21
 *      added zoomfuntion
 * modified by ZhanXuecai on 2024-6-21
 *     move brush function and rectangle function to here
 * modified by Zengyan on 2024-6-22
 *     perfected zoom function 

 *   Modified by Zengyan on 2024-6-25
 * added rotation function

 * modified by ZhanXuecai on 2024-6-24
 *     perfected brush rectangle function
 * modified by ZhanXuecai on 2024-6-25
 *     perfected brush function and rectangle function
 * modified by ZhanXuecai on 2024-6-26
 *     perfected draw function and added pendraw and spraydraw

 * modified by Zengyan on 2024-7-6
 *   added textbox funtion

 *     
 * modified by ZhanXuecai on 2024-7-6
 *     added line function
 *     perfected draw function
 *   modified by Zengyan on 2024-7-8
 *      added strawmodel,initaltextArea's color,size,family
 */
#pragma once

#include <QColor>
#include <QImage>
#include <QObject>
#include <QPoint>
#include <QQmlEngine>
#include <editor.h>
#include <opencv2/opencv.hpp>
#include <set>
class ToolCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(ToolCtrl)

    Q_PROPERTY(QString selectedTool READ selectedTool WRITE setSelectedTool NOTIFY
                   selectedToolChanged FINAL)
    Q_PROPERTY(QObject *showcolor READ showcolor WRITE setShowcolor NOTIFY showcolorChanged FINAL)
    Q_PROPERTY(QObject *pointtext READ pointtext WRITE setPointtext NOTIFY pointtextChanged FINAL)

    Q_PROPERTY(QObject *currentEditorView READ currentEditorView WRITE setCurrentEditorView NOTIFY
                   currentEditorViewChanged FINAL)
    Q_PROPERTY(QObject *zoom_size READ zoom_size WRITE setZoom_size NOTIFY zoom_sizeChanged FINAL)

    Q_PROPERTY(QStringList zoomList READ zoomList WRITE setZoomList NOTIFY zoomListChanged FINAL)

    Q_PROPERTY(std::set<int> zoomSet READ zoomSet WRITE setZoomSet NOTIFY zoomSetChanged FINAL)

    Q_PROPERTY(QObject *imageSize READ imageSize WRITE setImageSize NOTIFY imageSizeChanged FINAL)
    Q_PROPERTY(QObject *zoomRepeater READ zoomRepeater WRITE setZoomRepeater NOTIFY
                   zoomRepeaterChanged FINAL)
    Q_PROPERTY(QObject *zoomColumnLayout READ zoomColumnLayout WRITE setZoomColumnLayout NOTIFY
                   zoomColumnLayoutChanged FINAL)

    Q_PROPERTY(QColor brushColor READ brushColor WRITE setBrushColor NOTIFY brushColorChanged FINAL)
    Q_PROPERTY(int brushSize READ brushSize WRITE setCurrentBrushSize NOTIFY brushSizeChanged FINAL)
    Q_PROPERTY(
        Shape currentShape READ currentShape WRITE setCurrentShape NOTIFY currentShapeChanged FINAL)
    Q_PROPERTY(QImage previewImage READ previewImage WRITE setPreviewImage NOTIFY
                   previewImageChanged FINAL)
    Q_PROPERTY(
        QImage canvasImage READ canvasImage WRITE setCanvasImage NOTIFY canvasImageChanged FINAL)

    Q_PROPERTY(Editor *canvasEditor READ canvasEditor WRITE setCanvasEditor NOTIFY
                   canvasEditorChanged FINAL)

    Q_PROPERTY(int modelIndex READ modelIndex WRITE setModelIndex NOTIFY modelIndexChanged FINAL)

    Q_PROPERTY(CapStyle currentCapStyle READ currentCapStyle WRITE setCurrentCapStyle NOTIFY
                   currentCapStyleChanged FINAL)
    Q_PROPERTY(int spraySize READ spraySize WRITE setSpraySize NOTIFY spraySizeChanged FINAL)

    Q_PROPERTY(QObject *currentTextArea READ currentTextArea WRITE setCurrentTextArea NOTIFY
                   currentTextAreaChanged FINAL)
    Q_PROPERTY(QObject *wordItem READ wordItem WRITE setWordItem NOTIFY wordItemChanged FINAL)

    Q_PROPERTY(bool fillRectangle READ fillRectangle WRITE setFillRectangle NOTIFY
                   fillRectangleChanged FINAL)

    Q_PROPERTY(QObject *straw_SampleRecords READ straw_SampleRecords WRITE setStraw_SampleRecords
                   NOTIFY straw_SampleRecordsChanged FINAL)
    Q_PROPERTY(QStringList colorList READ colorList WRITE setColorList NOTIFY colorListChanged FINAL)
    Q_PROPERTY(
        std::set<QString> colorSet READ colorSet WRITE setColorSet NOTIFY colorSetChanged FINAL)

    Q_PROPERTY(int eraserSize READ eraserSize WRITE setEraserSize NOTIFY eraserSizeChanged FINAL)

    Q_PROPERTY(int eraserOpacity READ eraserOpacity WRITE setEraserOpacity NOTIFY
                   eraserOpacityChanged FINAL)
    Q_PROPERTY(int lineSize READ lineSize WRITE setLineSize NOTIFY lineSizeChanged FINAL)
    Q_PROPERTY(
        int PolyLineSize READ PolyLineSize WRITE setPolyLineSize NOTIFY PolyLineSizeChanged FINAL)
public:
    enum Shape {
        FreeDraw,
        PenDraw,
        SprayDraw,
        Rectangle,
        Ellipse,
        Circle,
        Polygon,
        LineDraw,
        PolylineDraw,
        CurveDraw,
        Eraser,
        ColoredEraser
    };
    Q_ENUM(Shape)

    enum CapStyle { RoundCap, SquareCap, SlashCap, BackSlashCap };
    Q_ENUM(CapStyle)

    explicit ToolCtrl(QObject *parent = nullptr);
    QString selectedTool() const;
    void setSelectedTool(const QString &newSelectedTool);
    void setInitialFamily();

    Q_INVOKABLE QColor getPixelColor(const QString &imagepath, int x, int y);
    Q_INVOKABLE void showcolorSet(const QColor &color);
    Q_INVOKABLE void getPointPositon(int x, int y);
    Q_INVOKABLE void setScaleFactor(const float &Scalemultiple, int index);
    Q_INVOKABLE void returnScale(double Scalenumber);
    Q_INVOKABLE void getSize(const QString &size);
    Q_INVOKABLE void getRepeaterIndex(int index);
    Q_INVOKABLE void draw(int x, int y, bool isTemporary);
    Q_INVOKABLE void startDrawing(int x, int y);
    Q_INVOKABLE void continueDrawing(int x, int y, bool isTemporary);
    Q_INVOKABLE void stopDrawing(int x, int y);
    Q_INVOKABLE void finishDrawing();
    Q_INVOKABLE void setShapeToRectangle();
    Q_INVOKABLE void setShapeToEllipse();
    Q_INVOKABLE void setShapeToCircle();
    Q_INVOKABLE void setShapeToPolygon();
    Q_INVOKABLE void setShapeToFreeDraw();
    Q_INVOKABLE void setShapeToPenDraw();
    Q_INVOKABLE void setShapeToSprayDraw();
    Q_INVOKABLE void setShapeToLineDraw();
    Q_INVOKABLE void setShapeToPolylineDraw();
    Q_INVOKABLE void setShapeToCurveDraw();
    Q_INVOKABLE void setShapeToEraser();
    Q_INVOKABLE void setShapeToColoredEraser();

    Q_INVOKABLE void setCurrentBrushSize(int newBrushSize);
    Q_INVOKABLE void setCapStyle(int index);
    Q_INVOKABLE void setSpraySize(int newSpraySize);
    Q_INVOKABLE void setEraserSize(int newEraserSize);

    Q_INVOKABLE void setTextFamily(const QString &family);
    Q_INVOKABLE void setWordSize(int size);
    Q_INVOKABLE void setTextColor(const QColor &color);
    Q_INVOKABLE void setBold(bool bold);
    Q_INVOKABLE void setItalic(bool italic);
    Q_INVOKABLE void setStrikeout(bool strikeout);
    Q_INVOKABLE void setUnderline(bool underline);
    Q_INVOKABLE void updateBrushColor();
    Q_INVOKABLE QColor initalColor();
    Q_INVOKABLE QUrl initalSource();
    Q_INVOKABLE int initalSize();
    Q_INVOKABLE void setFillRectangle(bool newFillRectangle);
    Q_INVOKABLE void setEraserOpacity(int newEraserOpacity);
    Q_INVOKABLE void setLineSize(int newLineSize);
    Q_INVOKABLE void setPolyLineSize(int newPolyLineSize);

    QObject *showcolor() const;
    void setShowcolor(QObject *newShowcolor);

    QObject *pointtext() const;
    void setPointtext(QObject *newPointtext);

    QObject *currentEditorView() const;
    void setCurrentEditorView(QObject *newCurrentEditorView);

    QObject *zoom_size() const;
    void setZoom_size(QObject *newZoom_size);

    QStringList zoomList() const;
    void setZoomList(const QStringList &newZoomList);

    std::set<int> zoomSet() const;
    void setZoomSet(const std::set<int> &newZoomSet);

    QObject *imageSize() const;
    void setImageSize(QObject *newImageSize);

    QObject *zoomRepeater() const;
    void setZoomRepeater(QObject *newZoomRepeater);

    QObject *zoomColumnLayout() const;
    void setZoomColumnLayout(QObject *newZoomColumnLayout);

    QColor brushColor() const;
    void setBrushColor(const QColor &newBrushColor);

    int brushSize() const;
    void setBrushSize();

    ToolCtrl::Shape currentShape() const;
    void setCurrentShape(ToolCtrl::Shape newCurrentShape);

    QImage previewImage() const;
    void setPreviewImage(const QImage &newPreviewImage);

    QImage tempImage() const;
    void setTempImage(const QImage &newTempImage);

    QImage canvasImage() const;
    void setCanvasImage(const QImage &newCanvasImage);

    Editor *canvasEditor() const;
    void setCanvasEditor(Editor *newCanvasEditor);

    int modelIndex() const;
    void setModelIndex(int newModelIndex);

    CapStyle currentCapStyle() const;
    void setCurrentCapStyle(CapStyle newCurrentCapStyle);

    int spraySize() const;

    QObject *currentTextArea() const;
    void setCurrentTextArea(QObject *newCurrentTextArea);

    QObject *wordItem() const;
    void setWordItem(QObject *newWordItem);

    bool fillRectangle() const;

    int eraserSize() const;

    int eraserOpacity() const;

    int lineSize() const;

    int PolyLineSize() const;

    QObject *straw_SampleRecords() const;
    void setStraw_SampleRecords(QObject *newStraw_SampleRecords);

    QStringList colorList() const;
    void setColorList(const QStringList &newColorList);

    std::set<QString> colorSet() const;
    void setColorSet(const std::set<QString> &newColorSet);

signals:
    void selectedToolChanged();

    void showcolorChanged();

    void pointtextChanged();

    void currentEditorViewChanged();
    void zoom_sizeChanged();

    void zoomListChanged();

    void zoomSetChanged();

    void imageSizeChanged();

    void zoomRepeaterChanged();

    void zoomColumnLayoutChanged();

    void brushColorChanged();

    void brushSizeChanged();

    void currentShapeChanged();

    void previewImageChanged();

    void tempImageChanged();

    void imageChanged();

    void canvasImageChanged();

    void canvasEditorChanged();

    void modelIndexChanged();

    void currentCapStyleChanged();

    void spraySizeChanged();

    void currentTextAreaChanged();

    void wordItemChanged();

    void fillRectangleChanged();

    void straw_SampleRecordsChanged();

    void colorListChanged();

    void colorSetChanged();

    void eraserSizeChanged();

    void eraserOpacityChanged();

    void lineSizeChanged();

    void PolyLineSizeChanged();

private slots:
    void on_currentEditorViewChanged();

private:
    QString m_selectedTool;
    QObject *m_straw_SampleRecords = nullptr;
    QObject *m_wordItem = nullptr;
    QObject *m_showcolor = nullptr;
    QObject *m_pointtext = nullptr;
    QObject *m_imageSize = nullptr;
    QObject *m_currentEditorView = nullptr;
    QObject *m_zoom_size = nullptr;
    QObject *m_zoomRepeater = nullptr;
    QObject *m_zoomColumnLayout = nullptr;
    QObject *m_currentTextArea = nullptr; //用来设置插入文字的属性
    std::set<int> m_zoomSet; 
    QStringList m_zoomList;

    std::set<QString> m_colorSet;
    QStringList m_colorList;

    int m_modelIndex;

    QImage m_previewImage; //用来作为预览画布（实现绘画预览）的透明图片
    QImage m_canvasImage;  //用来作为画布（显示绘画结果）的透明图片

    QPoint m_lastPoint;
    Shape m_currentShape;
    CapStyle m_currentCapStyle;
    QColor m_brushColor;
    int m_brushSize;
    int m_sprayRadius;
    int m_sprayDensity;
    int m_spraySize;
    int m_eraserSize;
    int m_eraserOpacity;
    int m_lineSize;
    int m_PolyLineSize;
    QVector<QPoint> m_points; //记录折线和曲线的点
    bool m_fillRectangle = true;

    bool m_drawing;
    Editor *m_canvasEditor = nullptr;
};
