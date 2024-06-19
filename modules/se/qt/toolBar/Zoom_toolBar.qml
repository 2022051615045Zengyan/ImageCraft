/** Zoom_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Zoom toolBar
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Item {
    id: zoom
    anchors.fill: parent

    RowLayout {
        width: parent.width
        height: parent.height
        spacing:5

        Button {
            id: _zoom_out
            Layout.preferredWidth: parent.height*3
            text: "缩小"
            icon.name: "file-zoom-out"

            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }

        ComboBox {
            id: _zoom_size
            Layout.preferredWidth: parent.height*3
            model: ListModel{id:_zoom_size_model}
            currentIndex: 0
            Component.onCompleted: {
                for(var i =10 ;i<=100;i+=10)
                {
                    var v = i+"%"
                    _zoom_size_model.append({"value":v})
                }

                for(i =200 ;i<=1000;i+=100)
                {
                    v = i+"%"
                    _zoom_size_model.append({"value":v})
                }

                for(i =1500 ;i<=5000;i+=500)
                {
                    v = i+"%"
                    _zoom_size_model.append({"value":v})
                }

                for(i =6000 ;i<=10000;i+=1000)
                {
                    v = i+"%"
                    _zoom_size_model.append({"value":v})
                }

                for(i =12500 ;i<=20000;i+=2500)
                {
                    v = i+"%"
                    _zoom_size_model.append({"value":v})
                }
            }
            delegate: {
                text:model.value
            }
            Layout.fillWidth: true
            Layout.minimumWidth: 0
        }

        Button {
            id: _zoom_in
            Layout.preferredWidth: parent.height*3
            text: "放大"
            icon.name: "file-zoom-in"
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
        }


        Item {
            Layout.fillWidth: true
            Layout.preferredWidth: 1000
        }
    }
}
