/** MyMenu.qml
 * Written by ZengYan on 2024-6-18
 * Modified by ZhanXuecai on 2024-6-18
 * Modified by RenTianxiang on 2024-6-18
 * Funtion: Menu integration
 */
import QtQuick
import QtQuick.Controls



MenuBar
{
    id: menuBar
    width: parent.width
    required property ListModel sharePage


    Menu_File
    {
        id: file
        sharePage: menuBar.sharePage
    }
    Menu_Edit{}
    Menu_Layer{}
    Menu_Graphics{}
    Menu_Setting{}
    Menu_Filter{}
    Menu_View{}
    Menu_Swatches{}
    Menu_Help{}
}
