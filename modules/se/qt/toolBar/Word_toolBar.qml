/** Word_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Word toolBar 添加文字
*modified by Zengyan on 2024-7-6
 *   added textbox funtion
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
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

        // 创建一个 ListModel 用于管理多个 FontLoader
        ListModel {
            id: fontModel

            ListElement { source: "file:///root/ImageCraft/textfont/Foundegbigblack _GBK.ttf" }
            ListElement { source: "file:///root/ImageCraft/textfont/FounderthickSongJanebody.ttf" }
            ListElement { source: "file:///root/ImageCraft/textfont/bubblegum.ttf" }
            ListElement { source: "file:///root/ImageCraft/textfont/cinema.ttf" }
        }


        ComboBox
        {
            id: _text_family
            Layout.preferredWidth:parent.height*5.5
            model: ["方正大黑_GBK", "方正粗宋简体", "bubblegum","cinema"]

            Layout.fillWidth: true
            Layout.minimumWidth: 0
            currentIndex: 0
            onCurrentIndexChanged: {
                    // 当用户改变选项时触发
                    var familyname = fontModel.get(currentIndex).source;
                    // 调用 ToolCtrl.setTextFamily() 并传递选中项的值

                console.log("name:"+familyname);
                    ToolCtrl.setTextFamily(familyname);

            }
        }
        Label{
            text: "字号:"
        }

        ComboBox
        {
            id: _text_size
            Layout.preferredWidth:parent.height*3
            model:["6", "7", "8","9","10","11","12","14","16","18","20","22","24","26","28","36","48","72"]

            Layout.fillWidth: true
            Layout.minimumWidth: 0
            currentIndex: 6
            onCurrentIndexChanged: {
                Qt.callLater(function()
                {
                    // 当用户改变选项时触发
                    var wordsizestr = _text_size.model[currentIndex]
                    // 调用 ToolCtrl.setWordSize() 并传递选中项的值
                        var wordsize = parseInt(wordsizestr);
                    console.log(wordsize);
                    ToolCtrl.setWordSize(wordsize);
                });
            }
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button
        {
            id: _text_bold
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/jiacu.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            property bool bold: false
            onClicked: {
                if(!bold)
                    bold=true;
                else
                    bold=false;
                ToolCtrl.setBold(bold);
            }
        }

        Button
        {
            id: _text_italic
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/qingxie.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            property bool italic: false
            onClicked: {
                if(!italic)
                    italic=true;
                else
                    italic=false;
                ToolCtrl.setItalic(italic);

            }
        }

        Button
        {
            id: _text_underline
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/xiahuaxian.png"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            property bool  underline: false
            onClicked: {
                if(!underline)
                    underline=true;
                else
                    underline=false;
                ToolCtrl.setUnderline(underline);

            }
        }

        Button
        {
            id: _text_delete
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/shanchuxian.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            property bool strikeout: false
            onClicked: {
                if(!strikeout)
                    strikeout=true;
                else
                    strikeout=false;
                ToolCtrl.setStrikeout(strikeout);

            }
        }

        ToolSeparator{Layout.preferredHeight: parent.height}

        Button {
            id: _word_left
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/juzuo.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {

            }
        }
        Button {
            id: _word_center
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/juzhong.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {

            }
        }
        Button {
            id: _word_right
            Layout.preferredWidth:parent.height*3
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/juyou.png"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height

        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间

            Layout.preferredWidth:1000
        }
    }

}


