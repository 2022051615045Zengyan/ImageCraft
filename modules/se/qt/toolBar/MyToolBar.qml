/** MyToolBar.qml
<<<<<<< HEAD
 * Written by RenTianxiang on 2024-6-19
 * Funtion: ToolBar integration
=======
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Toolbar integration
>>>>>>> dev
 */
import QtQuick
import QtQuick.Controls

Item
{
    id: toolBar
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

        Frame_toolBar
        {
            visible: listView.currentIndex === 1 ? true:false
        }

        Move_toolBar
        {
            visible: listView.currentIndex === 2 ? true : false
        }

        Grip_toolBar
        {
            visible: listView.currentIndex === 3 ? true : false
        }

        Boxselect_toolBar
        {
            visible: listView.currentIndex === 4 ? true : false
        }

        Lasso_toolBar
        {
            visible: listView.currentIndex === 5 ? true : false
        }

        Cutout_toolBar
        {
            visible: listView.currentIndex === 6 ? true : false
        }

        Word_toolBar
        {
            visible: listView.currentIndex === 7 ? true : false
        }

        Straw_toolBar
        {
            visible: listView.currentIndex === 8 ? true : false
        }

        Rectangle_toolBar
        {
            visible: listView.currentIndex === 9 ? true : false
        }

        Line_toolBar
        {
            visible: listView.currentIndex === 10 ? true : false
        }

        Brush_toolBar
        {
            visible: listView.currentIndex === 11 ? true : false
        }

        Eraser_toolBar
        {
            visible: listView.currentIndex === 12 ? true : false
        }

        Zoom_toolBar
        {
            visible: listView.currentIndex === 13 ? true : false
        }

    }
    MoveToolBar
    {
        id: leftToolBar
        toolBar: toolBar
    }
}

