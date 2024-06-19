import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import se.qt.menu 1.0
import se.qt.toolBar 1.0


ApplicationWindow
{
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
        id: psMenu
    }

    header: ICToolBar
    {
        id: psToolBar
        width: parent.width
    }
}
