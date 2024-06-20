/** EditorView.qml
 * Wirtten by ZengYan on 2024-6-20
 * Funtion: show image
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Image
{
    id: imageView
    property Editor editor: editor1
    signal modified()
    fillMode: Image.PreserveAspectFit

    Editor
    {
        id: editor1
    }

    Connections
    {
        target: editor
        function onImageChanged()
        {
            modified()
            imageProvider.setImage(editor.image)
            imageView.source = "image://editorimage/" + Math.floor(Math.random() * 1000000000000)
        }
    }

    Rectangle
    {
        id: imageViewDragArea
        anchors.centerIn: parent
        color: "transparent"
        z: 1
        height: status === Image.Ready ? ((sourceSize.height / sourceSize.width >= parent.height / parent.width) ? parent.height :  sourceSize.height * parent.width / sourceSize.width) : parent.height
        width: status === Image.Ready ? ((sourceSize.height / sourceSize.width < parent.height / parent.width) ? parent.width : sourceSize.width * parent.height / sourceSize.height) : parent.width
        DragHandler
        {
            id:dragHandler
            target: imageView
            enabled: ToolCtrl.selectedTool === "移动"
            onActiveChanged:
            {
                modified()
            }
        }

        HoverHandler
        {
            cursorShape:Qt.SizeAllCursor
            enabled: ToolCtrl.selectedTool === "移动"
        }
    }
}
