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
    title: qsTr("File(&F)")
    required property ListModel sharePage

    MyMenuItem
    {
        text: qsTr("New(&N)")
        sequence: "Ctrl+N"
        icon.name: "document-new-symbolic"
        onTriggered:
        {
            ActiveCtrl.newImage()
        }
    }

    MyMenuItem
    {
        text: qsTr("Open(&O)...")
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
        title: qsTr("Open recent(&T)")
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
        text: qsTr("Capture screen shot")
        onTriggered:
        {
            ActiveCtrl.takeAFullScreenshot()
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("Close(&C)")
        sequence: "Ctrl+W"
        icon.name: "document-close"
        onTriggered:
        {
            ActiveCtrl.close()
        }
    }

    MyMenuItem
    {
        text: qsTr("CloseAll")
        sequence: "Alt+Ctrl+W"
        icon.name: "geany-close-all"
        onTriggered:
        {
            ActiveCtrl.closeAll()
        }
    }

    MyMenuItem
    {
        text: qsTr("Save(&S)")
        sequence: "Ctrl+S"
        icon.name: "document-save"
        onTriggered:
        {
            ActiveCtrl.save()
        }
    }

    MyMenuItem
    {
        text: qsTr("SaveAs(&A)...")
        sequence: "Shift+Ctrl+S"
        icon.name: "document-save-as"
        onTriggered:
        {
            ActiveCtrl.saveAs()
        }
    }

    MyMenuItem
    {
        text: qsTr("Export(&X)...")
        icon.name: "document-export"
        onTriggered:
        {
            ActiveCtrl.exportImage()
        }
    }


    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("Refresh(&D)")
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
        text: qsTr("Exit(&X)")
        sequence: "Ctrl+Q"
        icon.name: "application-exit"
        onTriggered:
        {
            ActiveCtrl.exitWindow()
        }
    }
}
