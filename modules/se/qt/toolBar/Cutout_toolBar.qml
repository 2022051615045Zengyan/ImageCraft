/** Cutout_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Cutout toolBar 图片切割
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: cutout

    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height

        Button {
            id: _cutout_cropping
            Layout.preferredWidth:parent.height*3
            text: qsTr("切除")
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/qiechubiankuang.svg"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1500
        }

    }
}
