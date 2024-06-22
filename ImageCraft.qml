/** ImageCraft.qml
 * Written by ZengYan on 2024-6-19
 * Funtion: Setting Menubottom
 */
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "modules/se/qt/menu"
import "modules/se/qt/toolBar"

ApplicationWindow
{
    id:window
    width: 1000
    height: 500
    visible: true
    title: qsTr("ImageCraft")
    color: "pink"
    minimumWidth: 800  // 设置最小宽度为800像素
    minimumHeight: 400

    menuBar: ICMenu
    {
        id: icMenu
        width: parent.width
        sharePage: icContent.pageModel
    }

    header: ICToolBar
    {
        id: icToolBar
        width: parent.width
    }

    ICContent
    {
        id: icContent
        height: window.height - icMenu.height - icToolBar.height - icFooter.height
        width: parent.width
    }

    footer: ICFooter
    {
        id: icFooter
        height: 100
    }

    DialogBox   //管理弹出对话框
    {
        id: dialogBox
        objectName: "dialogBox"
        sharePage: icContent.pageModel
        tabBar_currentIndex: icContent.tags.currentIndex
    }
}
