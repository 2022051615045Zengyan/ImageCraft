/** Menu_View.qml
 * Written by ZhanXuecai on 2024-6-18
 * Funtion: View Menu
 * Modified by Zengyan on 2024-6-25
 * added zoom function
 *
 * Modified by RenTianxiang on 2024-6-26
 *      Fixed a zoom bug
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Menu {
    width:300
    title: qsTr("View(&V)")

    //缩小
    MyMenuItem{
        text: qsTr("Zoom Out(&O)")
        icon.name: "file-zoom-out"
        sequence:"Ctrl+-"
        onTriggered:
        {
            if(_zoomColumnLayout.currentIndex > 0)
            {
                _zoomRepeater.itemAt( _zoomColumnLayout.currentIndex-1).clicked()
            }
        }
    }

    Menu{
        title:qsTr("Zoom(&Z)")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"

        ColumnLayout
        {
            id: _zoomColumnLayout
            property int currentIndex: 9
            Repeater
            {
                id: _zoomRepeater
                delegate: zoomdelegate

                Component
                {
                    id: zoomdelegate
                    RadioButton
                    {
                        text:modelData + "%"
                        width: 200
                        checked: index === _zoomColumnLayout.currentIndex
                        onClicked:
                        {
                            currentIndex = index
                            ToolCtrl.getRepeaterIndex(index)
                        }
                    }
                }
            }

            onCurrentIndexChanged:
            {
                _zoomRepeater.itemAt(currentIndex).clicked()
            }
        }
        Component.onCompleted:
        {
            ToolCtrl.zoomRepeater = _zoomRepeater
            ToolCtrl.zoomColumnLayout=_zoomColumnLayout
        }
    }

    //放大
    MyMenuItem{
        text: qsTr("Zoom In(&I)")
        icon.name: "file-zoom-in"
        sequence:"Ctrl++"
        onTriggered:
        {
            console.log(_zoomRepeater.count)
            if(_zoomColumnLayout.currentIndex < _zoomRepeater.count-1)
            {
                _zoomRepeater.itemAt( _zoomColumnLayout.currentIndex + 1).clicked()
            }else
                return
        }
    }
}
