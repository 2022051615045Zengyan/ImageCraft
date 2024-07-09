/** MyToolBar.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: ToolBar integration
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Toolbar integration
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Item
{
    id: toolBar
    property bool toolbarvisible: true
    visible:toolbarvisible
    width: parent.width
    height: topToolBar.height
    property ListView listView: leftToolBar.listView
    ToolBar
    {
        id: topToolBar
        width: parent.width
        height: 30
        anchors.left: parent.left

        Choice_toolBar
        {
            visible: listView.currentIndex === 0 ? true : false
        }

        Move_toolBar
        {
            visible: listView.currentIndex === 1 ? true : false
        }

        Word_toolBar
        {
            visible: listView.currentIndex === 2 ? true : false
        }

        Straw_toolBar
        {
            visible: listView.currentIndex === 3 ? true : false
        }

        Rectangle_toolBar
        {
            visible: listView.currentIndex === 4 ? true : false
        }

        Line_toolBar
        {
            visible: listView.currentIndex === 5 ? true : false
        }

        Brush_toolBar
        {
            visible: listView.currentIndex === 6 ? true : false
        }

        Eraser_toolBar
        {
            visible: listView.currentIndex === 7 ? true : false
        }

        Zoom_toolBar
        {
            visible: listView.currentIndex === 8 ? true : false
        }

    }
    MoveToolBar
    {
        id: leftToolBar
        toolBar: toolBar
    }
    Component.onCompleted: {
        ActiveCtrl.toolBar=toolBar
    }
}

