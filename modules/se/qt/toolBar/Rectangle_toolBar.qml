/** Rectangle_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Rectangle toolBar 绘制图形
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
Item {
    id: rectangle
    anchors.fill: parent
    Editor{
        id:editor
    }

    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        Label {
            text: "填充: "
        }

        Rectangle {
            id: _rectangle_Padding
            Layout.preferredWidth:parent.height*2
            Layout.preferredHeight: parent.height/1.5
            color: "black"
            border.color: "grey"
            border.width: 2

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Label {
            text: "描边: "
        }

        Rectangle {
            id: _rectangle_NoStroke
            Layout.preferredWidth:parent.height*2
            Layout.preferredHeight: parent.height/1.5
            border.color: "grey"
            border.width: 2
            color: "black"
            Rectangle {
                height: parent.height - 6
                width: parent.width - 6
                anchors.centerIn: parent

                Rectangle {
                    height: parent.height - 2
                    width: parent.width - 2
                    anchors.centerIn: parent
                    clip: true

                    Rectangle {
                        color: "red"
                        height: parent.height / 4
                        width: parent.width
                        anchors.centerIn: parent
                        rotation: -25
                        antialiasing: true
                    }

                    Rectangle {
                        height: parent.height / 5 * 2
                        width: parent.width / 3 * 2
                        anchors.centerIn: parent
                        color: "black"
                        border.color: "white"
                    }
                }
            }
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Rectangle {
            id: _rectangle_Stroke
            Layout.preferredWidth:parent.height*2
            Layout.preferredHeight: parent.height/1.5
            border.width: 2

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Label{
            text: "形状:"
        }

        Button{
            id:_rectangle_Rect
            text:qsTr("矩阵")
            onClicked: {
                editor.setCurrentShape(Editor.Rectangle)
                console.log(Editor.currentShape)
            }
        }

        Button{
            id:_boxselect_Elliptical
            text:qsTr("椭圆")
            onClicked: {
                editor.setCurrentShape(Editor.Ellipse)
                console.log(Editor.currentShape)
            }
        }

        RadioButton{
            id:_boxselect_Circle
            text:qsTr("圆形")
            checked: false
        }

        RadioButton{
            id:_boxselect_Polygon
            text:qsTr("多边形")
            checked: false
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredWidth: 1000
        }
    }
}
//     }
// }
