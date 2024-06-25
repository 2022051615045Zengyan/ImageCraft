/** LCenter.qml
 * Written by Zengyan on 2024-6-19
 * Funtion: left center window
 * Modified by Zengyan on 2024-6-25
 * added rotation function
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

        Repeater
        {
            model: pageModel

            Layer
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
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
                ActiveCtrl.flip = (itemAt(currentIndex) ? itemAt(currentIndex).currentView.flip : null)
                ActiveCtrl.yScaleState(itemAt(currentIndex).currentView.flip.yScale);
                ActiveCtrl.xScaleState(itemAt(currentIndex).currentView.flip.xScale);
                ActiveCtrl.currentImageView=(itemAt(currentIndex) ? itemAt(currentIndex).currentView : null)
                ActiveCtrl.anglenum=(itemAt(currentIndex) ? itemAt(currentIndex).currentView.currentAngle : null)
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
