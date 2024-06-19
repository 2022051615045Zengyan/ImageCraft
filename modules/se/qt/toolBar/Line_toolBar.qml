/** Line_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Line toolBar
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: line_toolBar
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        Button {
            id: _line_beeline
            text: "直线"
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ComboBox{
            id: _line_beeline_size
            Layout.preferredWidth:parent.height*3
            model: ["极细","细","较细","均衡","较粗","粗","极粗"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }


        Button {
            id: _line_polyline
            text: "折线"
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            property bool isclicked:true
            enabled: isclicked
            onClicked: {
                enabled=!isclicked
            }
        }

        ComboBox{
            id: _line_polyline_size
            Layout.preferredWidth:parent.height*3
            model: ["极细","细","较细","均衡","较粗","粗","极粗"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _line_curve
            text: "曲线"
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ComboBox{
            id: _line_curve_size
            Layout.preferredWidth:parent.height*3
            model: ["极细","细","较细","均衡","较粗","粗","极粗"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }

    }


}
