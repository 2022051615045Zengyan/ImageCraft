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

public:
    explicit Editor(QObject *parent = nullptr);

    ~Editor();

    QImage image() const;
    Q_INVOKABLE void setImage(QImage newImage);
    Q_INVOKABLE void openImage(const QString &path);
    Q_INVOKABLE void draw(int x, int y);

    QString path() const;
    void setPath(const QString &newPath);

    QColor brushColor() const;
    void setBrushColor(const QColor &newBrushColor);

    int brushSize() const;
    void setBrushSize(int newBrushSize);

signals:

    void imageChanged();

    void pathChanged();

    void brushColorChanged();

    void brushSizeChanged();

private:
    QImage m_image;
    QImage m_brushimage;
    QString m_path;
    QPoint m_position;

    QColor m_brushColor;
    int m_brushSize;
};
