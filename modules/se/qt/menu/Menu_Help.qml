/** Menu_Help.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Help Menu
 */
import QtQuick
import QtQuick.Controls
Menu{
    width: 300
    id:setting
    title: qsTr("Help(&H)")
    MyMenuItem{
        text:qsTr("User Manual(&H)")
        icon.name:"step_object_Note"
        sequence: "F1"

        onTriggered: {
            console.log("捐款已被点击")
        }
    }
    MyMenuItem{
        text:qsTr("What`s This?")
        icon.name:"help-whatsthis"
        sequence: "Shift+F1"
        onTriggered: {
            console.log("这是什么已被点击")
        }
    }
}
