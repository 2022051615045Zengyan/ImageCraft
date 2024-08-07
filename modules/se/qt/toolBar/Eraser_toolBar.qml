/** Eraser_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Eraser toolBar 擦除内容
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Item {
    id: eraser
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        Label{
            text:qsTr("Eraser Type:")
        }

        Button {
            id: _eraser
            icon.name: "draw-eraser"
            text:"Eraser"
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToEraser()
            }
        }

        Button{
            id:_eraser_colored
            icon.name: "tool_color_eraser"
            text: qsTr("Color Eraser:")
            Layout.preferredWidth:parent.height
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToColoredEraser()
            }
        }

        Label{
            text:qsTr("Eraser Size:")
        }

        ComboBox {
            id: eraser_size
            Layout.preferredWidth:parent.height*3
            model: [qsTr("Small"),qsTr("Middle"),qsTr("big")]
            Component.onCompleted: {
                eraser_size.currentIndex = 0;
            }

            onCurrentIndexChanged: {
                ToolCtrl.setEraserSize(currentIndex)
            }

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {height: parent.height}

        Label{
            text:qsTr("Friction Force:")+eraser_opacities.value+"%"
        }

        Slider{
            id:eraser_opacities
            from:0
            to:100
            value:100
            stepSize: 1
            onValueChanged: {
                let alphaValue = 255* (eraser_opacities.value/100);
                ToolCtrl.setEraserOpacity(alphaValue)
            }
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }
    }

}

