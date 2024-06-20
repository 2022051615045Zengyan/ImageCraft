/** Grip_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Grip toolBar 当画布和图片足够放大时，用抓手以移动画布
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: grip
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5
        CheckBox {
            id: _grip_allwindow
            Layout.preferredWidth: parent
            text: "滚动所有窗口"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {
            Layout.preferredHeight: parent
        }

        Button {
            id: _grip_fitScreen
            Layout.preferredWidth: parent*3
            text: "适合屏幕"
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/shihepingmu.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Button {
            id: _grip_padScreen
            Layout.preferredWidth: parent*3
            text: "填充屏幕"
            icon.source: "qrc:/modules/se/qt/toolBar/Icon/tianchongpingmu.svg"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1500
        }
    }
}
