/** MyMenuItem.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Customize menuitem
 */
import QtQuick
import QtQuick.Controls

MenuItem
{
    id: item
    property string sequence
    property string title
    icon.source:"qrc:/modules/se/qt/menu/icon/noneIcon.png"



    Shortcut
    {
        id: shortcut
        sequence: item.sequence
        onActivated:
        {
            item.triggered()
        }
    }

    Row
    {
        id: row
        spacing: 10
        width: parent.width
        height: 40  // 根据需要调整高度
        anchors.top: parent.top
        anchors.topMargin: 5

        Text
        {
            id: ti
            text: item.title
            color: enabled ? "black" : "grey"
            verticalAlignment: Text.AlignVCenter
            leftPadding: 20
        }



        Item
        {
            id: spacer
            width: parent.width - ti.width - se.width - row.spacing * 2
            height: parent.height
        }

        Text
        {
            id: se
            text: item.sequence
            color: enabled ? "black" : "grey"
            rightPadding: 20
            verticalAlignment: Text.AlignVCenter
        }
    }
}
