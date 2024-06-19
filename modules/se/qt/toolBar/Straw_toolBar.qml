/** Straw_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Straw toolBar
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: straw
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        Label{
            text: "取样记录:"
        }

        ComboBox {
            id: _straw_SampleRecords
            Layout.preferredWidth:parent.height*3
            model: ["样本1","样本2"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间

            Layout.preferredWidth:1000
        }

    }


}


