/** editor.cpp
 * Written by Rentianxiang on 2024-6-20
 * Funtion: image editor
 * 
 * Modified by ZhanXuecai on2024-6-20
 * Funtion: brush
 */
#include "editor.h"
#include <QBuffer>
#include <QImageReader>
#include <QPainter>
#include "imageprovider.h"
#include <opencv4/opencv2/opencv.hpp>
#include <string>
Editor::Editor(QObject *parent)
    : QObject{parent}
    , m_brushColor(Qt::red)
    , m_brushSize(5)
    , m_drawing(false)
    , m_currentShape(FreeDraw)
{}

Editor::~Editor()
{
    qDebug() << "an editor destroyed!!";
}

QImage Editor::image() const
{
    return m_image;
}

void Editor::setImage(QImage newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}

void Editor::openImage(const QString &path)
{
    m_path = QString(QUrl(path).toLocalFile());
    if (m_path.isEmpty()) {
        m_image.load(QString(":" + path));
    } else {
        m_image.load(m_path);
    }

    emit imageChanged();
}

void Editor::draw(int x, int y, bool isTemporary)
{
    qDebug() << x << y;

    QImage *targetImage = isTemporary ? &m_previewImage : &m_image;

    //targetImage->fill(Qt::transparent);

    QPainter painter(targetImage);

    painter.setRenderHint(QPainter::Antialiasing, true);
    painter.setPen(QPen(m_brushColor, m_brushSize, Qt::SolidLine, Qt::RoundCap, Qt::RoundJoin));

    switch (m_currentShape) {
    case FreeDraw:
        qDebug() << m_currentShape;
        painter.drawLine(m_lastPoint, QPoint(x, y));
        m_lastPoint = QPoint(x, y);
        break;

    case Rectangle:
        qDebug() << m_currentShape;
        painter.drawRect(QRect(m_lastPoint, QPoint(x, y)));
        break;

    case Ellipse:
        qDebug() << m_currentShape;
        painter.drawEllipse(QRect(m_lastPoint, QPoint(x, y)));
        break;
    }

    // if (isTemporary) {
    //     emit tempImageChanged();
    // } else {
    //     emit imageChanged();
    // }

    emit imageChanged();
}

void Editor::startDrawing(int x, int y)
{
    m_drawing = true;
    m_lastPoint = QPoint(x, y);

    continueDrawing(x, y, true); // 立即在开始绘制时绘制一个点
}

void Editor::continueDrawing(int x, int y, bool isTemporary)
{
    if (!m_drawing)
        return;
    draw(x, y, isTemporary);
}

void Editor::stopDrawing(int x, int y)
{
    m_drawing = false;
    draw(x, y, false);
}

void Editor::setShapeToRectangle()
{
    setCurrentShape(Rectangle);
    emit currentShapeChanged();
}

void Editor::setShapeToEllipse()
{
    setCurrentShape(Ellipse);
    emit currentShapeChanged();
}

void Editor::setShapeToFreeDraw()
{
    setCurrentShape(FreeDraw);
    emit currentShapeChanged();
}

QString Editor::path() const
{
    return m_path;
}

void Editor::setPath(const QString &newPath)
{
    if (m_path == newPath)
        return;
    m_path = newPath;
    emit pathChanged();
}

QColor Editor::brushColor() const
{
    return m_brushColor;
}

void Editor::setBrushColor(const QColor &newBrushColor)
{
    if (m_brushColor == newBrushColor)
        return;
    m_brushColor = newBrushColor;
    emit brushColorChanged();
}

int Editor::brushSize() const
{
    return m_brushSize;
}

void Editor::setBrushSize(int newBrushSize)
{
    if (m_brushSize == newBrushSize)
        return;
    m_brushSize = newBrushSize;
    emit brushSizeChanged();
}

Editor::Shape Editor::currentShape() const
{
    return m_currentShape;
}

void Editor::setCurrentShape(Editor::Shape newCurrentShape)
{
    if (m_currentShape == newCurrentShape)
        return;
    m_currentShape = newCurrentShape;
    emit currentShapeChanged();
}

QImage Editor::previewImage() const
{
    return m_previewImage;
}

void Editor::setPreviewImage(const QImage &newPreviewImage)
{
    if (m_previewImage == newPreviewImage)
        return;
    m_previewImage = newPreviewImage;
    emit previewImageChanged();
}

QImage Editor::tempImage() const
{
    // return m_tempImage;
}

void Editor::setTempImage(const QImage &newTempImage)
{
    // if (m_tempImage == newTempImage)
    //     return;
    // m_tempImage = newTempImage;
    // emit tempImageChanged();
}
