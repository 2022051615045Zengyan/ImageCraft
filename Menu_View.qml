/** Menu_View.qml
 * Written by ZhanXuecai on 2024-6-18
 * Funtion: View Menu
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Menu {
    width:300
    title: qsTr("视图(&V)")

    MyMenuItem{
        text: "缩放为实际大小(&W)"
        icon.name: ""
        sequence:"Shift+Ctrl+Y"
    }

    MyMenuItem{
        text: "适合整个页面(&F)"
        icon.name: "view_fit_to_page"
        sequence:"Shift+Ctrl+Y"
    }

    MyMenuItem{
        text: "适合页面宽度(&W)"
        icon.name: "view-zoom-fit-height-symbolic"
        sequence:"Shift+Ctrl+Y"
    }
    MyMenuItem{
        text: "适合页面高度(&H)"
        icon.name: "view-zoom-fit-width-symbolic"
        sequence:"Shift+Ctrl+Y"
    }

    MenuSeparator{}
    //缩小
    MyMenuItem{
        text: "缩小（&O)"
        icon.name: "file-zoom-out"
        sequence:"Ctrl+-"
    }

    Menu{
        title:"缩放（&Z)"
        icon.source: "icon/noneIcon.png"

        ColumnLayout{
            Repeater{
                model:10
                delegate:
                    RadioButton{
                        text:(index+1)*10+"%"
                        width: 200
                    }
            }
            Repeater{
                model:9
                delegate:
                    RadioButton{
                        text:(index+2)*100+"%"
                        width: 200
                }
            }
            Repeater{
                model:8
                delegate:
                    RadioButton{
                        text:(index+3)*500+"%"
                        width: 200
                }
            }

            Repeater{
                model:5
                delegate:
                    RadioButton{
                        text:(index+6)*1000+"%"
                        width: 200
                }
            }

            Repeater{
                model:4
                delegate:
                    RadioButton{
                        text:(index+5)*2500+"%"
                        width: 200
                }
            }
        }


    }

    //放大
    MyMenuItem{
        text: "放大（&I)"
        icon.name: "file-zoom-in"
        sequence:"Ctrl++"
    }

    MenuSeparator{}

    MyMenuItem
        {
            text: qsTr("显示网格(&G)")
            sequence: "Ctrl+G"
            icon.source: "icon/checkBox-false"
            property bool ischecked: false
            // enabled: false
            onTriggered:
            {
                console.log("显示网格")
                ischecked = !ischecked
                icon.source = ischecked ? "icon/checkBox-true" : "icon/checkBox-false"
            }
        }

    MyMenuItem
        {
            text: qsTr("显示总览图(&H)")
            sequence: "Ctrl+H"
            icon.source: "icon/checkBox-false"
            property bool ischecked: false
            // enabled: false
            onTriggered:
            {
                console.log("显示总览图")
                ischecked = !ischecked
                icon.source = ischecked ? "icon/checkBox-true" : "icon/checkBox-false"
            }
        }
    MenuSeparator{}

    MyMenuItem
        {
            text: qsTr("总览图缩放显示（&M)")
            icon.source: "icon/checkBox-false"
            property bool ischecked: false
            enabled: false
            onTriggered:
            {
                console.log("总览图缩放显示（")
                ischecked = !ischecked
                icon.source = ischecked ? "icon/checkBox-true" : "icon/checkBox-false"
            }
        }

    MyMenuItem
        {
            text: qsTr("启用总览图矩阵(&R)")
            icon.source: "icon/checkBox-false"
            property bool ischecked: false
            enabled: false
            onTriggered:
            {
                console.log("启用总览图矩阵")
                ischecked = !ischecked
                icon.source = ischecked ? "icon/checkBox-true" : "icon/checkBox-false"
            }
        }




}
