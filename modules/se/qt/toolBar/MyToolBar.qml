import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item
{
    id: toolBar
    width: parent.width
    height: topToolBar.height
    ToolBar
    {
        id: topToolBar
        width: parent.width
        height: 30
        anchors.left: parent.left

        Choice_toolBar
        {
            visible: listView.currentIndex === 0 ? true : false
        }

        Frame_toolBar
        {
            visible: listView.currentIndex === 1 ? true:false
        }

        Move_toolBar
        {
            visible: listView.currentIndex === 2 ? true : false
        }

        Grip_toolBar
        {
            visible: listView.currentIndex === 3 ? true : false
        }

        Boxselect_toolBar
        {
            visible: listView.currentIndex === 4 ? true : false
        }

        Lasso_toolBar
        {
            visible: listView.currentIndex === 5 ? true : false
        }

        Cutout_toolBar
        {
            visible: listView.currentIndex === 6 ? true : false
        }

        Word_toolBar
        {
            visible: listView.currentIndex === 7 ? true : false
        }

        Straw_toolBar
        {
            visible: listView.currentIndex === 8 ? true : false
        }

        Rectangle_toolBar
        {
            visible: listView.currentIndex === 9 ? true : false
        }

        Line_toolBar
        {
            visible: listView.currentIndex === 10 ? true : false
        }

        Brush_toolBar
        {
            visible: listView.currentIndex === 11 ? true : false
        }

        Eraser_toolBar
        {
            visible: listView.currentIndex === 12 ? true : false
        }

        Zoom_toolBar
        {
            visible: listView.currentIndex === 13 ? true : false
        }

    }

    Rectangle
    {
        id: leftToolBar
        property bool rightAble: (x > (toolBar.width - width * 2 / 3) && !rightShow.running)
        property bool leftAble: (x < -(width / 3) && !leftShow.running)
        property bool isPressed: false
        color: "grey"
        width: listView.width
        height: 775
        y: topToolBar.height + menuBar.height - 20
        radius: 10
        clip: true
        ListView
        {
            id: listView
            x: 8
            y: 53
            width: 160
            height: 825
            anchors.top: parent.top
            property string thisName: "文字"
            model: ListModel
            {

                ListElement
                {
                    btnIcon: "./Icon/choose.svg"
                    name: "选择"
                }

                ListElement
                {
                    btnIcon: "./Icon/frame.svg"
                    name: "图框"
                }

                ListElement
                {
                    btnIcon: "./Icon/move.svg"
                    name: "移动"
                }

                ListElement
                {
                    btnIcon: "./Icon/Grip.svg"
                    name: "抓手"
                }

                ListElement
                {
                    btnIcon: "./Icon/box.svg"
                    name: "框选"
                }

                ListElement
                {
                    btnIcon: "./Icon/lasso.svg"
                    name: "套索工具"
                }

                ListElement
                {
                    btnIcon: "./Icon/tailor.svg"
                    name: "裁剪"
                }

                ListElement
                {
                    btnIcon: "./Icon/word.svg"
                    name: "文字"
                }

                ListElement
                {
                    btnIcon: "./Icon/straw.svg"
                    name: "吸管"
                }

                ListElement
                {
                    btnIcon: "./Icon/Matrix.svg"
                    name: "矩阵"
                }

                ListElement
                {
                    btnIcon: "./Icon/Line.svg"
                    name: "线条"
                }

                ListElement
                {
                    btnIcon: "./Icon/brush.svg"
                    name: "画笔"
                }

                ListElement
                {
                    btnIcon: "./Icon/eraser.svg"
                    name: "橡皮擦"
                }

                ListElement
                {
                    btnIcon: "./Icon/zoom.svg"
                    name: "缩放"
                }
            }
            delegate: listViewDelegate

            header: Rectangle{
                color: Qt.rgba(51/255, 51/255, 51/255, 0)
                width: parent.width
                height:20
                radius: width
            }
        }

        Component
        {
            id: listViewDelegate
            Rectangle
            {
                property bool isHoverd: false
                property bool isThisBtn: listView.thisName === name  //当前按钮是否被选中
                width: 145
                height: 50
                radius: 50
                color: isHoverd ? Qt.rgba(135/255, 206/255, 250/255, 1) : "#00000000"
                Rectangle
                {
                    width: parent.isThisBtn ? parent.width : 0
                    height: parent.height
                    radius: parent.radius
                    color: Qt.rgba(0, 191/255, 1, 1)
                    Behavior on width {
                        NumberAnimation
                        {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                Row
                {
                    spacing: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: parent.radius / 4
                    Image
                    {
                        width: 20
                        height: width
                        source: btnIcon
                        sourceSize: Qt.size(32, 32)
                    }
                    Text
                    {
                        font.bold: isThisBtn ? true : false
                        scale: isThisBtn ? 1.1 : 1
                        text: name
                        color: "white"
                        Behavior on scale {
                            NumberAnimation
                            {
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked:
                    {
                        listView.currentIndex = index
                        listView.thisName = name
                    }
                    onEntered:
                    {
                        parent.isHoverd = true
                    }
                    onExited:
                    {
                        parent.isHoverd = false
                    }
                }
            }
        }
    }
}

