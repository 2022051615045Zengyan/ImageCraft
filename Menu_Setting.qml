/** Menu_Setting.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Setting Menu
 */
import QtQuick
import QtQuick.Controls
Menu{
    width: 300
    id:setting
    title: qsTr("设置(&S)")

    Menu{
        icon.source: "icon/noneIcon.png"
        title: qsTr("显示工具栏")
        CheckBox {
            id: checkBox01
            text:qsTr("主工具栏")
        }
        CheckBox {
            id: checkBox02
            text:qsTr("文本工具栏")
        }
        CheckBox {
            id: checkBox03
            text:qsTr("文本工具栏")
        }
    }

    MyMenuItem{

        text:qsTr("显示状态栏")
        icon.source: "icon/checkBox-false.svg"
             property bool ischecked: false
             // enabled: false
             onTriggered:
             {

                 ischecked = !ischecked
                 icon.source = ischecked ? "icon/checkBox-true.svg" : "icon/checkBox-false.svg"
             }

    }
    MyMenuItem{
        text:qsTr("显示路径")
        icon.source: "icon/checkBox-false.svg"
             property bool ischecked: false
             // enabled: false
             onTriggered:
             {

                 ischecked = !ischecked
                 icon.source = ischecked ? "icon/checkBox-true.svg" : "icon/checkBox-false.svg"
             }
    }
    MyMenuItem {
        text:qsTr("绘制时使用锯齿平滑")
        icon.source: "icon/checkBox-false.svg"
             property bool ischecked: false
             // enabled: false
             onTriggered:
             {

                 ischecked = !ischecked
                 icon.source = ischecked ? "icon/checkBox-true.svg" : "icon/checkBox-false.svg"
             }
    }
    MenuSeparator{}

    MyMenuItem{
        text:qsTr("配置语言(&L)...")
        sequence: "Ctrl+Alt+,"
        onTriggered: {
            console.log("配置语言已被点击")
        }
    }

    MyMenuItem{
        text:qsTr("配置键盘快捷键(&H)...")
        icon.name:"help-keybord-shortcuts-symbolic"

        onTriggered: {
            console.log("配置键盘快捷键")
        }
    }

    MyMenuItem{
        text:qsTr("配置工具栏(&B)...")
        icon.name:"configure-toolbars"
        onTriggered: {
            console.log("配置工具栏已被点击")
        }
    }
}
