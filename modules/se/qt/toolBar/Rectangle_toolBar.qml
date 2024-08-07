/** Rectangle_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Rectangle toolBar 绘制图形
 *
 * Modified by ZhanXuecai on 2024-6-25
 *   added setShapeToRectangle(),setShapeToEllipse()
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

        RadioButton{
            id:_rectanle_Fill
            text:qsTr("Fill")
            checked: true
            onCheckedChanged: {
                ToolCtrl.setFillRectangle(true)
            }
        }

        RadioButton{
            id:_rectanle_Stroke
            text:qsTr("Stroke")
            checked: false
            onCheckedChanged: {
                ToolCtrl.setFillRectangle(false)
            }
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }


        Label{
            text: qsTr("Shape:")
        }

        Button{
            id:_rectangle_Rect
            text:qsTr("Rectangle")
            icon.name: "draw-rectangle"
            onClicked: {
                ToolCtrl.setShapeToRectangle()
            }
        }

        Button{
            id:_boxselect_Elliptical
            text:qsTr("Ellipse")
            icon.name: "draw-ellipse"
            onClicked: {
                ToolCtrl.setShapeToEllipse()
            }
        }

        Button{
            id:_boxselect_Circle
            text:qsTr("Circle")
            icon.name: "draw-circle"
            onClicked: {
                ToolCtrl.setShapeToCircle()
            }
        }

        Button{
            id:_boxselect_Polygon
            text:qsTr("Polygon")
            icon.name: "draw-polygon"
            onClicked: {
                ToolCtrl.setShapeToPolygon()
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredWidth: 1000
        }
    }
}
