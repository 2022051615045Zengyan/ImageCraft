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


}
