/** Boxselect_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Boxselect toolBar
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: boxselect

    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        RadioButton{
            id:_boxselect_freeselect
            text:qsTr("自由框选")
            checked: true
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        RadioButton{
            id:_boxselect_recselect
            text:qsTr("矩阵框选")
            checked: false
        }

        RadioButton{
            id:_boxselect_circleselect
            text:qsTr("圆形框选")
            checked: false
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button {
            id: _boxselect_CounterSelection
            Layout.preferredWidth:parent.height*3
            text: qsTr("反选")
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间

            Layout.preferredWidth:1000
        }
    }
}
