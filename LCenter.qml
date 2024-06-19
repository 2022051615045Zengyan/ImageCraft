/** LCenter.qml
 * Written by Zengyan on 2024-6-19
 * Funtion: left center window
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item
{
    id: lcenter
    required property ListModel pageModel
    required property int currentIndex

    StackLayout
    {
        id: stackL
        height: parent.height
        width: parent.width
        currentIndex: lcenter.currentIndex
        clip: true

        Repeater {
            model: pageModel

            Rectangle
            {
                color: "black"
                anchors.centerIn: parent

                Layout.maximumWidth: parent.width / 5 * 4
                Layout.minimumWidth: parent.width / 5 * 4
                Layout.maximumHeight: parent.height / 5 * 4
                Layout.minimumHeight: parent.height / 5 * 4
                clip: true
                Image
                {
                    id: homeTab
                    source: pixUrl_yuan
                    width: parent.width - 50
                    height: parent.height - 50
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: parent
                }
            }
        }
    }
}
