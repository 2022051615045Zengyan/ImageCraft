/** Menu_Filter.qml
 * Written by ZhanXuecai on 2024-6-18
 * Funtion: Filter Menu
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Menu {
    width:300
    title: qsTr("Filter(&T)")

    //上次滤镜操作
    MyMenuItem {
        text: "Last Filter Operation(&F)"
        sequence: "Ctrl+F"
        onTriggered: {
            ActiveCtrl.resetToPreviousFilter()
        }
    }
    MyMenuItem {
        text: "Restored picture(&S)"
        sequence: "Ctrl+S"
        onTriggered: {
            ActiveCtrl.resetToOriginalImage()
        }
    }
    MenuSeparator{}
    //滤镜库
    MyMenuItem {
        text: "滤镜库(&G)..."
        onTriggered:Qt.quit();
    }
    //液化
    MyMenuItem {
        text: qsTr("液化（&L)...")
        onTriggered:Qt.quit();
        sequence: "Shift+Ctrl+X"
    }


    MenuSeparator{}


    //风格化
    Menu{
        title: "风格化"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("浮雕效果")
            onTriggered: {
                ActiveCtrl.applyEmbossFilter()
            }
        }
        MyMenuItem{
            text: qsTr("油画")
            onTriggered:{
                ActiveCtrl.applyOilPaintFilter()
            }
        }
        MyMenuItem{
            text: qsTr("曝光过度")
            onTriggered: {
                ActiveCtrl.applyOverexposureFilter()
            }
        }
        MyMenuItem{
            text: qsTr("扩散")
            onTriggered: {
                ActiveCtrl.applyDiffusionFilter()
            }
        }
    }

    //模糊
    Menu{
        title: "模糊"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("动感模糊")
            onTriggered: {
                ActiveCtrl.applyMotionBlurFilter()
            }
        }
        MyMenuItem{
            text: qsTr("高斯模糊")
            onTriggered:{
                ActiveCtrl.applyGaussianBlurFilter()
            }
        }
        MyMenuItem{
            text: qsTr("进一步模糊")
            onTriggered:{
                ActiveCtrl.applyEnhancedBlurFilter()
            }
        }
        MyMenuItem{
            text: qsTr("镜头模糊")
            onTriggered: {
                ActiveCtrl.applyLensBlurFilter()
            }
        }
    }

    //扭曲
    Menu{
        title: "扭曲"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("波浪")
            onTriggered: {
                ActiveCtrl.applyWaveFilter()
            }
        }
        MyMenuItem{
            text: qsTr("波纹")
            onTriggered: {
                ActiveCtrl.applyRippleFilter()
            }
        }
        MyMenuItem{
            text: qsTr("挤压")
            onTriggered: {
                ActiveCtrl.applySqueezeFilter()
            }
        }
        MyMenuItem{
            text: qsTr("水波")
            onTriggered: {
                ActiveCtrl.applyWaterRippleFilter()
            }
        }
        MyMenuItem{
            text: qsTr("切变")
            onTriggered: {
                ActiveCtrl.applyShearFilter()
            }
        }

    }

    //锐化
    Menu{
        title: "锐化"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("USM锐化")
            onTriggered: {
                ActiveCtrl.applyUSMSharpeningFilter()
            }
        }
        MyMenuItem{
            text: qsTr("防抖")
            onTriggered: {
                ActiveCtrl.applyStabilizationFilter()
            }
        }
        MyMenuItem{
            text: qsTr("锐化边缘")
            onTriggered:{
                ActiveCtrl.applyEdgeSharpeningFilter()
            }
        }
    }

    //像素化
    Menu{
        title: "像素化"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("彩块化")
            onTriggered: {
                ActiveCtrl.applyPixelationFilter()
            }
        }
        MyMenuItem{
            text: qsTr("晶格化")
            onTriggered: {
                ActiveCtrl.applyCrystallizeFilter()
            }
        }
        MyMenuItem{
            text: qsTr("马赛克")
            onTriggered: {
            ActiveCtrl.applyMosaicFilter()
           }
        }
        MyMenuItem{
            text: qsTr("碎片")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("铜版雕刻")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //渲染
    Menu{
        title: "渲染"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("火焰...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("图片框...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("树...")
            onTriggered: console.log("Delete action triggered");
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("分层云彩...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("光照效果...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("镜头光晕...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("纤维...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("云彩")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //杂色
    Menu{
        title: "杂色"
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("减少杂色...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("蒙尘与划痕...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("去斑")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("添加杂色...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("中间值...")
            onTriggered: Qt.quit();
        }
    }
}
