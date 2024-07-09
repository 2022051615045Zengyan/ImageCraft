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
    title: qsTr("Image(&I)")

    MyMenuItem
    {
        text: qsTr("Flip (Vertical)(&F)")
        sequence: "Ctrl+F"
        onTriggered:
        {
            ActiveCtrl.verticallyFlip();
        }
    }

    MyMenuItem
    {
        text: qsTr("Flip (Horizontal)")
        onTriggered:
        {
            ActiveCtrl.horizontallyFlip();
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("Rotate (Left)(&L)")
        icon.name: "object-rotate-left"
        sequence: "Ctrl+Shift+left"
        onTriggered:
        {
            ActiveCtrl.leftRotation()
        }
    }

    MyMenuItem
    {
        text: qsTr("Rotate (Right)(&T)")
        icon.name: "object-rotate-right"
        sequence: "Ctrl+Shift+right"
        onTriggered:
        {
            ActiveCtrl.rightRotation()
        }
    }

    MyMenuItem
    {
        text: qsTr("Revolve(&R)...")
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
        text: qsTr("Color downgraded to monochrome (Dithering)(&N)")
        onTriggered:
        {
            ActiveCtrl.convertToMonochromeDithered();
        }
    }

    MyMenuItem
    {
        text: qsTr("The color is reduced to grayscale(&G)")
        onTriggered:
        {
            ActiveCtrl.convertToGray();
        }
    }

    MyMenuItem
    {
        text: qsTr("Blurring")
        onTriggered:
        {
             ActiveCtrl.applyGaussianBlur()
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("The color is inverted(&I)")
        sequence: "Ctrl+I"
        onTriggered:
        {
            ActiveCtrl.oppositedColor()
        }
    }

    MenuSeparator{}

    MyMenuItem
    {
        text: qsTr("The selection background is opaque(&D)")
        icon.source: "qrc:/modules/se/qt/menu/icon/checkBox-false"
        property bool ischecked: false
        enabled: false
        onTriggered:
        {
            ischecked = !ischecked
            icon.source = ischecked ? "qrc:/modules/se/qt/menu/icon/checkBox-true" : "qrc:/modules/se/qt/menu/icon/checkBox-false"
        }
    }
}
