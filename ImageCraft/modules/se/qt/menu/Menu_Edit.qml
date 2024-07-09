/** Menu_Edit.qml
 * Written by ZhanXuecai on 2024-6-18
 * Funtion: Edit Menu
 */
import QtQuick
import QtQuick.Controls
import ImageCraft

Menu {
    width: 300
    id:edit
    title: qsTr("Edit(&E)")

    MyMenuItem{
        sequence: "Ctrl+Z"
        text:qsTr("Undo（&U)")
        icon.name: "edit-redo-symbolic-rtl"
        onTriggered: {
            ActiveCtrl.undo()
        }
    }

    MyMenuItem{
        sequence: "Shift+Ctrl+Z"
        text:qsTr("Redo（&W)")
        icon.name: "edit-redo"
        onTriggered: {
            ActiveCtrl.redo()
        }
    }

    MenuSeparator{}

    MyMenuItem {
        sequence: "Ctrl+X"
        text: qsTr("Cut(&T)")
        icon.name: "edit-cut"
        onTriggered: {
            ActiveCtrl.cutImagetoClipboard()
        }
    }

    MyMenuItem {
        sequence: "Ctrl+C"
        text: qsTr("Copy(&C)")
        icon.name: "edit-copy"
        onTriggered: {
            ActiveCtrl.copyImagetoClipboard()
        }
    }

    MyMenuItem {
        sequence: "Ctrl+V"
        text: qsTr("Paste(&P)")
        icon.name: "edit-paste"
        onTriggered: {
            ActiveCtrl.pasteImageFromClipboard()
        }
    }
}
