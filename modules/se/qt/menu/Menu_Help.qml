/** Menu_Help.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Help Menu
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0
Menu{
    width: 300
    id:setting
    title: qsTr("Help(&H)")
    MyMenuItem{
        text:qsTr("User Manual(&H)")
        icon.name:"step_object_Note"
        sequence: "F1"

        onTriggered: {
            ActiveCtrl.openManualDialog()
            console.log("使用手册")
        }
    }
    MyMenuItem{
        text:qsTr("What`s This?")
        icon.name:"help-whatsthis"
        sequence: "Shift+F1"
        onTriggered: {
            ActiveCtrl.openInstructionDialog()
            console.log("这是什么已被点击")
        }
    }
}
