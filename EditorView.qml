/** EditorView.qml
 * Wirtten by ZengYan on 2024-6-20
 * Funtion: show image
 * modified by Zengyan on 2024-6-20
 *   change cursorshape setting
 * modified by ZhanXuecai on 2024-6-21
 *   added Brush tool method
 *
 * modified by Zengyan on 2024-6-22
 * perfected zoom function
 *
 * Modified by RenTianxiang on 2024-6-23
 *      added propertys and functions to manage redo and undo
 *
 * Modified by RenTianxiang on 2024-6-24
 *      Finished moving the layer undo and redo
 * modified by Zengyan on 2024-6-24
 *  added  verticallyFlip,horizontallyFlip functions,choicecolorfunction
 *
 * Modified by RenTianxiang on 2024-6-25
 *      Zoom and Settings invisible undo and redo completed
 *
 * Modified by Zengyan on 2024-6-25
 * added rotation function
 *
 *
 * modified by ZhanXuecai on 2024-6-24
 *   perfected Rectangle tool method
 * modified by ZhanXuecai on 2024-6-25
 *   perfected Rectangle and Brush tool method
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Image
{
    id: imageView

    property Editor editor: editor1
    property int key   //标识符
    property var undoStack: []
    property var redoStack: []
    property int oldX
    property int oldY
    property double oldScale: 1
    property double newScale: 1
    property bool redoOrUndo: false
    //旋转效果
    property real currentAngle: 0
    property alias flip: _flip
    property alias imageViewDragAreaTap: _imageViewDragAreaTap
    property alias imageViewDragArea: _imageViewDragArea
    signal modified()
    signal requestAddBrushLayer()
    signal addUndoStack()
    //fillMode: Image.PreserveAspectFit
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
    }

    Rectangle
    {
        property double scale: scale
        id: _imageViewDragArea
        anchors.centerIn: parent

        color: "transparent"
        z: -1
        height: status === Image.Ready ? ((sourceSize.height / sourceSize.width >= parent.height / parent.width) ? parent.height :  sourceSize.height * parent.width / sourceSize.width) : parent.height
        width: status === Image.Ready ? ((sourceSize.height / sourceSize.width < parent.height / parent.width) ? parent.width : sourceSize.width * parent.height / sourceSize.height) : parent.width

        DragHandler
        {
            id:dragHandler
            target: imageView
            enabled: ToolCtrl.selectedTool === "移动"
            onActiveChanged:
            {
                if(!active)
                {
                    saveState(ActiveCtrl.MoveLayer, {oldX: imageView.oldX, oldY: imageView.oldY, newX: imageView.x, newY: imageView.y})
                }else
                {
                    oldX = x
                    oldY = y
                    modified()
                }
            }
        }

        HoverHandler
        {
            id:hoverhandler
            onHoveredChanged: {
                if(hovered)
                {
                    if(ToolCtrl.selectedTool === "移动")
                    {
                        cursorShape=Qt.SizeAllCursor
                    }else if(ToolCtrl.selectedTool === "吸管")
                    {
                        cursorShape=Qt.BlankCursor
                    }else if(ToolCtrl.selectedTool === "抓手")
                    {
                        cursorShape=Qt.OpenHandCursor
                    }else if(ToolCtrl.selectedTool === "套索工具"||
                             ToolCtrl.selectedTool === "框选"||
                             ToolCtrl.selectedTool === "裁剪"||
                             ToolCtrl.selectedTool === "文字")
                    {
                        cursorShape=Qt.CrossCursor
                    }
                }else
                {
                    cursorShape=Qt.ArrowCursor
                }
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

        Image {
            width: 15
            height: 15
            z:1
            id: strawcursor
            source: "qrc:/modules/se/qt/toolBar/Icon/straw.svg"
            visible:ToolCtrl.selectedTool === "吸管"&&hoverhandler.hovered
        }

        //吸管移动
        TapHandler
        {
            id: _imageViewDragAreaTap
        }

    }

    MouseArea{
        id:brushhandler
        anchors.fill: parent
        enabled: ToolCtrl.selectedTool === "画笔"
        onPressed: {
            requestAddBrushLayer()
            var x = mouseX / imageView.width * sourceSize.width
            var y = mouseY / imageView.height * sourceSize.height
            ToolCtrl.setShapeToFreeDraw()
            ToolCtrl.startDrawing(x,y)
        }
        onPositionChanged: {
            var x = mouseX / imageView.width * sourceSize.width
            var y = mouseY / imageView.height * sourceSize.height
            ToolCtrl.continueDrawing(x,y,false)
        }
        onReleased: {
            var x = mouseX / imageView.width * sourceSize.width
            var y = mouseY / imageView.height * sourceSize.height
            console.log("已完成一次画笔操作")
            ToolCtrl.stopDrawing(x,y)
        }
    }

    MouseArea{
        id:recthandler
        anchors.fill: parent
        enabled: ToolCtrl.selectedTool === "矩阵"
        onPressed: {
            requestAddBrushLayer()
            var x = mouseX / imageView.width * sourceSize.width
            var y = mouseY / imageView.height * sourceSize.height
            ToolCtrl.setShapeToRectangle()
            ToolCtrl.startDrawing(x,y)
        }
        onPositionChanged: {
            var x = mouseX / imageView.width * sourceSize.width
            var y = mouseY / imageView.height * sourceSize.height
            ToolCtrl.continueDrawing(x,y,false)
        }
        onReleased: {
            var x = mouseX / imageView.width * sourceSize.width
            var y = mouseY / imageView.height * sourceSize.height
            console.log("已完成一次画笔操作")
            ToolCtrl.stopDrawing(x,y)
        }
    }

    PinchHandler {
        id: handler
        enabled: ToolCtrl.selectedTool==="缩放"
        onScaleChanged:
        {
            ToolCtrl.returnScale(scale)
            var x=Math.ceil(imageViewDragArea.width*scale)
            var y=Math.ceil(imageViewDragArea.height*scale)
            var str=x.toString()+"*"+y.toString()
            ToolCtrl.getSize(str)
        }
    }
    //翻转效果
    transform: [Scale
        {
            id:_flip
            origin.x:imageView.width/2
            origin.y:imageView.height/2
            yScale: 1
            xScale: 1// 初始状态为正常
            Component.onCompleted:
            {
                ActiveCtrl.flip=flip
                ActiveCtrl.yScaleState(yScale);
                ActiveCtrl.xScaleState(xScale);

            }
            onScaleChanged:
            {
                ActiveCtrl.yScaleState(yScale);
                ActiveCtrl.xScaleState(xScale);
            }
        }, Rotation {
            id:_rotation
            origin.x: imageView.width / 2
            origin.y: imageView.height / 2
            angle:imageView.currentAngle

        }]
    Component.onCompleted: {
        ActiveCtrl.currentImageView=imageView
        ActiveCtrl.getAngle(currentAngle)

    }

    onScaleChanged:
    {
        oldScale = newScale
        newScale = scale
        ToolCtrl.returnScale(scale)
        var x=Math.ceil(imageViewDragArea.width*scale)
        var y=Math.ceil(imageViewDragArea.height*scale)
        var str=x.toString()+"*"+y.toString()
        ToolCtrl.getSize(str)

        if(!redoOrUndo)
        {
            saveState(ActiveCtrl.ScaleLayer, {oldScale: oldScale, newScale: newScale})
            modified()
        }
    }

    onVisibleChanged:
    {
        if(!redoOrUndo)
        {
            saveState(ActiveCtrl.VisibleLayer, {visible: !visible})
        }
    }

    //保存修改前的状态
    function saveState(action, params)
    {
        undoStack.push({action: action, params: params})
        redoStack = []
        addUndoStack()
    }

    function getUndoActionAndParams()   //获取撤销栈的数据
    {
        if(undoStack.length < 0)
        {
            return null
        }

        var map = undoStack.pop()
        redoStack.push(map)
        return map
    }

    function getRedoActionAndParams()   //获取重做栈的数据
    {
        if(redoStack.length < 0)
        {
            return null
        }
        var map = redoStack.pop()
        undoStack.push(map)
        return map
    }

    function move(x, y) //移动图层
    {
        imageView.x = x
        imageView.y = y
    }
}
