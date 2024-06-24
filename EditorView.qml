/** EditorView.qml
 * Wirtten by ZengYan on 2024-6-20
 * Funtion: show image
 *modified by Zengyan
 *   added getcolor
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

    Rectangle{
        id:r
        visible: false
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
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

        // function onTempImageChanged(){
        //     modified()
        //     imageProvider.setImage(editor.tempImageView)
        //     imageView.source = "image://editorimage/" + Math.floor(Math.random() * 1000000000000)/*editor.tempImage*/
        // }
    }

    Image {
        id: tempImageView
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        source: ""
    }

    Rectangle
    {
        id: imageViewDragArea
        anchors.centerIn: parent
        property url eyedropperCursor: "qrc:/modules/se/qt/toolBar/Icon/straw.svg"
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
                        cursorShape:Qt.SizeAllCursor
                    }else if(ToolCtrl.selectedTool === "吸管"){
                        cursorShape:Qt.BlankCursor
                    }
                }
            }
            onPointChanged: {
                cursor.x=point.position.x
                cursor.y=point.position.y
            }
        }

        MouseArea{
            id:brushhandler
            anchors.fill: parent
            enabled: ToolCtrl.selectedTool === "画笔"
            onPressed: {
                //requestAddBrushLayer()
                var x = mouseX
                var y = mouseY
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                editor.setShapeToFreeDraw()
                console.log(x,y)
                editor.startDrawing(x,y)
            }
            onPositionChanged: {
                var x = mouseX
                var y = mouseY
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                editor.continueDrawing(x,y,false)
            }
            onReleased: {
                var x = mouseX
                var y = mouseY
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                console.log("已完成一次画笔操作")
                editor.stopDrawing(x,y)
            }
        }

        MouseArea{
            id:rectanglehandler
            anchors.fill: parent
            enabled: ToolCtrl.selectedTool === "矩阵"
            onPressed: {
                //requestAddBrushLayer()
                var x = mouseX
                var y = mouseY
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                editor.setShapeToRectangle()
                console.log(x,y)
                editor.startDrawing(x,y)
            }
            onPositionChanged: {
                var x = mouseX
                var y = mouseY
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                editor.continueDrawing(x,y,true) //临时绘制
            }
            onReleased: {
                var x = mouseX
                var y = mouseY
                x *= sourceSize.width / imageViewDragArea.width
                y *= sourceSize.height / imageViewDragArea.height
                console.log("已完成一次矩阵操作")
                editor.stopDrawing(x,y)
            }
        }

        Image {
            width: 10
            height: 10
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
}
