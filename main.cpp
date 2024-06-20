/** main.cpp
 * Written by Rentianxiang on 2024-6-20
 * Funtion: main function
 */
#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "imageprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    //设置组织和应用标识
    QCoreApplication::setOrganizationName("cqnu");
    QCoreApplication::setOrganizationDomain("cqnu.com");
    QCoreApplication::setApplicationName("ImageCraft");

    app.setWindowIcon(QIcon(":/icon/ImageCraft_Icon.png"));

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("imageProvider", ImageProvider::instance());
    engine.addImageProvider(QLatin1String("editorimage"), ImageProvider::instance());
    engine.loadFromModule("ImageCraft", "ImageCraft");

    return app.exec();
}
