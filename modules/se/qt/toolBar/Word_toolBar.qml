/** Word_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Word toolBar 添加文字
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item
{
    id: word
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        Label{
            text: "字体:"
        }

        ComboBox
        {
            id: _text_family
            Layout.preferredWidth:parent.height*3
            model: ["宋体", "楷体", "草书","微软雅黑"]

            Layout.fillWidth: true
            Layout.minimumWidth: 0
        }

        Label{
            text: "字号:"
        }

        ComboBox
        {
            id: _text_size
            Layout.preferredWidth:parent.height*1.5
            model: ["6", "7", "8","9","10","11","12","14","16","18","20","22","24","26","28","36","48","72"]

            Layout.fillWidth: true
            Layout.minimumWidth: 0
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button
        {
            id: _text_bold
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/jiacu.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Button
        {
            id: _text_italic
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/qingxie.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Button
        {
            id: _text_underline
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/xiahuaxian.png"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Button
        {
            id: _text_delete
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/shanchuxian.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button {
            id: _word_left
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/juzuo.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }
        Button {
            id: _word_center
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/juzhong.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }
        Button {
            id: _word_right
            Layout.preferredWidth:parent.height*3
            icon.source: "Icon/juyou.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间

            Layout.preferredWidth:1000
        }
    }
}

