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
 * Modified by Zengyan on 2024-6-25
 * added rotation function and Menu_View's zoomfunction
 */

import QtQuick
import ImageCraft 1.0

Item
{
    id: tabContent

    property bool isModified: false
    property bool oldModified: false
    property bool isBrushLayer:layer.isBrushLayer_
    property ListModel layerModel: layer.layerListModel
    property Repeater layers: layer.layers
    property Rectangle thelayer: layer
    property string filePath: layers.count ? layers.itemAt(0).editor.path : ""
    property size imageSize: layers.count ? layers.itemAt(0).sourceSize : size(0, 0)
    property EditorView currentView: null
    property bool firstTap: true
    property int keys: 1
    property var undoStack: []
    property var redoStack: []
    property var deletedStack: []
    property var tempStack: []

    Rectangle
    {
        id: display_rect
        height: layer.height
        width: layer.height
        clip: true
        color: "white"
        anchors.centerIn: parent

        Rectangle
        {
            id: layer
            height: !layers.count ? 100 : ((layers.itemAt(0).sourceSize.height) / (layers.itemAt(0).sourceSize.width) >= (tabContent.height / tabContent.width)) ? layers.itemAt(0).height : (layers.itemAt(0).sourceSize.height * layers.itemAt(0).width / layers.itemAt(0).sourceSize.width)
            width: !layers.count ? 100 : ((layers.itemAt(0).sourceSize.height) / (layers.itemAt(0).sourceSize.width) <= (tabContent.height / tabContent.width)) ? layers.itemAt(0).width : (layers.itemAt(0).sourceSize.width * layers.itemAt(0).height / layers.itemAt(0).sourceSize.height)
            anchors.centerIn: parent
            color: !layers.count ?  "white" : (layers.itemAt(0).editor.path) ? "transparent" : "black"
            property ListModel layerListModel: ListModel {}
            property Repeater layers: layers_
            property bool isBrushLayer_:false
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

                    width: tabContent.width / 5 * 4
                    height: tabContent.height / 5 * 4

                    onAddUndoStack:
                    {
                        thelayer.saveKeyAndModified(editorView.key, tabContent.oldModified, tabContent.isModified)
                    }

                    Component.onCompleted:
                    {
                        if(index === 0)
                        {
                            Qt.callLater(function()
                            {
                                tabContent.isModified = false
                                tabContent.oldModified = false
                            });
                        }

                        key = tabContent.keys++
                        saveState(ActiveCtrl.AddLayer, {})
                        ToolCtrl.currentEditorView = editorView
                        tabContent.currentView=editorView
                        editor.openImage(thepixUrl)
                    }

                    imageViewDragAreaTap.onTapped:
                    {
                        if(firstTap)
                        {
                            firstTap = false
                            ActiveCtrl.currentEditor = layers.itemAt(index).editor as Editor
                            ToolCtrl.currentEditorView = editorView
                            ActiveCtrl.currentImageView=editorView
                            ActiveCtrl.anglenum=editorView.currentAngle

                            tabContent.currentView = editorView
                            ActiveCtrl.flip=editorView.flip
                            ActiveCtrl.yScaleState(currentView.flip.yScale);
                            ActiveCtrl.xScaleState(currentView.flip.xScale);

                            if(ToolCtrl.selectedTool === "吸管")
                            {                // 获取鼠标点击位置的坐标
                                var x = parseInt(imageViewDragAreaTap.point.position.x)
                                var y = parseInt(imageViewDragAreaTap.point.position.y)
                                //转换为图片实际对应的x,y
                                x *= sourceSize.width / imageViewDragArea.width
                                y *= sourceSize.height / imageViewDragArea.height
                                //获取图片的像素颜色
                                ToolCtrl.getPixelColor(editor.path, x, y);
                                console.log(editor.path);
                            }

                            Qt.callLater(function()
                            {
                                firstTap = true
                            });
                        }
                    }

                    onModified:
                    {
                        oldModified = isModified
                        tabContent.isModified = true
                    }

                    Connections{
                        target: editorView
                        function onRequestAddBrushLayer(){
                            addBrushLayer()
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
                var map = tabContent.deletedStack.pop()
                if(map["key"] === key)
                {
                    tabContent.deletedStack.push(map)
                    tabContent.tempStack = tabContent.redoStack
                    return -2   //表示刚刚的撤销操作是销毁组件
                }
                tabContent.deletedStack.push(map)
                // console.log("here findKey: " + key)
                return -1
            }

            //保存被修改的图层的key
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
                Qt.callLater(function()
                {
                    tabContent.oldModified = map["newModified"]
                });
                tabContent.redoStack.push(map)
                // console.log("redo: " + tabContent.redoStack)
                return findIndexBykey(map["key"])
            }

            function redoStackPop()
            {
                if(redoStack.length === 0)
                {
                    return -1
                }

                var map = tabContent.redoStack.pop()
                // console.log("redo: " + tabContent.redoStack)
                tabContent.isModified = map["newModified"]
                Qt.callLater(function()
                {
                    tabContent.oldModified = map["oldModified"]
                });
                tabContent.undoStack.push(map)
                return findIndexBykey(map["key"])
            }

            function removeLayer(index) //移除图层
            {
                if(index < layers.count)
                {
                    tabContent.deletedStack.push({pixUrl: layers.itemAt(index).thepixUrl, index: index,key: layers.itemAt(index).key, redoStack: layers.itemAt(index).redoStack})
                    layerModel.remove(index, 1)
                }
            }

            function deletedStackPop()  //重新创建组件
            {
                var map = deletedStack.pop()
                tabContent.layerModel.insert(map["index"] ,{pixUrl: map["pixUrl"]})

                Qt.callLater(function() //等待图层创建完成  后恢复组件原有的属性和状态
                {
                    if(layers.itemAt(map["index"]))
                    {
                        layers.itemAt(map["index"]).key = map["key"]
                        layers.itemAt(map["index"]).redoStack = map["redoStack"]
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
                tabContent.oldModified = tabContent.isModified
                tabContent.isModified = flag
            }
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
                thelayer.isBrushLayer_ = false
            }
        }
    }

    function addBrushLayer(){
        if(thelayer.isBrushLayer_=== false){
            var pixUrl_brush ="File:///run/media/root/study/QTstudy/Ps/ImageCraft/Image/new5000x5000.png"
            layerModel.append({pixUrl:pixUrl_brush});
            tabContent.isModified = true
            thelayer.isBrushLayer_ = true
        }
    }

    onIsModifiedChanged:
    {
        ActiveCtrl.modified = isModified
    }
}
