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
    title: qsTr("编辑(&E)")

    MyMenuItem{
        sequence: "Ctrl+Z"
        text:qsTr("撤销（&U)")
        icon.name: "edit-redo-symbolic-rtl"
        onTriggered: {
            ActiveCtrl.undo()
        }
    }

    MyMenuItem{
        sequence: "Shift+Ctrl+Z"
        text:qsTr("重做（&W)")
        icon.name: "edit-redo"
        onTriggered: {
            ActiveCtrl.redo()
        }
    }

    MenuSeparator{}

    MyMenuItem {
        sequence: "Ctrl+X"
        text: qsTr("剪切(&T)")
        icon.name: "edit-cut"
        onTriggered: {
            ActiveCtrl.cutImagetoClipboard()
        }
    }

    MyMenuItem {
        sequence: "Ctrl+C"
        text: qsTr("复制(&C)")
        icon.name: "edit-copy"
        onTriggered: {
            ActiveCtrl.copyImagetoClipboard()
        }
    }

    MyMenuItem {
        sequence: "Ctrl+V"
        text: qsTr("粘贴(&P)")
        icon.name: "edit-paste"
        onTriggered: {
            ActiveCtrl.pasteImageFromClipboard()
        }
    }

    MyMenuItem {
        sequence: "Ctrl+Shift+V"
        text: qsTr("粘贴到新窗口(&N)")
        onTriggered: {
            console.log("粘贴到新窗口已被点击")
        }
    }

    MyMenuItem {
        text: qsTr("删除选区内容(&D)...")
        onTriggered: {
            console.log("删除选区内容已被点击")
        }
    }

    MenuSeparator{}

    MyMenuItem {
        sequence:"Ctrl+A"
        text: qsTr("选择全部(&A)...")
        onTriggered: {
            console.log("选择全部已被点击")
        }
    }

    MyMenuItem {
        sequence:"Ctrl+Shift+A"
        text: qsTr("取消选择全部(&A)...")
        onTriggered: {
            console.log("选择全部已被点击")
        }
    }

    MenuSeparator{}

    MyMenuItem {
        text: qsTr("复制为文件(&O)...")
        onTriggered: {
            console.log("复制为文件已被点击")
        }
    }

    MyMenuItem{
        text: qsTr("粘贴文件内容（&F）...")
        onTriggered: {
            console.log("粘贴文件内容已被点击")
        }
    }


}
