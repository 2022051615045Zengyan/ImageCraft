/** imageprovider.h
 * Wirtten by ZengYan on 2024-6-20
 * Funtion: provider image to QML
 */
#include "imageprovider.h"

ImageProvider *ImageProvider::m_instance = nullptr;

ImageProvider::ImageProvider()
    : QQuickImageProvider(QQuickImageProvider::Image)
{}

ImageProvider *ImageProvider::instance()
{
    if (!m_instance) {
        m_instance = new ImageProvider();
    }
    return m_instance;
}

ImageProvider::~ImageProvider()
{
    // if (m_instance) {
    //     delete m_instance;
    //     m_instance = nullptr;
    // }
}

QImage ImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);

    if (size) {
        *size = m_image.size();
    }

    if (requestedSize.width() > 0 && requestedSize.height() > 0) {
        return m_image.scaled(requestedSize.width(), requestedSize.height(), Qt::KeepAspectRatio);
    }

    return m_image;
}

void ImageProvider::setImage(const QImage &image)
{
    m_image = image;
}

void ImageProvider::setEditor(Editor *editor)
{
    m_currentEditor = editor;
    if (m_currentEditor) {
        setImage(m_currentEditor->image());
    }
}
