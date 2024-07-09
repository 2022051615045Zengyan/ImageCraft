/** SelectBox.qml
 * Written by RenTianxiang on 2024-7-7
 * Function: A selection box to display when a picture is selected
 *
 * Modified by RenTianxiang on 2024-7-8
 *      Added free scaling for selection
 */


import QtQuick
import ImageCraft 1.0

Item
{
    id: selectBox

    required property Rectangle dragRect

    Image
    {
        id: top_left
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x - width / 2
        y: dragRect.y - height / 2

        HoverHandler
        {
            cursorShape: Qt.SizeFDiagCursor
        }
        DragHandler
        {
            id: top_leftDrag
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onXChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(top_leftDrag.active)
                {
                    var originalWidth = dragRect.width / ToolCtrl.currentEditorView.xScale_scale
                    var xScale = (bottom_right.x - x) / originalWidth
                    ToolCtrl.currentEditorView.xScale_scale = xScale
                    middle_left.x = dragRect.x - middle_left.width / 2
                    top_middle.x = dragRect.x + dragRect.width / 2 - top_middle.width / 2
                    bottom_left.x = dragRect.x - bottom_left.width / 2
                    bottom_middle.x = dragRect.x + dragRect.width / 2 - bottom_middle.width / 2
                    top_right.x = dragRect.x + dragRect.width - top_right.width / 2
                    middle_right.x = dragRect.x + dragRect.width - middle_right.width / 2
                    bottom_right.x = dragRect.x + dragRect.width - bottom_right.width / 2
                }
            }
        }
        onYChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(top_leftDrag.active)
                {
                    var originalHeight = dragRect.height / ToolCtrl.currentEditorView.yScale_scale
                    var yScale = (bottom_right.y - y) / originalHeight
                    ToolCtrl.currentEditorView.yScale_scale = yScale
                    middle_left.y = dragRect.y + dragRect.height / 2 - middle_left.height / 2
                    top_middle.y = dragRect.y - top_middle.height / 2
                    top_right.y = dragRect.y - top_right.height / 2
                    middle_right.y = dragRect.y + dragRect.height / 2 - middle_right.height / 2
                    bottom_left.y = dragRect.y + dragRect.height - bottom_left.height / 2
                    bottom_middle.y = dragRect.y + dragRect.height - bottom_middle.height / 2
                    bottom_right.y = dragRect.y + dragRect.height - bottom_right.height / 2
                }
            }
        }
    }

    Image
    {
        id: top_middle
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width / 2 - width / 2
        y: dragRect.y - height / 2
        HoverHandler
        {
            cursorShape: Qt.SizeVerCursor
        }
        DragHandler
        {
            id: top_middleDrag
            xAxis.enabled: false
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onYChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(top_middleDrag.active)
                {
                    var originalHeight = dragRect.height / ToolCtrl.currentEditorView.yScale_scale
                    var yScale = (bottom_middle.y - y) / originalHeight
                    ToolCtrl.currentEditorView.yScale_scale = yScale
                    middle_left.y = dragRect.y + dragRect.height / 2 - middle_left.height / 2
                    top_left.y = dragRect.y - top_left.height / 2
                    top_right.y = dragRect.y - top_right.height / 2
                    middle_right.y = dragRect.y + dragRect.height / 2 - middle_right.height / 2
                    bottom_left.y = dragRect.y + dragRect.height - bottom_left.height / 2
                    bottom_middle.y = dragRect.y + dragRect.height - bottom_middle.height / 2
                    bottom_right.y = dragRect.y + dragRect.height - bottom_right.height / 2
                }
            }
        }
    }

    Image
    {
        id: top_right
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width - width / 2
        y: dragRect.y - height / 2
        HoverHandler
        {
            cursorShape: Qt.SizeBDiagCursor
        }
        DragHandler
        {
            id: top_rightDrag
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onXChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(top_rightDrag.active)
                {
                    var originalWidth = dragRect.width / ToolCtrl.currentEditorView.xScale_scale
                    var xScale = (x - bottom_left.x) / originalWidth
                    ToolCtrl.currentEditorView.xScale_scale = xScale
                    middle_left.x = dragRect.x - middle_left.width / 2
                    top_middle.x = dragRect.x + dragRect.width / 2 - top_middle.width / 2
                    bottom_left.x = dragRect.x - bottom_left.width / 2
                    bottom_middle.x = dragRect.x + dragRect.width / 2 - bottom_middle.width / 2
                    top_left.x = dragRect.x - top_left.width / 2
                    middle_right.x = dragRect.x + dragRect.width - middle_right.width / 2
                    bottom_right.x = dragRect.x + dragRect.width - bottom_right.width / 2
                }
            }
        }
        onYChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(top_rightDrag.active)
                {
                    var originalHeight = dragRect.height / ToolCtrl.currentEditorView.yScale_scale
                    var yScale = (bottom_left.y - y) / originalHeight
                    ToolCtrl.currentEditorView.yScale_scale = yScale
                    middle_left.y = dragRect.y + dragRect.height / 2 - middle_left.height / 2
                    top_middle.y = dragRect.y - top_middle.height / 2
                    top_left.y = dragRect.y - top_left.height / 2
                    middle_right.y = dragRect.y + dragRect.height / 2 - middle_right.height / 2
                    bottom_left.y = dragRect.y + dragRect.height - bottom_left.height / 2
                    bottom_middle.y = dragRect.y + dragRect.height - bottom_middle.height / 2
                    bottom_right.y = dragRect.y + dragRect.height - bottom_right.height / 2
                }
            }
        }
    }

    Image
    {
        id: middle_left
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x - width / 2
        y: dragRect.y + dragRect.height / 2 - height / 2

        HoverHandler
        {
            cursorShape: Qt.SizeHorCursor
        }
        DragHandler
        {
            id: middle_leftDrag
            yAxis.enabled: false
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onXChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(middle_leftDrag.active)
                {
                    var originalWidth = dragRect.width / ToolCtrl.currentEditorView.xScale_scale
                    var xScale = (middle_right.x - x) / originalWidth
                    ToolCtrl.currentEditorView.xScale_scale = xScale
                    top_left.x = dragRect.x - top_left.width / 2
                    top_middle.x = dragRect.x + dragRect.width / 2 - top_middle.width / 2
                    bottom_left.x = dragRect.x - bottom_left.width / 2
                    bottom_middle.x = dragRect.x + dragRect.width / 2 - bottom_middle.width / 2
                    top_right.x = dragRect.x + dragRect.width - top_right.width / 2
                    middle_right.x = dragRect.x + dragRect.width - middle_right.width / 2
                    bottom_right.x = dragRect.x + dragRect.width - bottom_right.width / 2
                }
            }
        }
    }

    Image
    {
        id: middle_right
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width - width / 2
        y: dragRect.y + dragRect.height / 2 - height / 2

        HoverHandler
        {
            cursorShape: Qt.SizeHorCursor
        }
        DragHandler
        {
            id: middle_rightDrag
            yAxis.enabled: false
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onXChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(middle_rightDrag.active)
                {
                    var originalWidth = dragRect.width / ToolCtrl.currentEditorView.xScale_scale
                    var xScale = (x - bottom_left.x) / originalWidth
                    ToolCtrl.currentEditorView.xScale_scale = xScale
                    middle_left.x = dragRect.x - middle_left.width / 2
                    top_middle.x = dragRect.x + dragRect.width / 2 - top_middle.width / 2
                    bottom_left.x = dragRect.x - bottom_left.width / 2
                    bottom_middle.x = dragRect.x + dragRect.width / 2 - bottom_middle.width / 2
                    top_right.x = dragRect.x + dragRect.width - top_right.width / 2
                    top_left.x = dragRect.x - top_left.width / 2
                    bottom_right.x = dragRect.x + dragRect.width - bottom_right.width / 2
                }
            }
        }
    }

    Image
    {
        id: bottom_left
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x - width / 2
        y: dragRect.y + dragRect.height - height / 2

        HoverHandler
        {
            cursorShape: Qt.SizeBDiagCursor
        }
        DragHandler
        {
            id: bottom_leftDrag
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onXChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(bottom_leftDrag.active)
                {
                    var originalWidth = dragRect.width / ToolCtrl.currentEditorView.xScale_scale
                    var xScale = (top_right.x - x) / originalWidth
                    ToolCtrl.currentEditorView.xScale_scale = xScale
                    middle_left.x = dragRect.x - middle_left.width / 2
                    top_middle.x = dragRect.x + dragRect.width / 2 - top_middle.width / 2
                    top_left.x = dragRect.x - top_left.width / 2
                    bottom_middle.x = dragRect.x + dragRect.width / 2 - bottom_middle.width / 2
                    top_right.x = dragRect.x + dragRect.width - top_right.width / 2
                    middle_right.x = dragRect.x + dragRect.width - middle_right.width / 2
                    bottom_right.x = dragRect.x + dragRect.width - bottom_right.width / 2
                }
            }
        }
        onYChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(bottom_leftDrag.active)
                {
                    var originalHeight = dragRect.height / ToolCtrl.currentEditorView.yScale_scale
                    var yScale = (y - top_right.y) / originalHeight
                    ToolCtrl.currentEditorView.yScale_scale = yScale
                    middle_left.y = dragRect.y + dragRect.height / 2 - middle_left.height / 2
                    top_middle.y = dragRect.y - top_middle.height / 2
                    top_right.y = dragRect.y - top_right.height / 2
                    middle_right.y = dragRect.y + dragRect.height / 2 - middle_right.height / 2
                    top_left.y = dragRect.y - top_left.height / 2
                    bottom_middle.y = dragRect.y + dragRect.height - bottom_middle.height / 2
                    bottom_right.y = dragRect.y + dragRect.height - bottom_right.height / 2
                }
            }
        }
    }

    Image
    {
        id: bottom_middle
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width / 2 - width / 2
        y: dragRect.y + dragRect.height - height / 2

        HoverHandler
        {
            cursorShape: Qt.SizeVerCursor
        }
        DragHandler
        {
            id: bottom_middleDrag
            xAxis.enabled: false
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onYChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(bottom_middleDrag.active)
                {
                    var originalHeight = dragRect.height / ToolCtrl.currentEditorView.yScale_scale
                    var yScale = (y - top_middle.y) / originalHeight
                    ToolCtrl.currentEditorView.yScale_scale = yScale
                    middle_left.y = dragRect.y + dragRect.height / 2 - middle_left.height / 2
                    top_middle.y = dragRect.y - top_middle.height / 2
                    top_right.y = dragRect.y - top_right.height / 2
                    middle_right.y = dragRect.y + dragRect.height / 2 - middle_right.height / 2
                    bottom_left.y = dragRect.y + dragRect.height - bottom_left.height / 2
                    top_left.y = dragRect.y - top_left.height / 2
                    bottom_right.y = dragRect.y + dragRect.height - bottom_right.height / 2
                }
            }
        }
    }

    Image
    {
        id: bottom_right
        width: 16
        height: 16
        source: "qrc:/icon/board.svg"
        x: dragRect.x + dragRect.width - width / 2
        y: dragRect.y + dragRect.height - height / 2

        HoverHandler
        {
            cursorShape: Qt.SizeFDiagCursor
        }
        DragHandler
        {
            id: bottom_rightDrag
            onActiveChanged:
            {
                if(!active)
                {
                    ToolCtrl.currentEditorView.scaleXYChanged()
                }
            }
        }
        onXChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(bottom_rightDrag.active)
                {
                    var originalWidth = dragRect.width / ToolCtrl.currentEditorView.xScale_scale
                    var xScale = (x - top_left.x) / originalWidth
                    ToolCtrl.currentEditorView.xScale_scale = xScale
                    middle_left.x = dragRect.x - middle_left.width / 2
                    top_middle.x = dragRect.x + dragRect.width / 2 - top_middle.width / 2
                    bottom_left.x = dragRect.x - bottom_left.width / 2
                    bottom_middle.x = dragRect.x + dragRect.width / 2 - bottom_middle.width / 2
                    top_right.x = dragRect.x + dragRect.width - top_right.width / 2
                    middle_right.x = dragRect.x + dragRect.width - middle_right.width / 2
                    top_left.x = dragRect.x - top_left.width / 2
                }
            }
        }
        onYChanged:
        {
            if(ToolCtrl.currentEditorView)
            {
                if(bottom_rightDrag.active)
                {
                    var originalHeight = dragRect.height / ToolCtrl.currentEditorView.yScale_scale
                    var yScale = (y - top_left.y) / originalHeight
                    ToolCtrl.currentEditorView.yScale_scale = yScale
                    middle_left.y = dragRect.y + dragRect.height / 2 - middle_left.height / 2
                    top_middle.y = dragRect.y - top_middle.height / 2
                    top_right.y = dragRect.y - top_right.height / 2
                    middle_right.y = dragRect.y + dragRect.height / 2 - middle_right.height / 2
                    bottom_left.y = dragRect.y + dragRect.height - bottom_left.height / 2
                    bottom_middle.y = dragRect.y + dragRect.height - bottom_middle.height / 2
                    top_left.y = dragRect.y - top_left.height / 2
                }
            }
        }
    }

    Row
    {
        id: topLine
        width: (top_right.x - top_left.x) > 0 ? (top_right.x - top_left.x) : (top_left.x - top_right.x)
        anchors.left: top_left.left
        anchors.top: top_left.top

        anchors.leftMargin: top_left.width / 2 - 1
        anchors.topMargin: top_left.height / 2 - 1
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
        anchors.leftMargin: bottom_left.width / 2 - 1
        anchors.topMargin: bottom_left.height / 2 - 1
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
        anchors.leftMargin: top_left.width / 2 - 2
        anchors.topMargin: top_left.height / 2 - 2
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
        anchors.leftMargin: top_right.width / 2
        anchors.topMargin: top_right.height / 2
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
