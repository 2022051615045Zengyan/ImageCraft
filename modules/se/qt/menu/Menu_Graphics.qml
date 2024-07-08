/** Menu_Graphics.qml
 * Written by Rentianxiang on 2024-6-18
 * Funtion: Graphics Menu
 * modified by Zengyan on 2024-6-24
 *  added  verticallyFlip,horizontallyFlip functions
 * Modified by Zengyan on 2024-6-25
 * added rotation function
 * Modified by Zengyan on 2024-6-26
 * added uesr-defined rotation function
 *   modified by Zengyan on 2024-7-8
 *      added convertToMonochromeDithered,convertToGray,applyGaussianBlur,oppositedColor function
 */

import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Menu{
    width: 300
    id:graphics
    title: qsTr("图像(&I)")

    MyMenuItem
    {
        text: qsTr("裁剪图像到选区大小(&T)")
        sequence: "Ctrl+T"
        enabled: false
        onTriggered:
        {
            console.log("裁剪图像到选区大小")
        }
    }

    MyMenuItem
    {
        text: qsTr("自动裁剪(&O)")
        sequence: "Ctrl+U"
        onTriggered:
        {
            console.log("自动裁剪")
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("更改大小/缩放(&E)")
        sequence: "Ctrl+E"
        onTriggered:
        {
            console.log("更改大小/缩放")
        }
    }

    MyMenuItem
    {
        text: qsTr("翻转(垂直)(&F)")
        sequence: "Ctrl+F"
        onTriggered:
        {
            ActiveCtrl.verticallyFlip();
        }
    }

    MyMenuItem
    {
        text: qsTr("翻转(水平)")
        onTriggered:
        {
            ActiveCtrl.horizontallyFlip();
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("旋转(向左)(&L)")
        icon.name: "object-rotate-left"
        sequence: "Ctrl+Shift+left"
        onTriggered:
        {
            ActiveCtrl.leftRotation()
        }
    }

    MyMenuItem
    {
        text: qsTr("旋转(向右)(&T)")
        icon.name: "object-rotate-right"
        sequence: "Ctrl+Shift+right"
        onTriggered:
        {
            ActiveCtrl.rightRotation()
        }
    }

    MyMenuItem
    {
        text: qsTr("旋转(&R)...")
        icon.name: "transform-rotate"
        sequence: "Ctrl+R"
        onTriggered:
        {
            ActiveCtrl.openDialog()
        }
    }
    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("色彩降为单色(抖动)(&N)")
        onTriggered:
        {
            ActiveCtrl.convertToMonochromeDithered();
            console.log("色彩降为单色(抖动)")
        }
    }

    MyMenuItem
    {
        text: qsTr("色彩降为灰阶(&G)")
        onTriggered:
        {
            ActiveCtrl.convertToGray();
            console.log("色彩降为灰阶")
        }
    }

    MyMenuItem
    {
        text: qsTr("模糊处理")
        onTriggered:
        {
             ActiveCtrl.applyGaussianBlur()
            console.log("模糊处理")
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("颜色反相(&I)")
        sequence: "Ctrl+I"
        onTriggered:
        {
            ActiveCtrl.oppositedColor()
        }
    }

    MyMenuItem
    {
        text: qsTr("清除(&L)")
        sequence: "Ctrl+Shift+N"
        onTriggered:
        {
            console.log("清除")
        }
    }

    MenuSeparator{}


    MyMenuItem
    {
        text: qsTr("选区背景不透明(&D)")
        icon.source: "qrc:/modules/se/qt/menu/icon/checkBox-false"
        property bool ischecked: false
        enabled: false
        onTriggered:
        {
            console.log("清除")
            ischecked = !ischecked
            icon.source = ischecked ? "qrc:/modules/se/qt/menu/icon/checkBox-true" : "qrc:/modules/se/qt/menu/icon/checkBox-false"
        }
    }
}
