/** Choice_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: choice toolBar 单击一张图片，对单个图片选中，对图片大小调整
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: choice

    anchors.fill: parent
    Label{
        anchors.top: parent.top
        anchors.topMargin: 5
        id:_choice_freeScale
        text:qsTr("Free Scaling")
    }
}
