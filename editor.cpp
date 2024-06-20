/** editor.cpp
 * Written by Rentianxiang on 2024-6-20
 * Funtion: image editor
 */
#include "editor.h"
#include <QBuffer>
#include <QImageReader>
#include "imageprovider.h"
#include <opencv4/opencv2/opencv.hpp>
#include <string>

Editor::Editor(QObject *parent)
    : QObject{parent}
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

// void Editor::moveImage(int dx, int dy)
// {
//     m_position += QPoint(dx, dy);
//     cv::Mat mat = cv::imread(std::string(m_path.toLocal8Bit()));
//     if (mat.empty()) {
//         qDebug() << "Failed to load image!";
//         return;
//     }

//     cv::Mat translated;
//     cv::Mat translationMatrix
//         = (cv::Mat_<double>(2, 3) << 1, 0, m_position.x(), 0, 1, m_position.y()); //创建变换矩阵
//     cv::warpAffine(mat, translated, translationMatrix, mat.size());               //平移变换

//     cv::Mat rgb;
//     cv::cvtColor(translated, rgb, cv::COLOR_BGR2RGB);
//     m_image = QImage(rgb.data, rgb.cols, rgb.rows, rgb.step, QImage::Format_RGB888).copy();

//     emit imageChanged();
// }

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
