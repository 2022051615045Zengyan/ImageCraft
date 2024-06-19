/** Lasso_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Lasso toolBar 复杂抠图
 */
import QtQuick 2.15
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: lasso

    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        RadioButton{
            id:_lasso_manual
            text:qsTr("手动套索工具")
            checked: true
        }

        RadioButton{
            id:_lasso_automatic
            text:qsTr("自动套索工具")
            checked: false
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button {
            id: _lasso_CounterSelection
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
