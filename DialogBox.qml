/** DialogBox.qml
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: manage dialogs
 *
 * Modified by RenTianxiang on 2024-6-20
 *      added exportPathDialog to select exportPath
 */
import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import ImageCraft 1.0

Item
{
    id: dialogBoxs
    required property ListModel sharePage
    required property int tabBar_currentIndex
    property FileDialog openFileDialog: null
    property Dialog newImageDialog: null
    property FileDialog savePathDialog: null
    property MessageDialog failToSave: null
    property alias exportPathDialog: _exportPathDialog

    openFileDialog: FileDialog
    {
        id: openFileDialog_
        title: qsTr("Open File")
        nameFilters: ["Images files (*.png *.jpg)"]
    }


    newImageDialog:Dialog
    {
        id:canvasDialog
        title:"选择画布"
        modal:true
        standardButtons: Dialog.Ok | Dialog.Cancel

        Row
        {
            spacing: 10

            Repeater
            {
                model:
                [
                    {width: 1600, height: 900, sizeText: "1600x900像素" ,pixUrl_yuan:"/Image/new1600x900.png"},
                    {width: 900, height: 600, sizeText: "900x600像素" ,pixUrl_yuan:"/Image/new900x600.png"},
                    {width: 600, height: 900, sizeText: "600x900像素" ,pixUrl_yuan:"/Image/new600x900.png"},
                ]
                delegate: Item
                {
                    width: 200
                    height: 200

                    Rectangle
                    {
                        id:rect
                        width: 200
                        height: 150
                        border.color: "black"
                        property string pixUrl: modelData.pixUrl_yuan
                        Rectangle
                        {
                            width: modelData.width/10
                            height: modelData.height/10
                            color: "lightblue"
                            anchors.centerIn: parent
                        }
                        Text
                        {
                            text: modelData.sizeText
                            anchors
                            {
                                horizontalCenter: parent.horizontalCenter
                                bottom: rect.bottom
                            }
                        }
                        TapHandler
                        {
                            onTapped:
                            {
                                dialogBoxs.sharePage.append({pageName:"untitled", pixUrl_yuan: rect.pixUrl})
                                canvasDialog.accept()
                            }
                        }
                    }
                }
            }
        }
    }

    savePathDialog: FileDialog
    {
        id: savePathDialog
        title: qsTr("Select Save Path")
        nameFilters: ["PNG Files (*.png)","JPEG Files (*.jpg *.jpeg)","BMP Files (*.bmp)","All Files (*.*)"]
        fileMode: FileDialog.SaveFile
    }

    failToSave: MessageDialog
    {
        id: failToSave
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save the image!"
    }

    FileDialog
    {
        id: _exportPathDialog
        title: qsTr("Selext Export Path")
        nameFilters: ["PNG Files (*.png)","JPEG Files (*.jpg *.jpeg)","BMP Files (*.bmp)","All Files (*.*)"]
        fileMode: FileDialog.SaveFile
    }

    Component.onCompleted:
    {
        ActiveCtrl.openDialogBox = openFileDialog
        ActiveCtrl.newDialogBox = newImageDialog
        ActiveCtrl.savePathDialod = savePathDialog
        ActiveCtrl.failToSave = failToSave
        ActiveCtrl.exportPathDialog = exportPathDialog
    }
}
