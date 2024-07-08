/** Menu_Setting.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Setting Menu
 * modified by Zengyan on 2024-7-8
 * finished maintoolBar,lefttoolBar...status changes
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0
Menu{
    width: 300
    id:setting
    title: qsTr("设置(&S)")


 MyMenuItem{

            text:qsTr("侧边工具栏")
            icon.source: "qrc:/modules/se/qt/menu/icon/checkBox-true.svg"
            property bool ischecked: true
            onTriggered:
            {
                ActiveCtrl.lefttoolbarDisplay()
                ischecked = !ischecked
                icon.source = ischecked ? "qrc:/modules/se/qt/menu/icon/checkBox-true.svg" : "qrc:/modules/se/qt/menu/icon/checkBox-false.svg"
            }
        }


    MyMenuItem{

        text:qsTr("显示状态栏")
        icon.source: "qrc:/modules/se/qt/menu/icon/checkBox-true.svg"
        property bool ischecked: true
        // enabled: false
        onTriggered:
        {
            ActiveCtrl.footerVisible()
            ischecked = !ischecked
            icon.source = ischecked ? "qrc:/modules/se/qt/menu/icon/checkBox-true.svg" : "qrc:/modules/se/qt/menu/icon/checkBox-false.svg"
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
