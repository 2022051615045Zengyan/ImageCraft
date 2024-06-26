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
    Q_PROPERTY(int brushSize READ brushSize WRITE setBrushSize NOTIFY brushSizeChanged FINAL)
    Q_PROPERTY(Shape currentShape READ currentShape WRITE setCurrentShape NOTIFY currentShapeChanged FINAL)
    Q_PROPERTY(QImage previewImage READ previewImage WRITE setPreviewImage NOTIFY
                   previewImageChanged FINAL)
    Q_PROPERTY(QImage canvasImage READ canvasImage WRITE setCanvasImage NOTIFY canvasImageChanged FINAL)

    Q_PROPERTY(Editor *canvasEditor READ canvasEditor WRITE setCanvasEditor NOTIFY
                   canvasEditorChanged FINAL)
    Q_PROPERTY(int modelIndex READ modelIndex WRITE setModelIndex NOTIFY modelIndexChanged FINAL)

public:
    enum Shape { FreeDraw, Rectangle, Ellipse };
    Q_ENUM(Shape)

    explicit ToolCtrl(QObject *parent = nullptr);
    QString selectedTool() const;
    void setSelectedTool(const QString &newSelectedTool);

    Q_INVOKABLE QColor getPixelColor(const QString &imagepath, int x, int y);
    Q_INVOKABLE void getPointPositon(int x, int y);
    Q_INVOKABLE void setScaleFactor(const float &Scalemultiple, int index);
    Q_INVOKABLE void returnScale(double Scalenumber);
    Q_INVOKABLE void getSize(const QString &size);

    Q_INVOKABLE void getRepeaterIndex(int index);

    Q_INVOKABLE void draw(int x, int y, bool isTemporary);
    Q_INVOKABLE void startDrawing(int x, int y);
    Q_INVOKABLE void continueDrawing(int x, int y, bool isTemporary);
    Q_INVOKABLE void stopDrawing(int x, int y);
    Q_INVOKABLE void setShapeToRectangle();
    Q_INVOKABLE void setShapeToEllipse();
    Q_INVOKABLE void setShapeToFreeDraw();
    Q_INVOKABLE void zoomSetInsert(QVariant num);

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
    void setBrushSize(int newBrushSize);

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

private slots:
    void on_currentEditorViewChanged();

private:
    QString m_selectedTool;
    QObject *m_showcolor = nullptr;
    QObject *m_pointtext = nullptr;
    QObject *m_imageSize = nullptr;
    QObject *m_currentEditorView = nullptr;
    QObject *m_zoom_size = nullptr;
    QObject *m_zoomRepeater = nullptr;
    QObject *m_zoomColumnLayout = nullptr;
    std::set<int> m_zoomSet;
    QStringList m_zoomList;
    int m_modelIndex;

    QImage m_previewImage; //用来作为预览画布（显示绘画预览，去除多重绘画）的透明图片
    QImage m_canvasImage; //用来作为画布（显示绘画结果）的透明图片
    QImage m_tempImage;   //用来作为临时画布（显示绘画过程）的透明图片

    QPoint m_lastPoint;
    Shape m_currentShape = FreeDraw;
    QColor m_brushColor = Qt::red;
    int m_brushSize = 5;
    bool m_drawing = false;
    Editor *m_canvasEditor = nullptr;
};
