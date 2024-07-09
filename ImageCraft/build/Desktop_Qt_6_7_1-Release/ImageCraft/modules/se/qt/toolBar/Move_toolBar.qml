/** Move_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Move toolBar 对选中图片进行移动
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: move
    Label{
        anchors.top: parent.top
        anchors.topMargin: 5
        id:_choice_freeScale
        text:qsTr("Free Moving")
    }
}
