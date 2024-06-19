import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

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
}
