/** EditorView.qml
 * Wirtten by ZengYan on 2024-6-20
 * Funtion: show image
 * modified by Zengyan on 2024-6-20
 *   change cursorshape setting
 * modified by Zengyan on 2024-6-22
 * perfected zoom function
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Image
{
    id: imageView

    property Editor editor: editor1
    signal modified()
    signal requestAddBrushLayer()
    fillMode: Image.PreserveAspectFit

    Editor
    {
        id: editor1
    }

    Connections
    {
        target: editor
        function onImageChanged()
        {
            modified()
            imageProvider.setImage(editor.image)
            imageView.source = "image://editorimage/" + Math.floor(Math.random() * 1000000000000)
        }
    }

    Rectangle
    {
        property double scale: scale
        id: imageViewDragArea
        anchors.centerIn: parent

        color: "transparent"
        z: 1
        height: status === Image.Ready ? ((sourceSize.height / sourceSize.width >= parent.height / parent.width) ? parent.height :  sourceSize.height * parent.width / sourceSize.width) : parent.height
        width: status === Image.Ready ? ((sourceSize.height / sourceSize.width < parent.height / parent.width) ? parent.width : sourceSize.width * parent.height / sourceSize.height) : parent.width
        DragHandler
        {
            id:dragHandler
            target: imageView
            enabled: ToolCtrl.selectedTool === "移动"
            onActiveChanged:
            {
                modified()
            }
        }

        HoverHandler
        {
            id:hoverhandler
            onHoveredChanged: {
                if(hovered){

                    if(ToolCtrl.selectedTool === "移动"){
                        cursorShape=Qt.SizeAllCursor
                    }else if(ToolCtrl.selectedTool === "吸管"){
                        cursorShape=Qt.BlankCursor
                    }else if(ToolCtrl.selectedTool === "抓手"){
                        cursorShape=Qt.OpenHandCursor
                    }else if(ToolCtrl.selectedTool === "套索工具"||
                             ToolCtrl.selectedTool === "框选"||
                             ToolCtrl.selectedTool === "裁剪"||
                             ToolCtrl.selectedTool === "文字"){
                        cursorShape=Qt.CrossCursor
                    }
                }else
                    cursorShape=Qt.ArrowCursor
            }
            onPointChanged: {
                var x=point.position.x
                var y=point.position.y
                //转换为图片实际对应的x,y
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                strawcursor.x=point.position.x
                strawcursor.y=point.position.y
                ToolCtrl.getPointPositon(x,y)
            }
        }

        MouseArea{
            id:brushhandler
            anchors.fill: parent
            enabled: ToolCtrl.selectedTool === "画笔"
            onPressed: {
                  //requestAddBrushLayer()
                  editor.setCurrentShape(Editor.FreeDraw)
                  console.log(Editor.currentShape)
                  editor.startDrawing(mouseX,mouseY)
            }
            onPositionChanged: {
                editor.continueDrawing(mouseX,mouseY)
            }
            onReleased: {
                console.log("已完成一次画笔操作")
                editor.stopDrawing()
            }
        }

        MouseArea{
            id:recthandler
            anchors.fill: parent
            enabled: ToolCtrl.selectedTool === "矩阵"
            onPressed: {
                  //requestAddBrushLayer()
                  editor.setCurrentShape(Editor.Rectangle)
                 console.log(Editor.currentShape)
                  editor.startDrawing(mouseX,mouseY)
            }
            onPositionChanged: {
                editor.continueDrawing(mouseX,mouseY)
            }
            onReleased: {
                console.log("已完成一次矩阵操作")
                editor.stopDrawing()
            }
        }

        Image {
            width: 15
            height: 15
            z:1
            id: strawcursor
            source: "qrc:/modules/se/qt/toolBar/Icon/straw.svg"
            visible:ToolCtrl.selectedTool === "吸管"&&hoverhandler.hovered
        }
        Image {
            width: 15
            height: 15
            z:1
            id: cursor
            source: "qrc:/modules/se/qt/toolBar/Icon/straw.svg"
            visible:ToolCtrl.selectedTool === "吸管"&&hoverhandler.hovered
        }
        //吸管移动
        TapHandler
        {
            onTapped:
            {
                if(ToolCtrl.selectedTool === "吸管")
                {                // 获取鼠标点击位置的坐标
                    var x = parseInt(point.position.x)
                    var y = parseInt(point.position.y)

                    //转换为图片实际对应的x,y
                    x *= sourceSize.width / imageViewDragArea.width
                    y *= sourceSize.height / imageViewDragArea.height
                    //获取图片的像素颜色
                    ToolCtrl.getPixelColor(editor1.path, x, y);
                    console.log(editor1.path);
                }
            }
        }

    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            startX = mouseX
            startY = mouseY
        }
        onPositionChanged: {
            endX = mouseX
            endY = mouseY
        }
        onReleased: {
            console.log("Start Point: ", startX, ",", startY)
            console.log("End Point: ", endX, ",", endY)
        }
    }
    // PinchArea

    PinchHandler {
        id: handler

        enabled: ToolCtrl.selectedTool==="缩放"
        //onRotationChanged: (delta) => parent.rotation += delta // add
        onScaleChanged: {
                            ToolCtrl.returnScale(scale)

                        }

    }


}
