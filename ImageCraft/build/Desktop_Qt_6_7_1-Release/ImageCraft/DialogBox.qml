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
                ActiveCtrl.copyImagetoClipboard()
            }
        }
        MenuItem
        {
            text: qsTr("Cut")
            onClicked:
            {
                ActiveCtrl.cutImagetoClipboard()
            }
        }
        MenuItem
        {
            text: qsTr("Paste")
            onClicked:
            {
                ActiveCtrl.pasteImageFromClipboard()
            }
        }

        function show()
        {
            popup()
        }
    }

    MessageDialog
    {
        id: _userManualDialog

        title: "User Manual"
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        informativeText: qsTr("Select: Select the picture, and you can operate on the selected image.

 Open and save picture files: open picture files from the local file system, and support saving the modified pictures.

 Image movement: After clicking the corresponding sidebar movement tool, the image is moved, zoom and rotated, so as to better view and edit details.

 Image zoom: Click the side toolbar zoom tool or menu bar options to realize the zoom function of the picture.

Image rotation: you can click the side toolbar zoom tool and use the touch pad to rotate, or click the menu bar tool and click the corresponding option to rotate and flip the image.

 Real-time preview: after the image is modified, the real-time update display on the interface.

 Multi-tag support: can open and edit multiple pictures in multiple tabs at the same time, convenient for users to compare and process different pictures.

 Copy, Cut, and Paste: Support to copy, cut, and paste images within the editor.

 Cropping: It provides simple cropping tools.

Adjustment: the basic image adjustment function, such as color reduction to monochrome and jitter effect, color reduction to gray scale, fuzzy processing, color inversion, etc.

 Filter: Click the menu bar option to set a variety of filter effects, such as styling, blur, sharpening, pixelated, rendering, color, and etc.

 Undo and redo: Support for undo and redo drawing operations, ensuring that users can easily correct errors during the drawing process.

 Color selector: provides a variety of color selection methods, such as using straws for color extraction, preset color, color palette, or custom color, to meet different drawing requirements.

 Text Drawing: Allows users to add text labels or comments to images to facilitate description and communication.

 Free drawing: Free drawing and labeling using multiple brushes and colors.

 Eraser: The eraser tool is supported to erase drawn parts or whole strokes.

 Layer operation: create and delete layers, hide layers, etc")

    }
    MessageDialog
    {
        id: _instructionDialog
        title: "Instructions"
        modality: Qt.WindowModal
        buttons:MessageDialog.Ok
        informativeText: qsTr("ImageCraft is a picture editor similar to kolourPaint, aiming to provide an easy to use interface, allowing users to get a better experience when using, image processing and editing, processing and other functions, so that users can get the desired effect.")
        detailedText: "authors: 3453163171@qq.com, 3048484140@qq.com, 3084573622@qq.com  GitHubaddress:https://github.com/2022051615045Zengyan/ImageCraft.git"
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
        ActiveCtrl.manualDialog=_userManualDialog
        ActiveCtrl.instructionDialog=_instructionDialog

    }
}
