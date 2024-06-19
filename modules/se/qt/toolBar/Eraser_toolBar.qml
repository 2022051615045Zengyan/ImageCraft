/** Eraser_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Eraser toolBar 擦除内容
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: eraser
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height

        Label{
            text:"橡皮大小:"
        }

        ComboBox {
            id: eraser_size
            Layout.preferredWidth:parent.height*3
            model: ["小","中","大"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ToolSeparator {height: parent.height}

        Label{
            text:"摩擦力:"
        }

        ComboBox{
            id:eraser_opacity
            width: parent.height*3
            height: parent.height
            model:["0","10%","20%","30%","40%","50%","60%","70%","80%","90%","100%"]

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间
            Layout.preferredWidth:1000
        }
    }

}

