/** Frame_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Frame toolBar 绘制框选范围，自动选中范围内的所有图片
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: frame

    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        RadioButton{
            id:_frame_keepAspect
            text:qsTr("保持比例")
            checked: true
        }

        RadioButton{
            id:_frame_freeScale
            text:qsTr("自由缩放")
            checked: false
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button {
            id: _frame_CounterSelection
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
