/** Menu_Help.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Help Menu
 */
import QtQuick
import QtQuick.Controls
Menu{
    width: 300
    id:setting
    title: qsTr("帮助(&H)")
    MyMenuItem{
        text:qsTr("使用手册(&H)")
        icon.name:"step_object_Note"
        sequence: "F1"

        onTriggered: {
            console.log("捐款已被点击")
        }
    }
    MyMenuItem{
        text:qsTr("这是什么？")
        icon.name:"help-whatsthis"
        sequence: "Shift+F1"
        onTriggered: {
            console.log("这是什么已被点击")
        }
    }

    MenuSeparator{}
    MyMenuItem{
        text:qsTr("捐款(&D)")
        icon.name:"donate"

        onTriggered: {
            console.log("捐款已被点击")
        }
    }



}
