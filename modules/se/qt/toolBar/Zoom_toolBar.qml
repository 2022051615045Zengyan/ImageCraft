/** Zoom_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Zoom toolBar 对画布整体进行缩放
 *   modified by Zengyan on 2014-6-21
 *      added zoomfunction
 * modified by Zengyan on 2024-6-22
 * perfected zoom function
 *
 * Modified by RenTianxiang on 2024-6-26
 *      Fixed a zoom bug
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
Item {
    id: zoom
    anchors.fill: parent
    property alias zoom_size: _zoom_size

    RowLayout {
        width: parent.width
        height: parent.height
        spacing:5

        Button {
            id: _zoom_out
            Layout.preferredWidth: parent.height*3
            text: "缩小"
            icon.name: "file-zoom-out"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            enabled: _zoom_size.currentIndex!==0

            onClicked: {
                // 随机选择一个不同的选项
                if(_zoom_size.currentIndex===0)
                {
                    return
                }
                else{
                    _zoom_size.currentIndex--

                }
            }
        }


        ComboBox {
            id: _zoom_size
            Layout.preferredWidth: parent.height*3
            editable: true

            onAccepted: {
                var num = parseInt(editText) / 100
                ToolCtrl.returnScale(num)
            }

            onCurrentIndexChanged: {
                Qt.callLater(function()
                {
                    // 当用户改变选项时触发
                    var scaleMultiple = _zoom_size.model[currentIndex]
                    // 调用 ToolCtrl.setScaleFactor() 并传递选中项的值
                    ToolCtrl.setScaleFactor(scaleMultiple,currentIndex);
                });
            }
            delegate:ItemDelegate {
                text: modelData + "%"
            }

            Layout.fillWidth: true
            Layout.minimumWidth: 0
        }

        Button {
            id: _zoom_in
            Layout.preferredWidth: parent.height*3
            text: "放大"
            icon.name: "file-zoom-in"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            enabled: _zoom_size.currentIndex!==_zoom_size.model.count

            onClicked: {

                if(_zoom_size.currentIndex===_zoom_size.model.count-1)
                {
                    return
                }
                else{
                    _zoom_size.currentIndex++
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredWidth: 1000
        }
    }
    Component.onCompleted: {
        ToolCtrl.zoom_size=zoom_size
        ToolCtrl.zoomSetChanged()
    }
}

