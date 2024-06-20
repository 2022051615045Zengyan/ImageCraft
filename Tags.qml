/** Tags.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: tags:
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Item
{
    required property StackLayout stackL
    required property ListModel pageModel
    property alias currentIndex: tabBar.currentIndex

    TabBar
    {
        id: tabBar
        width: parent.width
        height: 25

        Repeater
        {
            model: pageModel
            TabButton
            {
                property bool isHoverd: tabBarHover.hovered
                property bool isModified: stackL.itemAt(index) ? stackL.itemAt(index).isModified : false
                text:  isModified ? pageName + "*" : pageName
                palette.buttonText: "black"
                height: tabBar.height
                width: 100 + cancel_btn.width * 2
                background: Rectangle
                {
                    implicitHeight: parent.height
                    color: isHoverd ? Qt.rgba(173 / 255, 216 / 255, 230 / 255, 0.5) : Qt.rgba(192/255, 192/255, 192/255, 1)
                    border.color: "grey"
                    Rectangle
                    {
                        implicitHeight: parent.height
                        implicitWidth: tabBar.currentIndex === index ? parent.width : 0
                        color: "white"
                        border.color: "grey"
                        Rectangle   //下边框
                        {
                            implicitHeight: 1
                            implicitWidth: parent.width - 2
                            anchors.left: parent.left
                            anchors.leftMargin: 1
                            anchors.bottom: parent.bottom
                            color: "white"
                        }
                    }
                }

                Rectangle
                {
                    id: cancel_btn
                    property bool isHoverd: cancel_btnHover.hovered
                    z: 1
                    width: 15
                    height: 15
                    radius: 15
                    color: isHoverd ?  "lightcoral" : "transparent"
                    anchors
                    {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin: 3
                    }
                    Rectangle
                    {
                        anchors.centerIn: parent
                        height: 8
                        width: 1
                        color: parent.isHoverd ? "white" : "grey"
                        rotation: 45
                    }
                    Rectangle
                    {
                        anchors.centerIn: parent
                        height: 8
                        width: 1
                        color: parent.isHoverd ? "white" : "grey"
                        rotation: -45
                    }

                    TapHandler
                    {
                        onTapped:
                        {
                            // 延迟删除组件
                            Qt.callLater(function()
                            {
                                if (pageModel.count > index)
                                {
                                    pageModel.remove(index, 1)
                                }
                            });
                        }
                    }

                    HoverHandler
                    {
                        id: cancel_btnHover
                    }
                }

                TapHandler
                {
                    onTapped:
                    {
                        tabBar.currentIndex = index
                    }
                }

                HoverHandler
                {
                    id: tabBarHover
                }
                Component.onCompleted:
                {
                    tabBar.currentIndex = index
                }
            }
        }
    }
}
