/** SelectBox.qml
 * Written by RenTianxiang on 2024-7-7
 * Function: A selection box to display when a picture is selected
 */


import QtQuick

Item
{
    id: selectBox

    required property Rectangle dragRect
    property int originalWidth
    property int originalHeight

    Image
    {
        id: top_left
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x - 7
        y: dragRect.y - 7

        HoverHandler
        {
            cursorShape: Qt.SizeFDiagCursor
        }
        DragHandler
        {
        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: top_middle
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width / 2 - 7
        y: dragRect.y - 7
        HoverHandler
        {
            cursorShape: Qt.SizeVerCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: top_right
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width - 7
        y: dragRect.y - 7
        HoverHandler
        {
            cursorShape: Qt.SizeBDiagCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: middle_left
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x - 7
        y: dragRect.y + dragRect.height / 2 - 7
        HoverHandler
        {
            cursorShape: Qt.SizeHorCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: middle_right
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width - 7
        y: dragRect.y + dragRect.height / 2 - 7
        HoverHandler
        {
            cursorShape: Qt.SizeHorCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: bottom_left
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x - 7
        y: dragRect.y + dragRect.height - 7
        HoverHandler
        {
            cursorShape: Qt.SizeBDiagCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: bottom_middle
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width / 2 - 7
        y: dragRect.y + dragRect.height - 7
        HoverHandler
        {
            cursorShape: Qt.SizeVerCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Image
    {
        id: bottom_right
        width: 15
        height: 15
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width - 7
        y: dragRect.y + dragRect.height - 7
        HoverHandler
        {
            cursorShape: Qt.SizeFDiagCursor
        }
        DragHandler
        {

        }
        onXChanged:
        {

        }
        onYChanged:
        {

        }
    }

    Row
    {
        id: topLine
        width: (top_right.x - top_left.x) > 0 ? (top_right.x - top_left.x) : (top_left.x - top_right.x)
        anchors.left: top_left.left
        anchors.top: top_left.top
        anchors.leftMargin: 6
        anchors.topMargin: 6
        height: 2
        spacing: 0

        Repeater
        {
            model: topLine.width / 5 // 设置条纹的数量，可以根据需要调整
            Rectangle
            {
                width: 5
                height: parent.height
                color: index % 2 === 0 ? "black" : "white"
            }
        }
    }

    Row
    {
        id: bottomLine
        width: (bottom_right.x - bottom_left.x) > 0 ? (bottom_right.x - bottom_left.x) : (bottom_left.x - bottom_right.x)
        anchors.left: bottom_left.left
        anchors.top: bottom_left.top
        anchors.leftMargin: 6
        anchors.topMargin: 6
        height: 2
        spacing: 0

        Repeater
        {
            model: bottomLine.width / 5 // 设置条纹的数量，可以根据需要调整
            Rectangle
            {
                width: 5
                height: parent.height
                color: index % 2 === 0 ? "black" : "white"
            }
        }
    }

    Column
    {
        id: leftLine
        width: 2
        anchors.left: top_left.left
        anchors.top: top_left.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
        height: (bottom_left.y - top_left.y) > 0 ? (bottom_left.y - top_left.y) : (top_left.y - bottom_left.y)
        spacing: 0

        Repeater
        {
            model: leftLine.height / 5 // 设置条纹的数量，可以根据需要调整
            Rectangle
            {
                width: parent.width
                height: 5
                color: index % 2 === 0 ? "black" : "white"
            }
        }
    }

    Column
    {
        id: rightLine
        width: 2
        anchors.left: top_right.left
        anchors.top: top_right.top
        anchors.leftMargin: 7
        anchors.topMargin: 7
        height: (bottom_right.y - top_right.y) > 0 ? (bottom_right.y - top_right.y) : (top_right.y - bottom_right.y)
        spacing: 0

        Repeater
        {
            model: rightLine.height / 5 // 设置条纹的数量，可以根据需要调整
            Rectangle
            {
                width: parent.width
                height: 5
                color: index % 2 === 0 ? "black" : "white"
            }
        }
    }
}
