/** Menu_File.qml
 * Written by Rentianxiang on 2024-6-18
 * Funtion: File Menu
 *

 * Modified by ZhanXuecai on 2024-6-20
 * Function: close and closeall
 * Function: fresh and TakeAFullScreenshot

 * Modified by RenTianxiang on 2024-6-20
 *      modified export action
 *
 * Modified by RenTianxiang on 2024-6-22
 *      Added a new exit prompt to save the modified picture
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Menu
{
    id: file
    width: 250
    title: qsTr("文件(&F)")
    required property ListModel sharePage

    MyMenuItem
    {
        text: qsTr("新建(&N)")
        sequence: "Ctrl+N"
        icon.name: "document-new-symbolic"
        onTriggered:
        {
            ActiveCtrl.newImage()
        }
    }

    MyMenuItem
    {
        text: qsTr("打开(&O)...")
        sequence: "Ctrl+O"
        icon.name: "document-open"
        onTriggered:
        {
            ActiveCtrl.open()
        }
    }

    Menu
    {
        id: recentFileMenu
        icon.name: "document-open-recent"
        title: qsTr("最近打开文件(&T)")
        Repeater
        {
            model: ActiveCtrl.recentFiles
            MyMenuItem
            {
                text: modelData
                property ListModel sharePage: file.sharePage
                onTriggered:
                {
                    var fileName = text.substring(text.lastIndexOf("/") + 1) // 获取文件名
                    ActiveCtrl.addRecentFiles(text)
                    sharePage.append({ pageName: fileName,pixUrl_yuan: text})
                }

                HoverHandler
                {
                    id: recentFileHover
                }
                Component.onCompleted:
                {
                    recentFileMenu.width = Math.max(text.length * 7 + 10 + height, recentFileMenu.width)
                }

                Image
                {
                    width: parent.height
                    height: parent.height
                    anchors.top: parent.top
                    anchors.left: parent.right
                    anchors.leftMargin: - width
                    source: text
                    fillMode: Image.PreserveAspectFit
                    visible: recentFileHover.hovered
                }
            }
        }
    }

    MyMenuItem
    {
        text: qsTr("捕获屏幕截图")
        onTriggered:
        {
            ActiveCtrl.takeAFullScreenshot()
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("关闭(&C)")
        sequence: "Ctrl+W"
        icon.name: "document-close"
        onTriggered:
        {
            ActiveCtrl.close()
        }
    }

    MyMenuItem
    {
        text: qsTr("关闭全部")
        sequence: "Alt+Ctrl+W"
        icon.name: "geany-close-all"
        onTriggered:
        {
            ActiveCtrl.closeAll()
        }
    }

    MyMenuItem
    {
        text: qsTr("保存(&S)")
        sequence: "Ctrl+S"
        icon.name: "document-save"
        onTriggered:
        {
            ActiveCtrl.save()
        }
    }

    MyMenuItem
    {
        text: qsTr("保存为(&A)...")
        sequence: "Shift+Ctrl+S"
        icon.name: "document-save-as"
        onTriggered:
        {
            ActiveCtrl.saveAs()
        }
    }

    MyMenuItem
    {
        text: qsTr("导出(&X)...")
        icon.name: "document-export"
        onTriggered:
        {
            ActiveCtrl.exportImage()
        }
    }


    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("重新加载(&D)")
        sequence: "F5"
        icon.name: "view-refresh"
        onTriggered:
        {
            ActiveCtrl.refresh()
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("退出(&X)")
        sequence: "Ctrl+Q"
        icon.name: "application-exit"
        onTriggered:
        {
            ActiveCtrl.exitWindow()
        }
    }
}
