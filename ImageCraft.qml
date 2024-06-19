/** ImageCraft.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: Main Window
 */

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import se.qt.menu 1.0
import se.qt.toolBar 1.0

ApplicationWindow
{
    id: window
    width: 1000
    height: 500
    visible: true
    title: qsTr("ImageCraft")
    color: "white"
    minimumWidth: 800  // 设置最小宽度为800像素
    minimumHeight: 400

    menuBar: ICMenu
    {
        width: parent.width
        id: icMenu
    }

    header: ICToolBar
    {
        id: icToolBar
        width: parent.width
    }

    ICContent
    {
        id: icContent
        height: parent.height - icMenu.height - icToolBar.height
        width: parent.width
    }
}
