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

    StackLayout
    {
        id: rightLayout
        height: parent.height
        width: parent.width
        currentIndex: rcenter.currentIndex

        Repeater
        {
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
