/** Zoom_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Zoom toolBar 对画布整体进行缩放
 *   modified by Zengyan on 2014-6-21
 *      added zoomfunction
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
Item {
    id: zoom
    anchors.fill: parent
    property alias zoom_size: _zoom_size

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
            enabled: _zoom_size.currentIndex!==0

            onClicked: {
                // 随机选择一个不同的选项
                if(_zoom_size.currentIndex===0)
                {
                   return
                }
                else{
                   _zoom_size.currentIndex--

                }
            }
        }


        ComboBox {
            id: _zoom_size
            Layout.preferredWidth: parent.height*3
            model: ListModel{id:_zoom_size_model}
            currentIndex: 9
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
            onCurrentIndexChanged: {
                       // 当用户改变选项时触发

                       var scaleMultiple = _zoom_size_model.get(currentIndex).value;

                      var number = parseFloat(scaleMultiple);

                       // 调用 ToolCtrl.setScaleFactor() 并传递选中项的值
                       ToolCtrl.setScaleFactor(number,currentIndex);
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
            enabled: _zoom_size.currentIndex!==_zoom_size.model.count

            onClicked: {

                if(_zoom_size.currentIndex===_zoom_size.model.count)
                {
                   return
                }
                else{
                    _zoom_size.currentIndex++

                }
            }
        }


        Item {
            Layout.fillWidth: true
            Layout.preferredWidth: 1000
        }
    }
    Component.onCompleted: {
        ToolCtrl.zoom_size=zoom_size
    }
}

