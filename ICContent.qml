/** ICContent.qml
 * Written by RenTianxiang on 2024-6-19
 * Funtion: center window
 */
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ImageCraft 1.0

Item
{
    id: content
    property alias tags: _tags
    property alias lcenter: _lcenter
    property alias rcenter: _rcenter
    property alias pageModel: _pageModel

    ListModel
    {
        id: _pageModel

        function addEelement(fileName, imageUrl)
        {
            append({pageName: fileName, pixUrl_yuan: imageUrl});
        }
    }

    RowLayout
    {
        spacing: 0
        Item
        {
            id: left
            Layout.preferredWidth: content.width / 3 * 2
            Layout.preferredHeight: content.height
            Layout.fillHeight: true
            Layout.fillWidth: true
            ColumnLayout
            {
                spacing: 0
                Tags
                {
                    id: _tags
                    Layout.preferredHeight: 25
                    Layout.preferredWidth: left.width
                    pageModel: content.pageModel
                    stackL: lcenter.stackL

                    onCurrentIndexChanged:
                    {
                        ActiveCtrl.currentIndex = currentIndex
                    }
                }

                LCenter
                {
                    id: _lcenter
                    Layout.preferredHeight: content.height - 25
                    Layout.preferredWidth: left.width
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    pageModel: content.pageModel
                    currentIndex: tags.currentIndex
                }
            }
        }

        Rectangle
        {
            Layout.preferredWidth: 1
            Layout.preferredHeight: content.height
            Layout.fillHeight: true
            color: "grey"
        }

        RCenter
        {
            id: _rcenter
            Layout.preferredWidth: content.width / 3
            Layout.preferredHeight: content.height
            Layout.fillHeight: true
            pageModel: content.pageModel
            currentIndex: tags.currentIndex
            stackL: lcenter.stackL
        }
    }

    Component.onCompleted:
    {
        ActiveCtrl.sharePage = pageModel
    }
}
