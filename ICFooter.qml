/** ICFooter.qml
 * Written by ZengYan on 2024-6-19
 * Funtion: Setting bottom
 *  modified by Zengyan on 2024-6-20
 *      added getcolorfunction
 * modified by Zengyan on 2024-6-22
 *       added colorrectangles
 * modified by Zengyan on 2024-6-24
 * added choicecolorfunction, rightbottomtextshow
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import ImageCraft 1.0

Rectangle {
    id: footer
    width:parent.width
    property alias showcolor: _showcolor
    property alias text2: _text2
    property alias text3: _text3
    property alias  text1: _text1

    ColumnLayout
    {
        spacing:2
        Text
        {
            id: texttext
            Layout.preferredWidth:footer.width
            Layout.preferredHeight: footer.height/6
            text:qsTr("色板： 默认颜色")
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
                            onColorChanged: {

                            }
                        }
                        TapHandler{
                            onDoubleTapped: {
                                colorDialog.open()
                                selectedColor.selectedColor=_showcolor.color
                                console.log("colorDialog opened")
                            }
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

                            TapHandler {
                                onTapped: {
                                    _showcolor.color=model.color
                                }
                                onDoubleTapped: {
                                    colorDialog.open()
                                    console.log("colorDialog opened")
                                }
                            }
                        }
                        ColorDialog {
                            id: colorDialog
                            selectedColor:_showcolor.color
                            title: qsTr("Choose Color")
                            onAccepted: {
                                _showcolor.color = selectedColor
                            }
                        }
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
                    Layout.preferredWidth:bottomshow.width/7*5
                    Layout.preferredHeight: bottomshow.height
                    text: qsTr("Select: Select the layer that you want")
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

            }
        }
    }
    Connections{
    target: ToolCtrl
   function onSelectedToolChanged(){
       switch(ToolCtrl.selectedTool)
       {
       case "选择":
           text1.text=qsTr("Select: Select the layer that you want.");
           break;
        case "图框":
            text1.text=qsTr("Picture box: You are using the picture box function.");
              break;
        case "移动":
            text1.text=qsTr("Move: Please move your picture.");
              break;
        case "抓手":
            text1.text=qsTr("Gripper: You are using the grip function.");
              break;
        case "框选":
            text1.text=qsTr("Box selection: Please select the box operation.");
              break;
        case "套索工具":
            text1.text=qsTr("Lasso tool: Please select the area where you want to perform the lasso.");
              break;
        case "裁剪":
            text1.text=qsTr("Crop: Please select the area you want to crop.");
              break;
        case "文字":
            text1.text=qsTr("Text: You are using the Add text feature.");
              break;
        case "吸管":
            text1.text=qsTr("Sucker: You choose the color point you want to absorb.");
              break;
        case "矩阵":
            text1.text=qsTr("Matrix: Please draw the matrix you want.");
              break;
        case "线条":
            text1.text=qsTr("Lines: Please draw the lines you want.");
              break;
        case "画笔":
            text1.text=qsTr("Brush: You are painting using a paintbrush.");
              break;
        case "橡皮擦":
            text1.text=qsTr("Eraser: You are using the eraser to erase the selected area.");
              break;
        case "缩放":
            text1.text=qsTr("Zoom: Please select the multiple of your zoom.");
              break;
       }

    }
    }

    Component.onCompleted: {
        ToolCtrl.showcolor=showcolor
        ToolCtrl.pointtext=text2
        ToolCtrl.imageSize=text3

    }
}


