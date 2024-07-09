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
{}

Editor::~Editor() {}

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
    } else if (m_path.left(4) == "/tmp") {
        m_image.load(m_path);
        m_path.clear();
    } else {
        m_image.load(m_path);
    }

    emit imageChanged();
}

QImage Editor::copyImage()
{
    QImage image;
    if (!m_image.isNull()) {
        image = m_image.copy();
    }

    return image;
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
