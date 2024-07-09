/** Tags.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: tags
 *
 * Modified by RenTianxiang on 2024-6-21
 *      Modified the modification status of the image tag
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
                id: tabBtn
                property bool isHoverd: tabBarHover.hovered
                property bool isModified: stackL.itemAt(index) ? stackL.itemAt(index).isModified : false
                property string imageType: "qrc:/icon/img.svg"
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
                RowLayout
                {
                    spacing: 2

                    Item
                    {
                        Layout.preferredHeight: 10
                        Layout.preferredWidth: 2
                    }

                    Image
                    {
                        z: 1
                        Layout.preferredWidth: 18
                        Layout.preferredHeight: 18
                        fillMode: Image.PreserveAspectFit
                        source: tabBtn.isModified ? "qrc:/icon/save.svg" : imageType
                    }

                    Text
                    {
                        id: imageName
                        Layout.preferredHeight: tabBtn.height
                        Layout.preferredWidth: tabBtn.width - 44
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        text: pageName
                        color: "black"
                        elide: Text.ElideRight // 设置超出部分显示省略号
                        verticalAlignment: Text.AlignVCenter

                        HoverHandler
                        {
                            id: imageName_hover
                        }
                    }

                    Rectangle
                    {
                        id: cancel_btn
                        property bool isHoverd: cancel_btnHover.hovered
                        z: 1
                        Layout.preferredWidth: 15
                        Layout.preferredHeight: 15
                        radius: 15
                        color: isHoverd ?  "lightcoral" : "transparent"
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
                                        ActiveCtrl.close()
                                    }
                                });
                            }
                        }

                        HoverHandler
                        {
                            id: cancel_btnHover
                        }
                    }
                }

                Rectangle
                {
                    parent: imageName
                    anchors.top: parent.bottom
                    visible: imageName_hover.hovered
                    width: showText.width + 6
                    height: showText.height
                    color: "black"
                    Text
                    {
                        id: showText
                        anchors.centerIn: parent
                        text: pageName
                        width: contentWidth
                        height: contentHeight + 5
                        color: "white"
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
                    var fileName = imageName.text
                    var dotIndex = fileName.lastIndexOf('.')
                    var suffix = ""
                    if (dotIndex === -1 || dotIndex === fileName.length - 1)
                    {
                        suffix = ""
                    }
                    suffix = fileName.substring(dotIndex)

                    if(suffix === ".png")
                    {
                        tabBtn.imageType = "qrc:/icon/PNG.svg"
                    }else if(suffix === ".jpg")
                    {
                        tabBtn.imageType = "qrc:/icon/JPG.svg"
                    }else if(suffix === ".jpeg")
                    {
                        tabBtn.imageType = "qrc:/icon/JPEG.svg"
                    }
                }
            }
        }
        onCurrentIndexChanged:
        {
            ActiveCtrl.currentIndex=currentIndex
        }
    }
}
