/** RCenter.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Right center window
 *
 * Modified by ZhanXuecai on 2024-6-21
 * Function: add addBrushLayer()
 *
 * Modified by RenTianxiang on 2024-6-26
 *      The switch between the current image in the Layer is consistent with the switch between the tabs in the RCenter, making it easy to see the currently selected Layer
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Item
{
    id: rcenter
    required property ListModel pageModel
    required property int currentIndex
    required property StackLayout stackL

    StackLayout
    {
        id: rightLayout
        height: parent.height
        width: parent.width
        currentIndex: rcenter.currentIndex

        Repeater
        {
            model: pageModel

            Item
            {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                property Item theStackL: null
                property ListModel layerListModel: null

                Rectangle {
                    color: "black"
                    width: parent.width - viewtags.width - 10
                    height: width
                    anchors.right: parent.right
                    clip: true

                    Image
                    {
                        id: homeTab
                        source: pixUrl_yuan
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                    }
                }

                ListView
                {
                    id: viewtags
                    model: parent.layerListModel
                    height: parent.height
                    width: 100
                    property int pasteNum: 0
                    delegate: Rectangle
                    {
                        property string pixUrl_: pixUrl
                        property bool isShow: true
                        height: 25
                        width: 100
                        radius: 20
                        color: viewtags.currentIndex === index ? "grey" : "#00000000"
                        // clip: true

                        Row
                        {
                            spacing: 10
                            anchors
                            {
                                verticalCenter: parent.verticalCenter
                                left: parent.left
                            }
                            anchors.leftMargin: parent.radius / 4
                            Image
                            {
                                id: eyes
                                width: 20
                                height: width
                                source: isShow ? "qrc:/icon/display.svg" : "qrc:/icon/hide.svg"
                                sourceSize: Qt.size(32, 32)
                                scale: eyesHover.hovered ? 1.1 : 1
                                TapHandler
                                {
                                    onTapped:
                                    {
                                        theStackL.layers.itemAt(index).visible = !theStackL.layers.itemAt(index).visible
                                        theStackL.layers.itemAt(index).modified()
                                        theStackL.layers.itemAt(index).modifiedVisible()
                                    }
                                }

                                Connections
                                {
                                    target: theStackL.layers.itemAt(index)

                                    function onVisibleChanged()
                                    {
                                        isShow = !isShow
                                    }
                                }

                                HoverHandler
                                {
                                    id: eyesHover
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                            Text
                            {
                                id: viewtext
                                width: viewtags.width - eyes.width - 15
                                font.bold: viewtags.currentIndex === index ? true : false
                                scale: viewtags.currentIndex === index ? 1.1 : 1
                                text: pixUrl.substring(pixUrl.lastIndexOf("/") + 1)
                                elide: Text.ElideRight // 设置超出部分显示省略号
                                color: "black"
                                Behavior on scale {
                                    NumberAnimation
                                    {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                HoverHandler
                                {
                                    id: hoverHandler
                                }

                                Rectangle
                                {
                                    width: showText.contentWidth + 6
                                    height: showText.contentHeight + 6
                                    color: "white"
                                    anchors.left: parent.right
                                    visible: hoverHandler.hovered
                                    Text
                                    {
                                        id: showText
                                        anchors.centerIn: parent
                                        color: "black"
                                        text: viewtext.text
                                    }
                                }

                                Component.onCompleted:
                                {
                                    if(text === "paste.png")
                                    {
                                        text = "pastedLayer" + viewtags.pasteNum.toString()
                                        viewtags.pasteNum++
                                    }
                                }
                            }
                        }
                        TapHandler
                        {
                            onTapped:
                            {
                                viewtags.currentIndex = index
                                theStackL.currentView = theStackL.layers.itemAt(index)
                            }
                        }
                        TapHandler
                        {
                            acceptedButtons: Qt.RightButton
                            onTapped:
                            {

                                viewtags.currentIndex = index
                                theStackL.currentView = theStackL.layers.itemAt(index)
                                ActiveCtrl.popRightMenu(point.position.x, point.position.y)
                            }
                        }
                    }

                    onCurrentIndexChanged:
                    {
                        homeTab.source = viewtags.currentItem.pixUrl_
                        theStackL.currentIndex = currentIndex
                    }
                }
                Component.onCompleted:
                {
                    Qt.callLater(function() //延迟赋值 防止stackL还没创建好当前Item
                    {
                        theStackL = stackL.itemAt(index)
                        layerListModel = theStackL.layerModel
                    });
                }

                Connections
                {
                    target: theStackL
                    function onIndexChanged(index)
                    {
                        Qt.callLater(function()
                        {
                            viewtags.currentIndex = index
                        });
                    }
                }
            }
        }
    }
}
