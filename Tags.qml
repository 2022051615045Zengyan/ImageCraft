/** Tags.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: tags
 */
import QtQuick
import QtQuick.Controls

Item
{
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
                property bool isHoverd: false
                text:  pageName
                height: parent.height
                width: 100 + cancel_btn.width * 2
                background: Rectangle
                {
                    implicitHeight: parent.height
                    color: isHoverd ? Qt.rgba(173 / 255, 216 / 255, 230 / 255, 0.5) : "white"
                    border.color: "grey"
                    Rectangle
                    {
                        implicitHeight: parent.height
                        implicitWidth: tabBar.currentIndex === index ? parent.width : 0
                        color: Qt.rgba(192/255, 192/255, 192/255, 1)
                    }
                }

                Rectangle
                {
                    id: cancel_btn
                    property bool isHoverd: false
                    z: 1
                    width: 15
                    height: 15
                    radius: 15
                    color: isHoverd ?  "lightcoral" : "transparent"
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 3
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
                            parent.isHoverd = false
                        }
                    }

                    HoverHandler
                    {
                        onHoveredChanged:
                        {
                            if(hovered)
                            {
                                parent.isHoverd = true
                            }else
                            {
                                parent.isHoverd = false
                            }
                        }
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
                    onHoveredChanged:
                    {
                        if(hovered)
                        {
                            parent.isHoverd = true
                        }else
                        {
                            parent.isHoverd = false
                        }
                    }
                }
            }
        }
    }

}
