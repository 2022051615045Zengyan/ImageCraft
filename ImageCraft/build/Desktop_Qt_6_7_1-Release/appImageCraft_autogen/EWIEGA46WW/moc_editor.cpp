/****************************************************************************
** Meta object code from reading C++ file 'editor.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.7.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../editor.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'editor.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.7.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSEditorENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSEditorENDCLASS = QtMocHelpers::stringData(
    "Editor",
    "QML.Element",
    "auto",
    "imageChanged",
    "",
    "pathChanged",
    "brushColorChanged",
    "brushSizeChanged",
    "currentShapeChanged",
    "previewImageChanged",
    "tempImageChanged",
    "imageStatusChanged",
    "setImage",
    "newImage",
    "openImage",
    "path",
    "copyImage",
    "image"
);
#else  // !QT_MOC_HAS_STRINGDATA
#error "qtmochelpers.h not found or too old."
#endif // !QT_MOC_HAS_STRINGDATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSEditorENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       1,   14, // classinfo
      11,   16, // methods
       2,   97, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       8,       // signalCount

 // classinfo: key, value
       1,    2,

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       3,    0,   82,    4, 0x06,    3 /* Public */,
       5,    0,   83,    4, 0x06,    4 /* Public */,
       6,    0,   84,    4, 0x06,    5 /* Public */,
       7,    0,   85,    4, 0x06,    6 /* Public */,
       8,    0,   86,    4, 0x06,    7 /* Public */,
       9,    0,   87,    4, 0x06,    8 /* Public */,
      10,    0,   88,    4, 0x06,    9 /* Public */,
      11,    0,   89,    4, 0x06,   10 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      12,    1,   90,    4, 0x02,   11 /* Public */,
      14,    1,   93,    4, 0x02,   13 /* Public */,
      16,    0,   96,    4, 0x02,   15 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QImage,   13,
    QMetaType::Void, QMetaType::QString,   15,
    QMetaType::QImage,

 // properties: name, type, flags
      17, QMetaType::QImage, 0x00015903, uint(0), 0,
      15, QMetaType::QString, 0x00015903, uint(1), 0,

       0        // eod
};

Q_CONSTINIT const QMetaObject Editor::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_CLASSEditorENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSEditorENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_metaTypeArray<
        // property 'image'
        QImage,
        // property 'path'
        QString,
        // Q_OBJECT / Q_GADGET
        Editor,
        // method 'imageChanged'
        void,
        // method 'pathChanged'
        void,
        // method 'brushColorChanged'
        void,
        // method 'brushSizeChanged'
        void,
        // method 'currentShapeChanged'
        void,
        // method 'previewImageChanged'
        void,
        // method 'tempImageChanged'
        void,
        // method 'imageStatusChanged'
        void,
        // method 'setImage'
        void,
        QImage,
        // method 'openImage'
        void,
        const QString &,
        // method 'copyImage'
        QImage
    >,
    nullptr
} };

void Editor::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Editor *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->imageChanged(); break;
        case 1: _t->pathChanged(); break;
        case 2: _t->brushColorChanged(); break;
        case 3: _t->brushSizeChanged(); break;
        case 4: _t->currentShapeChanged(); break;
        case 5: _t->previewImageChanged(); break;
        case 6: _t->tempImageChanged(); break;
        case 7: _t->imageStatusChanged(); break;
        case 8: _t->setImage((*reinterpret_cast< std::add_pointer_t<QImage>>(_a[1]))); break;
        case 9: _t->openImage((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 10: { QImage _r = _t->copyImage();
            if (_a[0]) *reinterpret_cast< QImage*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::imageChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::pathChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::brushColorChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::brushSizeChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::currentShapeChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::previewImageChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::tempImageChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (Editor::*)();
            if (_t _q_method = &Editor::imageStatusChanged; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 7;
                return;
            }
        }
    } else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<Editor *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QImage*>(_v) = _t->image(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->path(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<Editor *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setImage(*reinterpret_cast< QImage*>(_v)); break;
        case 1: _t->setPath(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
}

const QMetaObject *Editor::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Editor::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSEditorENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Editor::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 11)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 11;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 11)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 11;
    }else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    }
    return _id;
}

// SIGNAL 0
void Editor::imageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void Editor::pathChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void Editor::brushColorChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void Editor::brushSizeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void Editor::currentShapeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void Editor::previewImageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void Editor::tempImageChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 6, nullptr);
}

// SIGNAL 7
void Editor::imageStatusChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 7, nullptr);
}
QT_WARNING_POP
