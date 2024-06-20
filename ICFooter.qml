/** ICFooter.qml
 * Written by ZengYan on 2024-6-19
 * Funtion: Setting bottom
 * * modified by Zengyan on 2014-6-20
 *      added getcolorfunction
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Rectangle {
    id: footer
    width:parent.width
    property alias showcolor: _showcolor
    property alias text2: _text2
    ColumnLayout
    {
        spacing:2
        Text
        {
            id: texttext
            Layout.preferredWidth:footer.width
            Layout.preferredHeight: footer.height/6
            text:qsTr("色板： 默认颜色")
            // verticalAlignment: Text.AlignVCenter // 垂直居中
        }
        MenuSeparator
        {
            id:separator
            Layout.preferredWidth: footer.width
        } //间隔符
        Rectangle{
            id:colorshow
            Layout.preferredWidth:footer.width
            Layout.preferredHeight: footer.height/6*3
            RowLayout{
                Rectangle{
                    Layout.preferredWidth:colorshow.width/7
                    Layout.preferredHeight: colorshow.height
                    Rectangle
                    {
                        id: _showcolor
                        width:height
                        height: parent.height-10
                        color: "#ddff00"
                        anchors.centerIn: parent
                    }
                }
                Rectangle{
                    Layout.preferredWidth:colorshow.width/6*2
                    Layout.preferredHeight: colorshow.height
                }
                Rectangle{
                    Layout.preferredWidth:colorshow.width/6
                    Layout.preferredHeight: colorshow.height
                    color: "#a02dd5"
                }
            }
            color: "#00fffb"
        }
        MenuSeparator{
            id:separator2
            Layout.preferredWidth: footer.width
        }
        Rectangle{
            id:bottomshow
            Layout.preferredWidth:footer.width
            Layout.preferredHeight: footer.height/6
            /*footer.height-texttext.height-colorshow.height*/
            RowLayout{
                spacing: 5
                Label {
                    id: _text1

                    Layout.preferredWidth:bottomshow.width/7*3
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("矩形：拖动即可进行绘制。")

                }
                Label{
                    id:_text2
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("x:0,y:0")

                }
                Label {
                    id: _text3
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("400*300")

                }
                Label {
                    id: _text4
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("32位色")

                }
                Label{
                    id: _text5
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("100%")
                }
            }
        }
    }

    Component.onCompleted: {
        ToolCtrl.showcolor=showcolor
        ToolCtrl.pointtext=text2

    }
}


