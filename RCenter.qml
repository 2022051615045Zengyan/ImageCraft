/** RCenter.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Right center window
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
                    delegate: Rectangle
                    {
                        property string pixUrl_: pixUrl
                        property bool isShow: true
                        height: 25
                        width: 100
                        radius: 20
                        color: viewtags.currentIndex === index ? "grey" : "#00000000"
                        clip: true

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
                                font.bold: viewtags.currentIndex === index ? true : false
                                scale: viewtags.currentIndex === index ? 1.1 : 1
                                text: pixUrl.substring(pixUrl.lastIndexOf("/") + 1)
                                color: "black"
                                Behavior on scale {
                                    NumberAnimation
                                    {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                        }
                        TapHandler
                        {
                            onTapped:
                            {
                                homeTab.source = pixUrl_
                                viewtags.currentIndex = index
                            }
                        }
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
            }
        }
    }
}
