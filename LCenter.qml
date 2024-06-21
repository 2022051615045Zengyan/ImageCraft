/** LCenter.qml
 * Written by Zengyan on 2024-6-19
 * Funtion: left center window
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Item
{
    id: lcenter
    required property ListModel pageModel
    required property int currentIndex
    property alias stackL: _stackL

    StackLayout
    {
        id: _stackL
        height: parent.height
        width: parent.width
        currentIndex: lcenter.currentIndex
        clip: true

        Repeater {
            model: pageModel

            Item
            {
                id: tabContent
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                property bool isModified: layer.isModified_
                property bool isBrushLayer:layer.isBrushLayer_
                property ListModel layerModel: layer.layerListModel
                property Repeater layers: layer.layers
                property Rectangle thelayer: layer
                property string filePath: layers.count ? layers.itemAt(0).editor.path : ""
                property size imageSize: layers.count ? layers.itemAt(0).sourceSize : size(0, 0)

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
                        property bool isModified_: false
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

                                width: tabContent.width / 5 * 4
                                height: tabContent.height / 5 * 4

                                Component.onCompleted:
                                {
                                    if(index === 0)
                                    {
                                        Qt.callLater(function()
                                        {
                                            parent.isModified_ = false
                                        });
                                    }
                                    ToolCtrl.currentEditorView = editorView
                                    editor.openImage(pixUrl)
                                }
                                TapHandler
                                {
                                    onTapped:
                                    {
                                        ActiveCtrl.currentEditor = layers.itemAt(index) as Editor
                                        ToolCtrl.currentEditorView = editorView
                                    }
                                }
                                PinchHandler {
                                    id: handler
                                    target: editorView
                                    onRotationChanged: (delta) => parent.rotation += delta // add
                                    onScaleChanged: (delta) => {
                                                    editorView.currentscale= editorView.currentscale*delta
                                                    console.log("pinch:"+delta)
                                                          // timer.start()
                                                    }

                                }
                                // Timer{
                                //     id: timer
                                //     interval: 0 // 触发间隔为0，即下一帧
                                //     onTriggered: {
                                //     var lastwidth=tabContent.width / 5 * 4
                                //     var scaledWidth = editorView.width // 获取缩放后的宽度
                                //         // 在这里可以处理缩放后的宽度
                                //     var number= scaledWidth/lastwidth
                                //     var intValue = Math.floor(number*100);
                                //         console.log("pinch2:"+number)
                                //     //ToolCtrl.returnScale(intValue)
                                //     }
                                //}
                                onModified:
                                {
                                    parent.isModified_ = true
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
                            parent.layerModel.append({pixUrl: url});
                            thelayer.isModified_ = true
                            thelayer.isBrushLayer_=false
                        }
                    }
                }
                function addBrushLayer(){
                    if(thelayer.isBrushLayer_===false){
                        var pixUrl_brush ="File:///run/media/root/study/QTstudy/Ps/ImageCraft/Image/new5000x5000.png"
                        layerModel.append({pixUrl:pixUrl_brush});
                        thelayer.isModified_=true
                        thelayer.isBrushLayer_=true
                    }
                }
                onIsModifiedChanged:
                {
                    ActiveCtrl.modified = isModified
                }
            }
        }

        onCurrentIndexChanged:
        {
            var layer_ = (itemAt(currentIndex) ? itemAt(currentIndex).thelayer : null)
            ActiveCtrl.currentLayer = layer_
            ActiveCtrl.modified = (itemAt(currentIndex) ? itemAt(currentIndex).isModified : false)
            Qt.callLater(function()
            {
                ActiveCtrl.size = (itemAt(currentIndex) ? itemAt(currentIndex).imageSize : null)
                var filePath = (itemAt(currentIndex) ? itemAt(currentIndex).filePath : "")
                ActiveCtrl.savePath = filePath

                ToolCtrl.currentEditorView=layer_?layer_.layers.itemAt(0):null
            });
        }
        onCountChanged:
        {
            var layer_ = (itemAt(currentIndex) ? itemAt(currentIndex).thelayer : null)
            ActiveCtrl.currentLayer = layer_
            ActiveCtrl.modified = (itemAt(currentIndex) ? itemAt(currentIndex).isModified : false)
            Qt.callLater(function()
            {
                ActiveCtrl.size = (itemAt(currentIndex) ? itemAt(currentIndex).imageSize : null)
                var filePath = (itemAt(currentIndex) ? itemAt(currentIndex).filePath : "")
                ActiveCtrl.savePath = filePath
            });
        }
    }
}
