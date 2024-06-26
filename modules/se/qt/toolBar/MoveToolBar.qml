/** MoveToolBar.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: Moveable toolBar contrl top toolBar
 */
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import ImageCraft 1.0

Item
{
    required property Item toolBar
    property alias listView: _listView
    Rectangle
    {
        id: leftToolBar
        property bool rightAble: (x > (toolBar.width - width * 2 / 3) && !rightShow.running)
        property bool leftAble: (x < -(width / 3) && !leftShow.running)
        property bool justRightShow: false
        property bool justLeftShow: false
        property bool isPressed: false
        color: "grey"
        width: listView.width
        height: Window.height / 4 * 3 + 20
        y: topToolBar.height + menuBar.height - 20
        radius: 10
        clip: true
        Rectangle
        {
            id: moveAbleArea
            color: "grey"
            width: listView.width
            height:20
            radius: width

            TapHandler
            {
                onPressedChanged:
                {
                    if(pressed)
                    {
                        leftToolBar.justLeftShow = false
                        leftToolBar.justRightShow = false
                    }

                    leftToolBar.isPressed = pressed || leftToolBarDrag.active
                }
            }

            HoverHandler
            {
                cursorShape: Qt.OpenHandCursor
            }

            DragHandler
            {
                id: leftToolBarDrag
                target: leftToolBar
                xAxis
                {
                    minimum: -leftToolBar.width
                    maximum: toolBar.width
                }
                yAxis.minimum: 0
                onActiveChanged:
                {
                    leftToolBar.isPressed = active
                    if(!active)
                    {
                        if(leftToolBar.rightAble)
                        {
                            rightHide.start()
                        }else if(leftToolBar.leftAble)
                        {
                            leftHide.start()
                        }
                    }
                }
                cursorShape: Qt.DragMoveCursor
            }
        }
        ListView
        {
            id: _listView
            x: 8
            y: 53
            width: 160
            height: Math.min(parent.height - 30, Window.height - parent.y - 30)
            anchors.top: moveAbleArea.bottom
            clip: true
            model: ListModel
            {
                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/choose.svg"
                    name: "选择"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/frame.svg"
                    name: "图框"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/move.svg"
                    name: "移动"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/Grip.svg"
                    name: "抓手"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/box.svg"
                    name: "框选"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/lasso.svg"
                    name: "套索工具"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/tailor.svg"
                    name: "裁剪"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/word.svg"
                    name: "文字"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/straw.svg"
                    name: "吸管"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/Matrix.svg"
                    name: "矩阵"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/Line.svg"
                    name: "线条"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/brush.svg"
                    name: "画笔"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/eraser.svg"
                    name: "橡皮擦"
                }

                ListElement
                {
                    btnIcon: "qrc:/modules/se/qt/toolBar/Icon/zoom.svg"
                    name: "缩放"
                }
            }
            delegate: listViewDelegate
        }

        Component
        {
            id: listViewDelegate
            Rectangle
            {
                property bool isHoverd: listViewHover.hovered
                property bool isThisBtn: listView.currentIndex === index  //当前按钮是否被选中
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
                    Behavior on width
                    {
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
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: parent.radius / 4
                    }
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

                TapHandler
                {
                    onTapped:
                    {
                        listView.currentIndex = index
                        ToolCtrl.selectedTool = name
                        if(ToolCtrl.selectedTool === "画笔"){
                            ToolCtrl.setShapeToFreeDraw()
                        }else if(ToolCtrl.selectedTool === "矩阵")
                        {
                            ToolCtrl.setShapeToRectangle()
                        }
                    }
                }

                HoverHandler
                {
                    id: listViewHover
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }

        //吸附进右边
        NumberAnimation
        {
            id: rightHide
            target: leftToolBar
            property: "x"
            to: toolBar.width
            duration: 200
            easing.type: Easing.InOutQuad
            onRunningChanged:
            {
                if(running === false)
                {
                    leftToolBar.justRightShow = false
                }
            }
        }
        //吸附进左边
        NumberAnimation
        {
            id: leftHide
            target: leftToolBar
            property: "x"
            to: -leftToolBar.width
            duration: 200
            easing.type: Easing.InOutQuad
            onRunningChanged:
            {
                if(running === false)
                {
                    leftToolBar.justLeftShow = false
                }
            }
        }

        onHeightChanged:
        {
            x = 0
            y = topToolBar.height + menuBar.height - 20
        }

        HoverHandler
        {
            onHoveredChanged:
            {
                if(!hovered)
                {
                    if(leftToolBar.justLeftShow)
                    {
                        leftHide.running = true
                    }else if(leftToolBar.justRightShow)
                    {
                        rightHide.running = true
                    }
                }
            }
        }
    }

    //隐藏发光
    Glow
    {
        id: hideGlow
        anchors.fill: leftToolBar
        radius: 10
        samples: 17
        color: "red"
        source: leftToolBar
        spread: 0
        visible: leftToolBar.rightAble | leftToolBar.leftAble
    }

    //按下发光
    Glow
    {
        id: pressGlow
        anchors.fill: leftToolBar
        radius: 10
        samples: 17
        color: "skyblue"
        source: leftToolBar
        spread: 0.2
        visible: leftToolBar.isPressed && !hideGlow.visible
    }

    NumberAnimation    //将leftToolBar从右边拉出来
    {
        id: rightShow
        target: leftToolBar
        property: "x"
        to: toolBar.width - leftToolBar.width
        duration: 200
        easing.type: Easing.InOutQuad
        onRunningChanged:
        {
            if(running === false)
            {
                leftToolBar.justRightShow = true
            }
        }
    }

    NumberAnimation    //将leftToolBar从左边拉出来
    {
        id: leftShow
        target: leftToolBar
        property: "x"
        to: 0
        duration: 200
        easing.type: Easing.InOutQuad
        onRunningChanged:
        {
            if(running === false)
            {
                leftToolBar.justLeftShow = true
            }
        }
    }

    Rectangle
    {
        height: leftToolBar.height
        width: 7
        color: "transparent"
        y: leftToolBar.y
        HoverHandler
        {
            enabled: leftToolBar.x === -leftToolBar.width
            onHoveredChanged:
            {
                if(hovered)
                {
                    leftShow.running = true
                }
            }
        }
    }

    Rectangle
    {
        height: leftToolBar.height
        width: 7
        color: "transparent"
        x: toolBar.width - width
        y: leftToolBar.y
        HoverHandler
        {
            enabled: leftToolBar.x >= toolBar.width
            onHoveredChanged:
            {
                if(hovered)
                {
                    rightShow.running = true
                }
            }
        }
    }
}

