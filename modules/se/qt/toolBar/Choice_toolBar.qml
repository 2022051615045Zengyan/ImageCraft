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
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        RadioButton{
            id:_choice_keepAspect
            text:qsTr("保持比例")
            checked: true
        }

        RadioButton{
            id:_choice_freeScale
            text:qsTr("自由缩放")
            checked: false
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button {
            id: _choice_CounterSelection
            Layout.preferredWidth:parent.height*3
            text: qsTr("反选")
            icon.source: "Icon/fanxuan.svg"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }


        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }
    }
}
