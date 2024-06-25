/** toolctrl.cpp
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 *   modified by Zengyan on 2014-6-20
 *      added getpointposition
 *   modified by Zengyan on 2014-6-21
 *      added zoom function
 *   modified by ZhanXuecai on 2024-6-21
 *      move brush function and rectangle function to here
 *   modified by Zengyan on 2024-6-22

 *   perfected zoom function  
 *   Modified by Zengyan on 2024-6-25
 * added rotation function 

 *      perfected zoom function   
 *   modified by ZhanXuecai on 2024-6-24
 *      perfected brush rectangle function
 *   modified by ZhanXuecai on 2024-6-25
 *      perfected brush function and rectangle function

 */
#include "toolctrl.h"
#include <QColor>
#include <QPainter>
#include <QQmlProperty>

ToolCtrl::ToolCtrl(QObject *parent)
    : QObject{parent}
{
    connect(this, &ToolCtrl::currentEditorViewChanged, this, &ToolCtrl::on_currentEditorViewChanged);
    connect(this, &ToolCtrl::zoomSetChanged, this, [=, this]() {
        QStringList options;
        for (const auto &item : m_zoomSet) {
            options << QString::number(item);
        }
        m_zoomList = options;
        m_zoom_size->setProperty("model", m_zoomList);
        m_zoomRepeater->setProperty("model", m_zoomList);
    });

    for (int i = 10; i <= 100; i += 10) {
        m_zoomSet.insert(i);
    }

    for (int i = 200; i <= 1000; i += 100) {
        m_zoomSet.insert(i);
    }

    for (int i = 1500; i <= 5000; i += 500) {
        m_zoomSet.insert(i);
    }

    for (int i = 6000; i <= 10000; i += 1000) {
        m_zoomSet.insert(i);
    }

    for (int i = 12500; i <= 20000; i += 2500) {
        m_zoomSet.insert(i);
    }
}

QString ToolCtrl::selectedTool() const
{
    return m_selectedTool;
}

QObject *ToolCtrl::showcolor() const
{
    return m_showcolor;
}

void ToolCtrl::setShowcolor(QObject *newShowcolor)
{
    if (m_showcolor == newShowcolor)
        return;
    m_showcolor = newShowcolor;
    emit showcolorChanged();
}

QObject *ToolCtrl::pointtext() const
{
    return m_pointtext;
}

void ToolCtrl::setPointtext(QObject *newPointtext)
{
    if (m_pointtext == newPointtext)
        return;
    m_pointtext = newPointtext;
    emit pointtextChanged();
}

QObject *ToolCtrl::currentEditorView() const
{
    return m_currentEditorView;
}

void ToolCtrl::setCurrentEditorView(QObject *newCurrentEditorView)
{
    if (m_currentEditorView == newCurrentEditorView)
        return;
    m_currentEditorView = newCurrentEditorView;
    emit currentEditorViewChanged();
}

void ToolCtrl::on_currentEditorViewChanged()
{
    if (!m_currentEditorView) {
        return;
    }
    double readscale = QQmlProperty::read(m_currentEditorView, "scale").toFloat();
    int number = readscale * 100;
    auto it = m_zoomSet.find(number);
    int currentIndex = std ::distance(m_zoomSet.begin(), it);
    m_zoom_size->setProperty("currentIndex", currentIndex);
    m_zoomColumnLayout->setProperty("currentIndex", currentIndex);
}

void ToolCtrl::modelChangedslot()
{
    m_zoom_size->setProperty("currentIndex", m_modelIndex);
}

QObject *ToolCtrl::zoomColumnLayout() const
{
    return m_zoomColumnLayout;
}

void ToolCtrl::setZoomColumnLayout(QObject *newZoomColumnLayout)
{
    if (m_zoomColumnLayout == newZoomColumnLayout)
        return;
    m_zoomColumnLayout = newZoomColumnLayout;
    emit zoomColumnLayoutChanged();
}

QObject *ToolCtrl::zoomRepeater() const
{
    return m_zoomRepeater;
}

void ToolCtrl::setZoomRepeater(QObject *newZoomRepeater)
{
    if (m_zoomRepeater == newZoomRepeater)
        return;
    m_zoomRepeater = newZoomRepeater;
    emit zoomRepeaterChanged();

Editor *ToolCtrl::canvasEditor() const
{
    return m_canvasEditor;
}

void ToolCtrl::setCanvasEditor(Editor *newCanvasEditor)
{
    if (m_canvasEditor == newCanvasEditor)
        return;
    m_canvasEditor = newCanvasEditor;
    emit canvasEditorChanged();
}

QImage ToolCtrl::canvasImage() const
{
    return m_canvasImage;
}

void ToolCtrl::setCanvasImage(const QImage &newCanvasImage)
{
    if (m_canvasImage == newCanvasImage)
        return;
    m_canvasImage = newCanvasImage;
    emit canvasImageChanged();
}

QObject *ToolCtrl::imageSize() const
{
    return m_imageSize;
}

void ToolCtrl::setImageSize(QObject *newImageSize)
{
    if (m_imageSize == newImageSize)
        return;
    m_imageSize = newImageSize;
    emit imageSizeChanged();
}

std::set<int> ToolCtrl::zoomSet() const
{
    return m_zoomSet;
}

void ToolCtrl::setZoomSet(const std::set<int> &newZoomSet)
{
    if (m_zoomSet == newZoomSet)
        return;
    m_zoomSet = newZoomSet;
    emit zoomSetChanged();
}

QStringList ToolCtrl::zoomList() const
{
    return m_zoomList;
}

void ToolCtrl::setZoomList(const QStringList &newZoomList)
{
    if (m_zoomList == newZoomList)
        return;
    m_zoomList = newZoomList;
    emit zoomListChanged();
}

QObject *ToolCtrl::zoom_size() const
{
    return m_zoom_size;
}

void ToolCtrl::setZoom_size(QObject *newZoom_size)
{
    if (m_zoom_size == newZoom_size)
        return;
    m_zoom_size = newZoom_size;
    emit zoom_sizeChanged();
}

//选择工具
void ToolCtrl::setSelectedTool(const QString &newSelectedTool)
{
    if (m_selectedTool == newSelectedTool)
        return;
    m_selectedTool = newSelectedTool;
    emit selectedToolChanged();
}

//捕获图片点击点的颜色
QColor ToolCtrl::getPixelColor(const QString &imagepath, int x, int y)
{
    cv::Mat image = cv::imread(imagepath.toStdString());

    if (image.empty()) {
        //printf("无法加载图片!\n");
        qDebug() << "无法加载图片!";
        return -1;
    }
    cv::Vec3b pixel = image.at<cv::Vec3b>(y, x);
    qDebug() << x << " " << y;
    QColor color = QColor(pixel[2], pixel[1], pixel[0]);
    qDebug() << color;
    m_showcolor->setProperty("color", color.name());
    qDebug() << color.name();
    return color;
}

//设置底部x,y值

void ToolCtrl::getPointPositon(int x, int y)
{
    m_pointtext->setProperty("text", QString("x: %1 y: %2").arg(x).arg(y));
}

//缩放图片
void ToolCtrl::setScaleFactor(const float &Scalemultiple, int index)
{
    if (!m_currentEditorView) {
        return;
    }
    float number = Scalemultiple / 100;
    qDebug() << number;
    m_currentEditorView->setProperty("scale", number);
    m_zoomColumnLayout->setProperty("currentIndex", index);
}
//捕获图片缩放大小倍数返回缩放值
void ToolCtrl::returnScale(double Scalenumber)
{
    int number = Scalenumber * 100;
    m_zoomSet.insert(number);
    connect(m_zoom_size,
            SIGNAL(modelChanged()),
            this,
            SLOT(modelChangedslot()),
            Qt::SingleShotConnection);
    auto it = m_zoomSet.find(number);
    m_modelIndex = std ::distance(m_zoomSet.begin(), it);
    m_zoomColumnLayout->setProperty("currentIndex", m_modelIndex);
    emit zoomSetChanged();
    // emit currentEditorViewChanged();
}

void ToolCtrl::getSize(const QString &size)
{
    m_imageSize->setProperty("text", size);
}

void ToolCtrl::getRepeaterIndex(int index)
{
    m_zoom_size->setProperty("currentIndex", index);

void ToolCtrl::draw(int x, int y, bool isTemporary)
{
    QImage *targetImage = isTemporary ? &m_previewImage : &m_canvasImage;

    QPainter painter(targetImage);

    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setPen(QPen(m_brushColor, m_brushSize, Qt::SolidLine, Qt::RoundCap, Qt::RoundJoin));

    switch (m_currentShape) {
    case FreeDraw:
        //qDebug() << m_currentShape;
        painter.drawLine(m_lastPoint, QPoint(x, y));
        m_lastPoint = QPoint(x, y);
        break;

    case Rectangle:
        //qDebug() << m_currentShape;
        painter.drawRect(QRect(m_lastPoint, QPoint(x, y)));
        break;

    case Ellipse:
        //qDebug() << m_currentShape;
        painter.drawEllipse(QRect(m_lastPoint, QPoint(x, y)));
        break;
    }

    // if (isTemporary) {
    //     emit tempImageChanged();
    // } else {
    //     emit imageChanged();
    // }
    m_canvasEditor->setImage(m_canvasImage);
}

void ToolCtrl::startDrawing(int x, int y)
{
    m_drawing = true;
    m_lastPoint = QPoint(x, y);

    continueDrawing(x, y, false); // 立即在开始绘制时绘制一个点
}

void ToolCtrl::continueDrawing(int x, int y, bool isTemporary)
{
    if (!m_drawing)
        return;
    draw(x, y, isTemporary);
}

void ToolCtrl::stopDrawing(int x, int y)
{
    m_drawing = false;
    draw(x, y, false);
}

void ToolCtrl::setShapeToRectangle()
{
    setCurrentShape(Rectangle);
    emit currentShapeChanged();
}

void ToolCtrl::setShapeToEllipse()
{
    setCurrentShape(Ellipse);
    emit currentShapeChanged();
}

void ToolCtrl::setShapeToFreeDraw()
{
    setCurrentShape(FreeDraw);
    emit currentShapeChanged();
}

QColor ToolCtrl::brushColor() const
{
    return m_brushColor;
}

void ToolCtrl::setBrushColor(const QColor &newBrushColor)
{
    if (m_brushColor == newBrushColor)
        return;
    m_brushColor = newBrushColor;
    emit brushColorChanged();
}

int ToolCtrl::brushSize() const
{
    return m_brushSize;
}

void ToolCtrl::setBrushSize(int newBrushSize)
{
    if (m_brushSize == newBrushSize)
        return;
    m_brushSize = newBrushSize;
    emit brushSizeChanged();
}

ToolCtrl::Shape ToolCtrl::currentShape() const
{
    return m_currentShape;
}

void ToolCtrl::setCurrentShape(ToolCtrl::Shape newCurrentShape)
{
    if (m_currentShape == newCurrentShape)
        return;
    m_currentShape = newCurrentShape;
    emit currentShapeChanged();
}

QImage ToolCtrl::previewImage() const
{
    return m_previewImage;
}

void ToolCtrl::setPreviewImage(const QImage &newPreviewImage)
{
    if (m_previewImage == newPreviewImage)
        return;
    m_previewImage = newPreviewImage;
    emit previewImageChanged();
}

QImage ToolCtrl::tempImage() const
{
    // return m_tempImage;
}

void ToolCtrl::setTempImage(const QImage &newTempImage)
{
    // if (m_tempImage == newTempImage)
    //     return;
    // m_tempImage = newTempImage;
    // emit tempImageChanged();
}
