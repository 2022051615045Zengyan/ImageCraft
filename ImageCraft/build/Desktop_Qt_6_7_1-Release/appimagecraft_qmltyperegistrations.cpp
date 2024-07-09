/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#include <activectrl.h>
#include <editor.h>
#include <toolctrl.h>


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_ImageCraft()
{
    qmlRegisterTypesAndRevisions<ActiveCtrl>("ImageCraft", 1);
    qmlRegisterTypesAndRevisions<Editor>("ImageCraft", 1);
    qmlRegisterTypesAndRevisions<ToolCtrl>("ImageCraft", 1);
    qmlRegisterModule("ImageCraft", 1, 0);
}

static const QQmlModuleRegistration imageCraftRegistration("ImageCraft", qml_register_types_ImageCraft);
