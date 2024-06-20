/** DialogBox.qml
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: manage dialogs
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
        nameFilters: ["Images files (*.png *.jpg)"]
        fileMode: FileDialog.SaveFile

        onAccepted:
        {
            var savePath = savePathDialog.selectedFile.toString()
            var fileName = savePath.substring(savePath.lastIndexOf("/") + 1) // 获取文件名
            ActiveCtrl.savePath = savePath.substring(7)
            ActiveCtrl.currentLayer.isModified_ = true
            ActiveCtrl.save()
            sharePage.setProperty(tabBar_currentIndex, "pageName", fileName)
            sharePage.setProperty(tabBar_currentIndex, "pixUrl", savePath)
        }
    }

    failToSave: MessageDialog
    {
        id: failToSave
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        text:"Fail to save the image!"
    }

    Component.onCompleted:
    {
        ActiveCtrl.openDialogBox = openFileDialog
        ActiveCtrl.newDialogBox = newImageDialog
        ActiveCtrl.savePathDialod = savePathDialog
        ActiveCtrl.failToSave = failToSave
    }
}
