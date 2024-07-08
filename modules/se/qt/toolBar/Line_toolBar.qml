/** Line_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Line toolBar 绘制线条
 *
 * Written by ZhanXuecai on 2024-7-6
 * added line selected function
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
Item {
    id: line_toolBar
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5

        Button {
            id: _line_beeline
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/zhixian.png"
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToLineDraw()
            }

        }

        ComboBox{
            id: _line_beeline_size
            Layout.preferredWidth:parent.height*3
            model: ["细","较细","均衡","较粗","粗"]
            Component.onCompleted: {
                _line_beeline_size.currentIndex = 2;
            }
            onCurrentIndexChanged: {
                ToolCtrl.setLineSize(currentIndex)
            }

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }


        Button {
            id: _line_polyline
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/zhexian.png"
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToPolylineDraw()
            }

        }

        ComboBox{
            id: _line_polyline_size
            Layout.preferredWidth:parent.height*3
            model: ["细","较细","均衡","较粗","粗"]
            Component.onCompleted: {
                _line_polyline_size.currentIndex = 2;
            }
            onCurrentIndexChanged: {
                ToolCtrl.setPolyLineSize(currentIndex)
            }

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent.height
        }

        Button {
            id: _line_curve
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/quxian.png"
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onClicked: {
                ToolCtrl.setShapeToCurveDraw()
            }
        }

        ComboBox{
            id: _line_curve_size
            Layout.preferredWidth:parent.height*3
            model: ["极细","细","较细","均衡","较粗","粗","极粗"]
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            Component.onCompleted: {
                _line_beeline_size.currentIndex = 2;
            }
            onCurrentIndexChanged: {
                ToolCtrl.setCurrentBrushSize(currentIndex)
            }
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }

    }


}
