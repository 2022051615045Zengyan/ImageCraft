/** MyMenu.qml
 * Written by ZengYan on 2024-6-18
 * Modified by ZhanXuecai on 2024-6-18
 * Modified by RenTianxiang on 2024-6-18
 * Funtion: Menu integration
 */
import QtQuick
import QtQuick.Controls

ApplicationWindow{
    width: 640
    height: 480
    visible: true
    title: qsTr("Image Craft")

    menuBar:MenuBar
    {
        id: menuBar
        //required property ListModel sharePage
        width: parent.width
        Menu_File{}
        Menu_Edit{}
        Menu_Layer{}
        Menu_Graphics{}
        Menu_Setting{}
        Menu_Filter{}
        Menu_View{}
        Menu_Swatches{}
        Menu_Help{}
    }
}
