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
 * Modified by Zengyan on 2024-6-26
 * added uesr-defined rotation function
 *
 * Modified by RenTianxiang on 2024-7-6
 *      added menu with the right mouse button
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
    property alias rightMenu: _rightMenu

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
        height: 350
        property string selectedwise: "" // 用来存储当前选中的角度值
        property string selectedAngle: "" // 用来存储当前选中的角度值
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
                RowLayout
                {
                    Layout.preferredHeight: direction.height/4*3
                    Layout.preferredWidth:direction.width
                    spacing: 0

                    Repeater {
                        id:wiserepeater
                        model: ["Turn anticlockwise", "Turn clockwise"]
                        RadioButton {
                            text: modelData
                            onClicked: {
                                _rotationDialog.selectedwise=text
                            }
                        }
                    }
                }
            }


            ColumnLayout{
                id:angle
                Layout.preferredHeight: _rotationDialog.height/5*2
                Layout.preferredWidth: _rotationDialog.width
                Text {
                    Layout.preferredHeight: angle.height/5
                    Layout.preferredWidth:angle.width
                    text: qsTr("Angle")
                }
                ColumnLayout{
                    Layout.preferredHeight: angle.height/6*4
                    Layout.preferredWidth:angle.width
                    Repeater {
                        id:anglerepeater
                        model: ["90(D)","180(E)","270(G)","user-defined(U):"]
                        RadioButton {
                            Layout.preferredHeight: angle.height/6
                            Layout.preferredWidth:angle.width
                            text: modelData
                            onClicked: {
                                _rotationDialog.selectedAngle=text
                            }
                        }
                    }
                    RowLayout
                    {
                        id:user
                        Layout.preferredHeight: angle.height/6
                        Layout.preferredWidth:angle.width

                        Slider {
                            id: angleslider
                            enabled: _rotationDialog.selectedAngle==="user-defined(U):"// 直接绑定到RadioButton的checked属性
                            from: 0
                            value: 0
                            to: 360

                            onValueChanged: {
                                control.value = value
                            }
                        }
                        SpinBox {
                            id: control
                            enabled:  _rotationDialog.selectedAngle==="user-defined(U):" // 直接绑定到RadioButton的checked属性
                            editable: true
                            from:0
                            to:360
                            validator: IntValidator {
                                // 这里不需要设置 locale，除非你有特定的本地化需求
                                // bottom 和 top 属性可以用来限制整数的范围
                                bottom: 0  // 最小可接受的整数
                                top: 360   // 最大可接受的整数
                            }
                            onValueChanged: {
                                angleslider.value = value
                            }
                        }
                    }
                }
            }
        }

        onAccepted:
        {
            if(_rotationDialog.selectedAngle==="user-defined(U):")
                _rotationDialog.selectedAngle=control.value.toString()
            else if(_rotationDialog.selectedAngle==="270(G)")
                _rotationDialog.selectedAngle="270"
            else if(_rotationDialog.selectedAngle==="180(G)")
                _rotationDialog.selectedAngle="180"
            else if(_rotationDialog.selectedAngle==="90(G)")
                _rotationDialog.selectedAngle="90"
            ActiveCtrl.rotation(_rotationDialog.selectedwise,parseFloat(_rotationDialog.selectedAngle));
        }
        onRejected: console.log("Cancel clicked")
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

    Menu
    {
        id: _rightMenu
        MenuItem
        {
            text: qsTr("delete")
            onClicked:
            {
                ActiveCtrl.deleteLayer()
            }
        }
        MenuItem
        {
            text: qsTr("Copy")
            onClicked:
            {
                console.log("Copy")
            }
        }
        MenuItem
        {
            text: qsTr("Cut")
            onClicked:
            {
                console.log("Cut")
            }
        }
        MenuItem
        {
            text: qsTr("Paste")
            onClicked:
            {
                console.log("Paste")
            }
        }

        function show()
        {
            popup()
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
        ActiveCtrl.rightMenu = rightMenu
    }
}
