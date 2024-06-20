/** ICFooter.qml
 * Written by ZengYan on 2024-6-19
 * Funtion: Setting bottom
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: footer
    width:parent.width
    ColumnLayout{
        spacing:2
        Text {
            id: texttext
            Layout.preferredWidth:footer.width
            Layout.preferredHeight: footer.height/6
            text:qsTr("色板： 默认颜色")
            // verticalAlignment: Text.AlignVCenter // 垂直居中
        }
        MenuSeparator{
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
                    id: text1

                    Layout.preferredWidth:bottomshow.width/7*3
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("矩形：拖动即可进行绘制。")

                }
                Label{
                    id:text2
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("x:0,y:0")

                }
                Label {
                    id: text3
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("400*300")

                }
                Label {
                    id: text4
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("32位色")

                }
                Label{
                    id: text5
                    Layout.preferredWidth:bottomshow.width/7
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("100%")
                }
            }
        }
    }

}
