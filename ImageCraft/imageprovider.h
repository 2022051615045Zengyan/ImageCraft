/** imageprovider.h
 * Wirtten by ZengYan on 2024-6-20
 * Funtion: provider image to QML
 */
#pragma once

#include <QQmlEngine>
#include <QQuickImageProvider>
#include "editor.h"

class ImageProvider : public QQuickImageProvider
{
    Q_OBJECT
public:
    static ImageProvider *instance();

    ~ImageProvider();

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

    Q_INVOKABLE void setImage(const QImage &image);

    Q_INVOKABLE void setEditor(Editor *editor);

private:
    static ImageProvider *m_instance;

    ImageProvider();

    QImage m_image;
    Editor *m_currentEditor = nullptr;
};
