/** MyToolBar.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: ToolBar integration
 */
import QtQuick
import QtQuick.Controls

Item
{
    id: toolBar
    width: parent.width
    height: topToolBar.height
    ToolBar
    {
        id: topToolBar
        width: parent.width
        height: 30
        anchors.left: parent.left
    }

    MoveToolBar
    {
        id: leftToolBar
        toolBar: toolBar
    }
}
