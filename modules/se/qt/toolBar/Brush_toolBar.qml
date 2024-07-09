/** Brush_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Brush toolBar 自由绘制
 *
 * Modified by ZhanXuecai on 2024-6-25
 *   added setShapeToFreeDraw()
 * Modified by ZhanXuecai on 2024-6-26
 *   added pen and spray functions
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
Item {
    id: brush
    anchors.fill: parent

    RowLayout{
        width: parent.width
        height: parent.height

        Button {
            id: _brush_Paintbrush
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/huabi.png"
            text:"画笔"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToFreeDraw()
            }
        }

        Label{
            text:"画笔大小:"
        }

        ComboBox{
            id: _brush_Paintbrush_Size
            Layout.preferredWidth:parent.height*3
            model: ["细","较细","均衡","较粗","粗"]
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            Component.onCompleted: {
                _brush_Paintbrush_Size.currentIndex = 2;
            }
            onCurrentIndexChanged: {
                ToolCtrl.setCurrentBrushSize(currentIndex)
            }
        }

        Label{
            text:"画笔类型:"
        }

        ComboBox{
            id: _brush_Paintbrush_Family
            Layout.preferredWidth:parent.height*3
            model: ["⚫","⬛","/","\\"]
            onCurrentIndexChanged: {
                ToolCtrl.setCapStyle(currentIndex)
                console.log("currentIndex:"+currentIndex)
            }
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _brush_Pen
            text: "钢笔"
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/gangbi.png"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToPenDraw()
            }
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _line_spray
            text: "喷漆"
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/penqi.png"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToSprayDraw()
            }
        }

        Label{
            text:"喷漆大小:"
        }

        ComboBox{
            id: _line_spray_size
            Layout.preferredWidth:parent.height*3
            model: ["微喷","轻喷","精喷","散喷","均喷","密喷"]

            Component.onCompleted: {
                _line_spray_size.currentIndex = 0;
            }

            onCurrentIndexChanged: {
                ToolCtrl.setSpraySize(currentIndex)
            }

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }

    }


}


