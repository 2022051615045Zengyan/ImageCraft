/** Brush_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Brush toolBar 自由绘制
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: brush
    anchors.fill: parent

    RowLayout{
        width: parent.width
        height: parent.height

        Button {
            id: _brush_Paintbrush
            icon.source: "Icon/huabi.png"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Label{
            text:"画笔大小:"
        }

        ComboBox{
            id: _brush_Paintbrush_Size
            Layout.preferredWidth:parent.height*3
            model: ["极细","细","较细","均衡","较粗","粗","极粗"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Label{
            text:"画笔类型:"
        }

        ComboBox{
            id: _brush_Paintbrush_Family
            Layout.preferredWidth:parent.height*3
            model: ["⚫","⬛","/","\\"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _brush_Pen
            text: "钢笔"
            icon.source: "Icon/gangbi.png"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _line_spray
            text: "喷漆"
            icon.source: "Icon/penqi.png"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Label{
            text:"喷漆大小:"
        }

        ComboBox{
            id: _line_spray_size
            Layout.preferredWidth:parent.height*3
            model: ["小杯","中杯","大杯"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }

    }


}


