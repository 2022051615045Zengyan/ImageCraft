import QtQuick
import QtQuick.Controls

Menu
{
    title: qsTr("色板(&C)")

    MyMenuItem
    {
        text: qsTr("加载默认色板")

        onTriggered:
        {
            console.log("加载默认色板")
        }
    }

    MyMenuItem
    {
        text: qsTr("打开色板(&O)")

        onTriggered:
        {
            console.log("打开色板")
        }
    }

    MenuSeparator {}

    MyMenuItem
    {
        text: qsTr("保存色板(&S)")

        onTriggered:
        {
            console.log("保存色板")
        }
    }

    MyMenuItem
    {
        text: qsTr("另存色板为(&A)...")

        onTriggered:
        {
            console.log("另存色板为")
        }
    }

    MenuSeparator {}

    MyMenuItem
    {
        text: qsTr("重新加载色板(&D)")

        onTriggered:
        {
            console.log("重新加载色板")
        }
    }

    MenuSeparator {}

    MyMenuItem
    {
        text: qsTr("色板：添加一行颜色")

        onTriggered:
        {
            console.log("色板：添加一行颜色")
        }
    }

    MyMenuItem
    {
        text: qsTr("色板：删除底部一行颜色")

        onTriggered:
        {
            console.log("色板：删除底部一行颜色")
        }
    }
}
