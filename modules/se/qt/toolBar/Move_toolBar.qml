/** Move_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Move toolBar 对选中图片进行移动
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: move

    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        CheckBox {
            id: _move_AutomaticallySelected
            Layout.preferredWidth:parent.height*2.5
            text: qsTr("自动选择")
            checked: true

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _move_left
            Layout.preferredWidth:parent.height*3
            text: qsTr("居左")
            icon.source: "Icon/tupianjuzuo.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }
        Button {
            id: _move_center
            Layout.preferredWidth:parent.height*3
            text: qsTr("居中")
            icon.source: "Icon/tupianjuzhong.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }
        Button {
            id: _move_right
            Layout.preferredWidth:parent.height*3
            text: qsTr("居右")
            icon.source: "Icon/tupianjuyou.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }
        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _move_top
            Layout.preferredWidth:parent.height*3
            text: "居顶"
            icon.source: "Icon/tupianjuding.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Button {
            id: _move_bottom
            Layout.preferredWidth:parent.height*3
            text: "居底"
            icon.source: "Icon/tupianjudi.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredWidth: 1000
        }
    }
}
