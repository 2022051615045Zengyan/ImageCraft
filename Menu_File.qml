/** Menu_File.qml
 * Written by Rentianxiang on 2024-6-18
 * Funtion: File Menu
 */
import QtQuick
import QtQuick.Controls

Menu
{
    width: 250
    title: qsTr("文件(&F)")


    MyMenuItem
    {
        text: qsTr("新建(&N)")
        sequence: "Ctrl+N"
        icon.name: "document-new-symbolic"
        onTriggered:
        {
            console.log("新建")
        }
    }

    MyMenuItem
    {
        text: qsTr("打开(&O)...")
        sequence: "Ctrl+O"
        icon.name: "document-open"
        onTriggered:
        {
            console.log("打开")
        }
    }

    Menu
    {
        icon.name: "document-open-recent"
        title: qsTr("最近打开文件(&T)")
    }

    MyMenuItem
    {
        text: qsTr("捕获屏幕截图")
        onTriggered:
        {
            console.log("捕获屏幕截图")
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("图像属性")
        onTriggered:
        {
            console.log("图像属性")
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("关闭(&C)")
        sequence: "Ctrl+W"
        icon.name: "document-close"
        onTriggered:
        {
            console.log("关闭")
        }
    }

    MyMenuItem
    {
        text: qsTr("关闭全部")
        sequence: "Alt+Ctrl+W"
        icon.name: "geany-close-all"
        onTriggered:
        {
            console.log("关闭全部")
        }
    }

    MyMenuItem
    {
        text: qsTr("保存(&S)")
        sequence: "Ctrl+S"
        icon.name: "document-save"
        onTriggered:
        {
            console.log("保存")
        }
    }

    MyMenuItem
    {
        text: qsTr("保存为(&A)...")
        sequence: "Shift+Ctrl+S"
        icon.name: "document-save-as"
        onTriggered:
        {
            console.log("保存为")
        }
    }

    MyMenuItem
    {
        text: qsTr("导出(&X)...")
        icon.name: "document-export"
        onTriggered:
        {
            console.log("导出")
        }
    }


    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("重新加载(&D)")
        sequence: "F5"
        icon.name: "view-refresh"
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("退出(&X)")
        sequence: "Ctrl+Q"
        icon.name: "application-exit"
        onTriggered:
        {
            console.log("退出")
        }
    }
}
