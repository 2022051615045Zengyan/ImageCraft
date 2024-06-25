/** DialogBox.qml
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: manage dialogs
 *
 * Modified by RenTianxiang on 2024-6-20
 *      added exportPathDialog to select exportPath
 *
 * Modified by RenTianxiang on 2024-6-21
 *      added askSaveDialog to ask the user whether to save the current changes
 * Modified by Zengyan on 2024-6-25
 *   add Rotation selection window
 */
import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0

Item
{
    id: dialogBoxs
    required property ListModel sharePage
    required property int tabBar_currentIndex
    property alias openFileDialog: _openFileDialog
    property alias newImageDialog: _newImageDialog
    property alias  rotationDialog: _rotationDialog
    property alias savePathDialog: _savePathDialog
    property alias failToSave: _failToSave
    property alias exportPathDialog: _exportPathDialog
    property alias askSaveDialog: _askSaveDialog

    FileDialog
    {
        id: _openFileDialog
        title: qsTr("Open File")
        nameFilters: ["Images files (*.png *.jpg)"]
    }


    Dialog
    {
        id:_newImageDialog
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
                                _newImageDialog.accept()
                            }
                        }
                    }
                }
            }
        }
    }

    Dialog{
        id:_rotationDialog
        title:"Spin the image"
        standardButtons: Dialog.Ok | Dialog.Cancel
        width: 500
        height: 300
        anchors.centerIn: parent
        ColumnLayout{

                ColumnLayout{
                    id:direction
                    Layout.preferredHeight: _rotationDialog.height/4
                    Layout.preferredWidth: _rotationDialog.width

                    Text {
                        Layout.preferredHeight: direction.height/4
                        Layout.preferredWidth:direction.width
                        text: qsTr("Direction")
                    }
                    RowLayout{
                        Layout.preferredHeight: direction.height/4*3
                        Layout.preferredWidth:direction.width

                        RadioButton{

                            id:anticlockwise
                            text: "Turn anticlockwise"
                            onClicked: {
                                clockwise.enabled=false

                            }
                        }
                        RadioButton{
                            id:clockwise
                            text:"Turn clockwise"
                            onClicked: {
                                anticlockwise.enabled=false

                            }
                        }
                    }
                }


            ColumnLayout{
                id:angle
                Layout.preferredHeight: _rotationDialog.height/4
                Layout.preferredWidth: _rotationDialog.width
                Text {
                    Layout.preferredHeight: angle.height/5
                    Layout.preferredWidth:angle.width

                    text: qsTr("Angle")

                }
                RadioButton{
                    id:angle90
                    Layout.preferredHeight: angle.height/5
                    Layout.preferredWidth:angle.width
                    text: qsTr("90(D)")
                }
                RadioButton{
                    id:angle180
                    Layout.preferredHeight: angle.height/5
                    Layout.preferredWidth:angle.width
                    text: qsTr("180(E)")
                }
                RadioButton{
                    id:angle270
                    Layout.preferredHeight: angle.height/5
                    Layout.preferredWidth:angle.width
                    text: qsTr("270(G)")
                }
                RowLayout
                {
                    id:user
                    Layout.preferredHeight: angle.height/5
                    Layout.preferredWidth:angle.width
                    RadioButton{
                        id:userdefined
                        Layout.preferredHeight: angle.height/5
                        Layout.preferredWidth:angle.width/3
                        text: qsTr("user-defined(U):")
                        onClicked: {

                        }
                    }
                    Slider{
                        id:angleslider
                        from: 1
                        value: 0
                        to: 100
                    }
                    SpinBox {
                        id: control
                        validator: IntValidator {
                            locale: control.locale.name
                            bottom: Math.min(control.from, control.to)
                            top: Math.max(control.from, control.to)
                        }
                    }
                }
            }
        }


    }

    FileDialog
    {
        id: _savePathDialog
        title: qsTr("Select Save Path")
        nameFilters: ["PNG Files (*.png)","JPEG Files (*.jpg *.jpeg)","BMP Files (*.bmp)","All Files (*.*)"]
        fileMode: FileDialog.SaveFile
    }

    MessageDialog
    {
        id: _failToSave
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

    MessageDialog
    {
        id: _askSaveDialog

        title: "Unsaved Changes"
        text: "untitled have unsaved changes. Do you want to save before close it?"
        buttons: MessageDialog.Save | MessageDialog.Discard | MessageDialog.Cancel

        signal saveClicked()
        signal discardClicked()
        signal cancelClicked()

        function openDialog()
        {
            //延迟调用open  防止dialog还在open状态
            Qt.callLater(function()
            {
                text = (sharePage.get(tabBar_currentIndex) ? sharePage.get(tabBar_currentIndex)["pageName"] : "untitled") + " have unsaved changes. Do you want to save before close it?"
                open()
            });
        }

        onButtonClicked: function (button, role)
        {
            switch (button)
            {
            case MessageDialog.Save:
                saveClicked()
                break;
            case MessageDialog.Discard:
                discardClicked()
                break;
            case MessageDialog.Cancel:
                cancelClicked()
                break;
            }
        }

    }

    Component.onCompleted:
    {
        ActiveCtrl.openDialogBox = openFileDialog
        ActiveCtrl.newDialogBox = newImageDialog
        ActiveCtrl.savePathDialod = savePathDialog
        ActiveCtrl.failToSave = failToSave
        ActiveCtrl.exportPathDialog = exportPathDialog
        ActiveCtrl.askSaveDialog = askSaveDialog
        ActiveCtrl.rotationDialogBox=_rotationDialog
    }
}
