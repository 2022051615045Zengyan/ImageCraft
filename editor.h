/** editor.h
 * Written by Rentianxiang on 2024-6-20
 * Funtion: image editor
 * 
 * Modified by ZhanXuecai on2024-6-20
 * Funtion: brush
 */
#pragma once

#include <QImage>
#include <QQmlEngine>

class Editor : public QObject
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged FINAL)
    Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged FINAL)
    Q_PROPERTY(QColor brushColor READ brushColor WRITE setBrushColor NOTIFY brushColorChanged FINAL)
    Q_PROPERTY(int brushSize READ brushSize WRITE setBrushSize NOTIFY brushSizeChanged FINAL)
    Q_PROPERTY(
        Shape currentShape READ currentShape WRITE setCurrentShape NOTIFY currentShapeChanged FINAL)
    Q_PROPERTY(QImage previewImage READ previewImage WRITE setPreviewImage NOTIFY
                   previewImageChanged FINAL)

public:
    explicit Editor(QObject *parent = nullptr);

    ~Editor();

    enum Shape { FreeDraw, Rectangle, Ellipse };
    Q_ENUM(Shape)

    QImage image() const;
    Q_INVOKABLE void setImage(QImage newImage);
    Q_INVOKABLE void openImage(const QString &path);

    Q_INVOKABLE void draw(int x, int y, bool isTemporary);
    Q_INVOKABLE void startDrawing(int x, int y);
    Q_INVOKABLE void continueDrawing(int x, int y, bool isTemporary);
    Q_INVOKABLE void stopDrawing(int x, int y);
    Q_INVOKABLE void setShapeToRectangle();
    Q_INVOKABLE void setShapeToEllipse();
    Q_INVOKABLE void setShapeToFreeDraw();

    QString path() const;
    void setPath(const QString &newPath);

    QColor brushColor() const;
    void setBrushColor(const QColor &newBrushColor);

    int brushSize() const;
    void setBrushSize(int newBrushSize);

    Editor::Shape currentShape() const;
    void setCurrentShape(Editor::Shape newCurrentShape);

    QImage previewImage() const;
    void setPreviewImage(const QImage &newPreviewImage);

    QImage tempImage() const;
    void setTempImage(const QImage &newTempImage);

signals:

    void imageChanged();

    void pathChanged();

    void brushColorChanged();

    void brushSizeChanged();

    void currentShapeChanged();

    void previewImageChanged();

    void tempImageChanged();

private:
    QImage m_image;
    QImage m_previewImage;
    QImage m_tempImage;
    QString m_path;
    QPoint m_position;

    QColor m_brushColor;
    int m_brushSize;
    bool m_drawing;
    Shape m_currentShape;
    QPoint m_lastPoint;
    Q_PROPERTY(QImage tempImage READ tempImage WRITE setTempImage NOTIFY tempImageChanged FINAL)
};
