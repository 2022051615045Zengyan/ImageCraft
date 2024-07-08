/** Layer.qml
 * Moved by RenTianxiang on 2024-6-23
 * Management layer
 *
 * Modified by RenTianxiang on 2024-6-23
 *      added propertys and functions to manage redo and undo
 *
 * Modified by RenTianxiang on 2024-6-24
 *      Finished moving the layer undo and redo
 *
 *  modified by Zengyan on 2024-6-24
 *  added  verticallyFlip,horizontallyFlip functions
 *
 * Modified by Zengyan on 2024-6-25
 * added rotation function and Menu_View's zoomfunction
 * modified by ZhanXuecai on 2024-6-25
 *  added onRequestAddBrushLayer,getBrushLayerKeys()
 *
 * Modified by RenTianxiang on 2024-6-25
 *      Zoom and Settings invisible undo and redo completed, Fixed a bug where you could only select the lowest layer
 *
 * Modified by RenTianxiang on 2024-6-26
 *      The switch between the current image in the Layer is consistent with the switch between the tabs in the RCenter, making it easy to see the currently selected Layer
 *
 * Modified by RenTianxiang on 2024-6-26
 *      Complete the undo and redo of the flip and rotation
 *      Fixed a zoom bug
 *
 * Modified by RenTianxiang on 2024-7-6
 *      Complete the undo and redo of modified image and remove layer
 *
 * modified by RenTianxiang on 2024-7-7
 *      added select fuction
 *      Be able to enlarge the display box freely
 */

import QtQuick
import ImageCraft 1.0

Item
{
    id: tabContent

    property bool isModified: false
    property bool oldModified: false
    property bool newModified: false
    property ListModel layerModel: layer.layerListModel
    property Repeater layers: layer.layers
    property Rectangle thelayer: layer
    property string filePath: layers.count ? layers.itemAt(0).editor.path : ""
    property size imageSize: layers.count ? layers.itemAt(0).sourceSize : size(0, 0)
    property EditorView currentView: null
    property int currentIndex: -1
    property int keys: 1
    property var undoStack: []
    property var redoStack: []
    property var undoDeletedStack: []
    property var redoDeletedStack: []
    property var tempStack: []
    property bool firstTaped: true

    signal modifiedChanged()    //给isModified赋值就触发这个信号(方便更新oldModified和newModified)
    signal indexChanged(var index)
    property var canvasList:[]

    Rectangle
    {
        id: display_rect
        height: layer.height
        width: layer.height
        clip: true
        color: "white"
        anchors.centerIn: parent
        property double heightRatio: height / ActiveCtrl.lcenterHeight
        property double widthRatio: width / ActiveCtrl.lcenterWidth

        Rectangle
        {
            id: layer
            height: !layers.count ? 100 : ((layers.itemAt(0).sourceSize.height) / (layers.itemAt(0).sourceSize.width) >= (tabContent.height / tabContent.width)) ? layers.itemAt(0).height : (layers.itemAt(0).sourceSize.height * layers.itemAt(0).width / layers.itemAt(0).sourceSize.width)
            width: !layers.count ? 100 : ((layers.itemAt(0).sourceSize.height) / (layers.itemAt(0).sourceSize.width) <= (tabContent.height / tabContent.width)) ? layers.itemAt(0).width : (layers.itemAt(0).sourceSize.width * layers.itemAt(0).height / layers.itemAt(0).sourceSize.height)
            anchors.centerIn: parent
            color: !layers.count ?  "white" : (layers.itemAt(0).editor.path) ? "transparent" : "black"
            property ListModel layerListModel: ListModel {}
            property Repeater layers: layers_
            Repeater
            {
                id: layers_
                model: layer.layerListModel
                EditorView
                {
                    id: editorView
                    x: parent.width === width ? 0 : - (width - parent.width) / 2
                    y: parent.height === height ? 0 : - (height - parent.height) / 2

                    property var thepixUrl: pixUrl

                    fillMode: thepixUrl === "/Image/tm533.6x253.6.png" ? Image.Stretch : Image.PreserveAspectFit

                    width: tabContent.width / 5 * 4
                    height: tabContent.height / 5 * 4

                    onAddUndoStack:
                    {
                        Qt.callLater(function()
                        {
                            thelayer.saveKeyAndModified(editorView.key, tabContent.oldModified, tabContent.newModified)
                        });
                    }

                    Component.onCompleted:
                    {
                        if(index === 0)
                        {
                            Qt.callLater(function()
                            {
                                tabContent.isModified = false
                                Qt.callLater(function()
                                {
                                    tabContent.oldModified = false
                                    tabContent.newModified = false
                                });
                            });
                        }
                        key = tabContent.keys
                        tabContent.keys++
                        saveState(ActiveCtrl.AddLayer, {})
                        ToolCtrl.currentEditorView = editorView
                        tabContent.currentIndex = index
                        editor.openImage(thepixUrl)
                        console.log(thepixUrl)
                    }
                    imageViewDragAreaTap.onTapped:
                    {
                        if(tabContent.firstTaped)//第一个触发的响应
                        {
                            tabContent.firstTaped = false
                            tabContent.currentIndex = index

                            if(ToolCtrl.selectedTool === "吸管")
                            {                // 获取鼠标点击位置的坐标
                                var x = parseInt(editorView.imageViewDragAreaTap.point.position.x)
                                var y = parseInt(editorView.imageViewDragAreaTap.point.position.y)
                                //转换为图片实际对应的x,y
                                x *= editorView.sourceSize.width / editorView.imageViewDragArea.width
                                y *= editorView.sourceSize.height / editorView.imageViewDragArea.height
                                //获取图片的像素颜色
                                ToolCtrl.getPixelColor(editorView.editor.path, x, y);
                                // console.log(editorView.editor.path)
                            }

                            //延迟修改firstTaped为true，不影响下一次使用
                            Qt.callLater(function()
                            {
                                tabContent.firstTaped = true
                            });
                        }
                    }

                    imageViewDragAreaRTap.onTapped:
                    {
                        if(tabContent.firstTaped)
                        {
                            tabContent.firstTaped = false
                            tabContent.currentIndex = index
                            ActiveCtrl.popRightMenu(imageViewDragAreaRTap.point.position.x, imageViewDragAreaRTap.point.position.y)

                            //延迟修改firstTaped为true，不影响下一次使用
                            Qt.callLater(function()
                            {
                                tabContent.firstTaped = true
                            });
                        }
                    }

                    onModified:
                    {
                        tabContent.isModified = true
                        modifiedChanged()
                    }

                    Connections
                    {
                        target: editorView
                        function onRequestAddBrushLayer()
                        {
                            var index=getBrushLayerKeys()
                            if(index)
                            {
                                console.log(index)
                                ToolCtrl.canvasImage=layers.itemAt(index).editor.image
                                ToolCtrl.canvasEditor=layers.itemAt(index).editor
                                ToolCtrl.previewImage=layers.itemAt(index).editor.image
                            }
                        }
                    }
                }
            }
            onHeightChanged:
            {
                display_rect.height = height
            }
            onWidthChanged:
            {
                display_rect.width = width
            }

            //获取最近修改的类型和状态
            function getUndoActionAndParams(index)
            {
                if(index < layers.count && index > -1)
                {
                    return layers.itemAt(index).getUndoActionAndParams()
                }
                return null
            }

            function getRedoActionAndParams(index)
            {
                if(index < layers.count && index > -1)
                {
                    return layers.itemAt(index).getRedoActionAndParams()
                }
                return null
            }

            function findIndexBykey(key)
            {
                for(var i = 0; i < layers.count; i++)
                {
                    if(layers.itemAt(i).key === key)
                    {
                        return i
                    }
                }
                var map
                if(tabContent.undoDeletedStack.length > 0)
                {
                    map = tabContent.undoDeletedStack.pop()
                    tabContent.undoDeletedStack.push(map)
                    if(map["key"] === key)
                    {
                        tabContent.tempStack = tabContent.redoStack
                        return -2   //表示刚刚的操作是销毁组件
                    }
                }
                if(tabContent.redoDeletedStack.length > 0)
                {
                    map = tabContent.redoDeletedStack.pop()
                    tabContent.redoDeletedStack.push(map)
                    if(map["key"] === key)
                    {
                        tabContent.tempStack = tabContent.redoStack
                        return -2   //表示刚刚的操作是销毁组件
                    }
                }
                return -1
            }

            //保存被修改的图层的key和全局的修改状态
            function saveKeyAndModified(key, oldModified, newModified)
            {
                tabContent.redoStack = []
                tabContent.undoStack.push({key: key, oldModified: oldModified, newModified: newModified})
            }

            function undoStackPop()
            {
                if(undoStack.length === 1)
                {
                    return -1;
                }

                var map = tabContent.undoStack.pop()
                tabContent.isModified = map["oldModified"]
                tabContent.newModified = map["newModified"]
                modifiedChanged()
                tabContent.redoStack.push(map)
                return findIndexBykey(map["key"])
            }

            function redoStackPop()
            {
                if(redoStack.length === 0)
                {
                    return -1
                }

                var map = tabContent.redoStack.pop()
                tabContent.isModified = map["newModified"]
                tabContent.newModified = map["oldModified"]
                modifiedChanged()
                tabContent.undoStack.push(map)
                return findIndexBykey(map["key"])
            }

            function removeLayer(index, isundo) //移除图层
            {
                if(index < layers.count)
                {
                    var map = { pixUrl: layers.itemAt(index).thepixUrl,
                        index: index,
                        key: layers.itemAt(index).key,
                        redoStack: layers.itemAt(index).redoStack,
                        undoStack: layers.itemAt(index).undoStack,
                        oldX: layers.itemAt(index).oldX,
                        oldY: layers.itemAt(index).oldY,
                        oldScale: layers.itemAt(index).oldScale,
                        newScale: layers.itemAt(index).newScale,
                        currentAngle: layers.itemAt(index).currentAngle,
                        oldAngle: layers.itemAt(index).oldAngle,
                        newAngle: layers.itemAt(index).newAngle,
                        oldImage: layers.itemAt(index).oldImage,
                        newImage: layers.itemAt(index).newImage,
                        yScale: layers.itemAt(index).yScale,
                        xScale: layers.itemAt(index).xScale,
                        visible: layers.itemAt(index).visible}
                    if(isundo)
                    {
                        console.log("111:")
                        console.log(map["index"])
                        tabContent.undoDeletedStack.push(map)
                    }else
                    {
                        console.log("111:")
                        console.log(map["index"])
                        tabContent.redoDeletedStack.push(map)
                    }


                    layerModel.remove(index, 1)
                }
            }

            function deletedStackPop(isundo)  //重新创建组件
            {
                var map
                if(isundo)
                {
                    map = undoDeletedStack.pop()
                }else
                {
                    map = redoDeletedStack.pop()
                }

                console.log("222:")
                console.log(map["index"])
                tabContent.layerModel.insert(map["index"] ,{pixUrl: map["pixUrl"]})
                Qt.callLater(function() //等待图层创建完成  后恢复组件原有的属性和状态
                {
                    if(layers.itemAt(map["index"]))
                    {
                        var item = layers.itemAt(map["index"])
                        item.key = map["key"]
                        item.redoStack = map["redoStack"]
                        item.undoStack = map["undoStack"]
                        item.oldX = map["oldX"]
                        item.oldY = map["oldY"]
                        item.oldScale = map["oldScale"]
                        item.newScale = map["newScale"]
                        item.currentAngle = map["currentAngle"]
                        item.oldAngle = map["oldAngle"]
                        item.newAngle = map["newAngle"]
                        item.oldImage = map["oldImage"]
                        item.newImage = map["newImage"]
                        item.yScale = map["yScale"]
                        item.xScale = map["xScale"]
                        item.visible = map["visible"]

                        if(item.editor.image !== map["newImage"])
                        {
                            item.redoOrUndo = true
                            item.editor.image = map["newImage"]

                            Qt.callLater(function()
                            {
                                item.redoOrUndo = false
                            });
                        }

                        if(isundo)
                        {
                            var map1 = {action: ActiveCtrl.ReMoveLayer, params: {}}
                            item.redoStack.push(map1)
                        }else
                        {
                            var map2 = {action: ActiveCtrl.AddLayer, params: {}}
                            item.undoStack.push(map2)
                            item.redoStack.pop()
                        }
                        //恢复因在创建组件完成时修改的值（不是首次创建 需要恢复原来的状态）
                        tabContent.keys--
                        tabContent.redoStack = tabContent.tempStack
                        tabContent.undoStack.pop()
                    }
                });
            }

            function moveLayer(index, x, y)   //移动图层
            {
                layers.itemAt(index).move(x, y)
            }

            function setModified(flag)
            {
                tabContent.isModified = flag
                modifiedChanged()
            }

            function scaleLayer(index, scale)   //缩放图层
            {
                layers.itemAt(index).redoOrUndo = true
                layers.itemAt(index).scale = scale

                Qt.callLater(function()
                {
                    layers.itemAt(index).redoOrUndo = false
                });
            }

            function setVisibleLayer(index, visible)   //设置图层的可见性
            {
                layers.itemAt(index).visible = visible
            }

            function flipYLayer(index, yScale)   //垂直（y）翻转图层
            {
                layers.itemAt(index).redoOrUndo = true
                layers.itemAt(index).flip.yScale = yScale


                Qt.callLater(function()
                {
                    layers.itemAt(index).redoOrUndo = false
                });
            }

            function flipXLayer(index, xScale)   //水平（x）翻转图层
            {
                layers.itemAt(index).redoOrUndo = true
                layers.itemAt(index).flip.xScale = xScale


                Qt.callLater(function()
                {
                    layers.itemAt(index).redoOrUndo = false
                });
            }

            function spinLayer(index, angle)     //旋转图层
            {
                layers.itemAt(index).redoOrUndo = true
                layers.itemAt(index).currentAngle = angle


                Qt.callLater(function()
                {
                    layers.itemAt(index).redoOrUndo = false
                });
            }

            function modifiedLayer(index, image)    //修改图层（图片资源）
            {
                layers.itemAt(index).redoOrUndo = true
                layers.itemAt(index).editor.image = image

                Qt.callLater(function()
                {
                    layers.itemAt(index).redoOrUndo = false
                });
            }
        }

        onXChanged:
        {
            topBorder.x = display_rect.x
            bottomBorder.x = display_rect.x
            leftBorder.x = display_rect.x - 5
            rightBorder.x = display_rect.x + display_rect.width
            topLeftBorder.x = display_rect.x - 5
            topRightBorder.x = display_rect.x + display_rect.width
            bottomLeftBorder.x = display_rect.x - 5
            bottomRightBorder.x = display_rect.x + display_rect.width
        }

        onYChanged:
        {
            topBorder.y = display_rect.y - 5
            bottomBorder.y = display_rect.y + display_rect.height
            leftBorder.y = display_rect.y
            rightBorder.y = display_rect.y
            topLeftBorder.y = display_rect.y - 5
            topRightBorder.y = display_rect.y - 5
            bottomLeftBorder.y = display_rect.y + display_rect.height
            bottomRightBorder.y = display_rect.y + display_rect.height
        }

        onWidthChanged:
        {
            layer.width = width
            topBorder.x = display_rect.x
            bottomBorder.x = display_rect.x
            leftBorder.x = display_rect.x - 5
            rightBorder.x = display_rect.x + display_rect.width
            topLeftBorder.x = display_rect.x - 5
            topRightBorder.x = display_rect.x + display_rect.width
            bottomLeftBorder.x = display_rect.x - 5
            bottomRightBorder.x = display_rect.x + display_rect.width
            topBorder.y = display_rect.y - 5
            bottomBorder.y = display_rect.y + display_rect.height
            leftBorder.y = display_rect.y
            rightBorder.y = display_rect.y
            topLeftBorder.y = display_rect.y - 5
            topRightBorder.y = display_rect.y - 5
            bottomLeftBorder.y = display_rect.y + display_rect.height
            bottomRightBorder.y = display_rect.y + display_rect.height
            widthRatio =  width / ActiveCtrl.lcenterWidth
        }

        onHeightChanged:
        {
            layer.height = height
            topBorder.x = display_rect.x
            bottomBorder.x = display_rect.x
            leftBorder.x = display_rect.x - 5
            rightBorder.x = display_rect.x + display_rect.width
            topLeftBorder.x = display_rect.x - 5
            topRightBorder.x = display_rect.x + display_rect.width
            bottomLeftBorder.x = display_rect.x - 5
            bottomRightBorder.x = display_rect.x + display_rect.width
            topBorder.y = display_rect.y - 5
            bottomBorder.y = display_rect.y + display_rect.height
            leftBorder.y = display_rect.y
            rightBorder.y = display_rect.y
            topLeftBorder.y = display_rect.y - 5
            topRightBorder.y = display_rect.y - 5
            bottomLeftBorder.y = display_rect.y + display_rect.height
            bottomRightBorder.y = display_rect.y + display_rect.height
            heightRatio = height / ActiveCtrl.lcenterHeight
        }

        Connections
        {
            target: ActiveCtrl

            function onLcenterHeightChanged()
            {
                display_rect.height = ActiveCtrl.lcenterHeight * display_rect.heightRatio
            }
        }
        Connections
        {
            target: ActiveCtrl

            function onLcenterWidthChanged()
            {
                display_rect.width = ActiveCtrl.lcenterWidth * display_rect.widthRatio
            }
        }
    }

    Rectangle
    {
        id: topBorder
        width: display_rect.width
        height: 5
        x: display_rect.x
        y: display_rect.y - 5
        color: "#3daee9"
        property int mouseOffsetY: 0

        HoverHandler
        {
            cursorShape: Qt.SizeVerCursor
        }
        DragHandler
        {
            xAxis.enabled: false
            yAxis.minimum: 0
            yAxis.maximum: display_rect.y + display_rect.height / 2
        }
        onYChanged:
        {
            display_rect.height = display_rect.height + (display_rect.y - 5 - y) * 2
        }
    }
    Rectangle
    {
        id: bottomBorder
        width: display_rect.width
        height: 5
        x: display_rect.x
        y: display_rect.y + display_rect.height
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeVerCursor
        }
        DragHandler
        {
            xAxis.enabled: false
            yAxis.minimum: display_rect.y + display_rect.height / 2
            yAxis.maximum: ActiveCtrl.lcenterHeight - 4
        }
        onYChanged:
        {
            display_rect.height = display_rect.height + (y - (display_rect.y + display_rect.height)) * 2
        }
    }
    Rectangle
    {
        id: leftBorder
        width: 5
        height: display_rect.height
        x: display_rect.x - 5
        y: display_rect.y
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeHorCursor
        }
        DragHandler
        {
            yAxis.enabled: false
            xAxis.minimum: 0
            xAxis.maximum: display_rect.x + display_rect.width / 2
        }
        onXChanged:
        {
            display_rect.width = display_rect.width + (display_rect.x - 5 - x) * 2
        }
    }
    Rectangle
    {
        id: rightBorder
        width: 5
        height: display_rect.height
        x: display_rect.x + display_rect.width
        y: display_rect.y
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeHorCursor
        }
        DragHandler
        {
            yAxis.enabled: false
            xAxis.minimum: display_rect.x + display_rect.width / 2
            xAxis.maximum: ActiveCtrl.lcenterWidth - 5
        }
        onXChanged:
        {
            display_rect.width = display_rect.width + (x - display_rect.x - display_rect.width) * 2
        }
    }
    Rectangle
    {
        id: topLeftBorder
        width: 5
        height: 5
        x: display_rect.x - 5
        y: display_rect.y - 5
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeFDiagCursor
        }
        DragHandler
        {
            xAxis.minimum: 0
            xAxis.maximum: display_rect.x + display_rect.width / 2
            yAxis.minimum: 0
            yAxis.maximum: display_rect.y + display_rect.height / 2
        }
        onXChanged:
        {
            display_rect.width = display_rect.width + (display_rect.x - 5 - x) * 2
        }
        onYChanged:
        {
            display_rect.height = display_rect.height + (display_rect.y - 5 - y) * 2
        }
    }
    Rectangle
    {
        id: topRightBorder
        width: 5
        height: 5
        x: display_rect.x + display_rect.width
        y: display_rect.y - 5
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeBDiagCursor
        }
        DragHandler
        {
            yAxis.minimum: 0
            yAxis.maximum: display_rect.y + display_rect.height / 2
            xAxis.minimum: display_rect.x + display_rect.width / 2
            xAxis.maximum: ActiveCtrl.lcenterWidth - 5
        }
        onXChanged:
        {
            display_rect.width = display_rect.width + (x - display_rect.x - display_rect.width) * 2
        }
        onYChanged:
        {
            display_rect.height = display_rect.height + (display_rect.y - 5 - y) * 2
        }
    }
    Rectangle
    {
        id: bottomLeftBorder
        width: 5
        height: 5
        x: display_rect.x - 5
        y: display_rect.y + display_rect.height
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeBDiagCursor
        }
        DragHandler
        {
            xAxis.minimum: 0
            xAxis.maximum: display_rect.x + display_rect.width / 2
            yAxis.minimum: display_rect.y + display_rect.height / 2
            yAxis.maximum: ActiveCtrl.lcenterHeight - 4
        }
        onYChanged:
        {
            display_rect.height = display_rect.height + (y - (display_rect.y + display_rect.height)) * 2
        }
        onXChanged:
        {
            display_rect.width = display_rect.width + (display_rect.x - 5 - x) * 2
        }
    }
    Rectangle
    {
        id: bottomRightBorder
        width: 5
        height: 5
        x: display_rect.x + display_rect.width
        y: display_rect.y + display_rect.height
        color: "#3daee9"
        HoverHandler
        {
            cursorShape: Qt.SizeFDiagCursor
        }
        DragHandler
        {
            xAxis.minimum: display_rect.x + display_rect.width / 2
            xAxis.maximum: ActiveCtrl.lcenterWidth - 5
            yAxis.minimum: display_rect.y + display_rect.height / 2
            yAxis.maximum: ActiveCtrl.lcenterHeight - 4
        }
        onYChanged:
        {
            display_rect.height = display_rect.height + (y - (display_rect.y + display_rect.height)) * 2
        }
        onXChanged:
        {
            display_rect.width = display_rect.width + (x - display_rect.x - display_rect.width) * 2
        }
    }

    Component.onCompleted:
    {
        layerModel.append({pixUrl: pixUrl_yuan})
    }

    //拖放文件区域
    DropArea
    {
        anchors.fill: parent
        onDropped: function(dragEvent)
        {
            handleDrop(dragEvent)
        }

        function handleDrop(dragEvent)
        {
            if (dragEvent.hasText)
            {
                var url = dragEvent.text;
                layerModel.append({pixUrl: url})
                tabContent.isModified = true
                modifiedChanged()
            }
        }
    }

    function getBrushLayerKeys(){
        if(canvasList.length!==0 && findCanvasIndexBykey(canvasList[canvasList.length-1])===layers.count-1){
            return findCanvasIndexBykey(canvasList[canvasList.length-1])
        }else{
            layerModel.append({pixUrl:"/Image/tm533.6x253.6.png"});
            tabContent.isModified = true
            modifiedChanged()
            canvasList.push(keys-1)
            return layers.count-1
        }
    }

    function findCanvasIndexBykey(key)
    {
        for(var i = 0; i < layers.count; i++)
        {
            if(layers.itemAt(i).key === key)
            {
                return i
            }
        }
    }

    onModifiedChanged:
    {
        oldModified = newModified
        newModified = isModified
    }

    onIsModifiedChanged:
    {
        ActiveCtrl.modified = isModified
    }

    onCurrentViewChanged:
    {
        if(currentView)
        {
            ActiveCtrl.flip = currentView.flip
            ActiveCtrl.currentImageView = currentView
            ToolCtrl.currentEditorView = currentView
            ActiveCtrl.currentEditor = currentView.editor as Editor
        }
    }

    onCurrentIndexChanged:
    {
        if(currentIndex != -1)
        {
            currentView = layers.itemAt(currentIndex)
            indexChanged(currentIndex)
        }
    }
}
