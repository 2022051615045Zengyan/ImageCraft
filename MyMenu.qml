/** MyMenu.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Menu integration
 */
import QtQuick
import QtQuick.Controls

Rectangle{
    width: 500
    height: 800
    MenuBar
    {
        id: menuBar
        //required property ListModel sharePage
        width: parent.width
        Menu_Layer{}
        Menu_Setting{}
        Menu_Help{}

    }
}
