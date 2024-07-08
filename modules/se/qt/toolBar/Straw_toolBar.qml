/** Straw_toolBar.qml
 * Written by ZhanXuecai on 2024-6-19
 * Funtion: Straw toolBar 提取颜色到画板
 *   modified by Zengyan on 2024-7-8
 *      added strawmodel
 */
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ImageCraft 1.0
Item {
    id: straw
    anchors.fill: parent
    RowLayout{
        width: parent.width
        height: parent.height
        spacing: 5
        Label{
                   text: "取样记录:"
               }
        ComboBox {           
            id: _straw_SampleRecords
            Layout.preferredWidth:parent.height*3
            Layout.fillWidth: true
            Layout.minimumWidth: parent.height
            onCurrentIndexChanged: {
                      var index = currentIndex
                      ToolCtrl.showcolorSet(model[index]);
                  }
        }
        Component.onCompleted: {
            ToolCtrl.straw_SampleRecords=_straw_SampleRecords
        }


        Item {
            Layout.fillWidth: true  // 添加一个空的Item填充剩余空间

            Layout.preferredWidth:1000
        }

    }


}


