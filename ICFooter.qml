/** ICFooter.qml
 * Written by ZengYan on 2024-6-19
 * Funtion: Setting bottom
 *  modified by Zengyan on 2014-6-20
 *      added getcolorfunction
 * modified by Zengyan on 2014-6-22
 *       added colorrectangles
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
                        width:height
                        height: parent.height-2
                        anchors.centerIn: parent
                        border.color: "#c0c0c0"
                        color:"transparent"
                        Rectangle{
                        id: _showcolor
                        width:height
                        height: parent.height-15
                        color: "#ddff00"
                        border.color: "#c0c0c0"

                        anchors.centerIn: parent
                        }
                    }
                }
                Rectangle{
                    id:colorrectangle
                    Layout.preferredWidth:colorshow.width/7*3
                    Layout.preferredHeight: colorshow.height
                    ListModel {
                        id: colorModel
                        // 22 个不同的颜色，每排 11 个方块，共两行
                        ListElement { color: "black" }
                        ListElement { color: "#808080" }
                        ListElement { color: "red" }
                        ListElement { color: "#ff8000" }
                        ListElement { color: "yellow" }
                        ListElement { color: "#00ff00" }
                        ListElement { color: "#00ffff" }
                        ListElement { color: "#0000ff" }
                        ListElement { color: "#ff00ff" }
                        ListElement { color: "#ff8080" }
                        ListElement { color: "#80ff80" }

                        ListElement { color: "white" }
                        ListElement { color: "#c0c0c0" }
                        ListElement { color: "#800000" }
                        ListElement { color: "#804000" }
                        ListElement { color: "#808000" }
                        ListElement { color: "#008000" }
                        ListElement { color: "#008080" }
                        ListElement { color: "#000080" }
                        ListElement { color: "#800080" }
                        ListElement { color: "#8080ff" }
                        ListElement { color: "#ffff80" }
                    }

                    GridView {
                        anchors.fill: parent
                        model: colorModel
                        cellWidth: parent.width/11
                        cellHeight: parent.height/2


                        delegate: Rectangle {
                            width:parent.width/11-1
                            height:parent.height/2-1
                            color: model.color
                            border.color: "#c0c0c0"
                        }
            //             Timer{
            //                 id: clickTimer //超过300ms(典型延时时间)还没有触发第二次点击证明是单击
            //                 property int clickNum: 0

            //                 interval: 300;
            //                 onTriggered: {
            //                     if(isFullScreen){
            //                         clickNum = 0;
            //                         clickTimer.stop();
            //                         window();
            //                     }else{
            //                         clickNum = 0;
            //                         clickTimer.stop();
            //                         Controller.multiView();
            //                     }
            //                 }
            //             }
            //             TapHandler {

            //                 onTapped: {
            //                     clickTimer.clickNum++
            //                     if(clickTimer.clickNum == 1) {
            //                         clickTimer.start()
            //                     }
            //                     if(clickTimer.clickNum == 2) {
            //                         clickTimer.clickNum = 0
            //                         clickTimer.stop()
            //                         fullScreen()
            //                     }
            //                 }
            //             }
                    }

                }

            }

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


