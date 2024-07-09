/** Menu_Filter.qml
 * Written by ZhanXuecai on 2024-6-18
 * Funtion: Filter Menu
 */
import QtQuick
import QtQuick.Controls
import ImageCraft 1.0

Menu {
    width:300
    title: qsTr("Filter（&T)")

    //上次滤镜操作
    MyMenuItem {
        text: qsTr("Last filter operation(&F)")
        sequence: "Ctrl+F"
        onTriggered: {
            ActiveCtrl.resetToPreviousFilter()
        }
    }
    //还原图片
    MyMenuItem {
        text: qsTr("Restore the image(&S)")
        sequence: "Ctrl+S"
        onTriggered: {
            ActiveCtrl.resetToOriginalImage()
        }
    }
    MenuSeparator{}
    //风格化
    Menu{
        title: qsTr("Stylized")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("Embossed effect")
            onTriggered: {
                ActiveCtrl.applyEmbossFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Oil painting")
            onTriggered:{
                ActiveCtrl.applyOilPaintFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Overexposure")
            onTriggered: {
                ActiveCtrl.applyOverexposureFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Diffusion")
            onTriggered: {
                ActiveCtrl.applyDiffusionFilter()
            }
        }
    }

    //模糊
    Menu{
        title: qsTr("Blur")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("Motion blur")
            onTriggered: {
                ActiveCtrl.applyMotionBlurFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Gaussian blur")
            onTriggered:{
                ActiveCtrl.applyGaussianBlurFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Further blur")
            onTriggered:{
                ActiveCtrl.applyEnhancedBlurFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Lens blur")
            onTriggered: {
                ActiveCtrl.applyLensBlurFilter()
            }
        }
    }

    //扭曲
    Menu{
        title: qsTr("Twist")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("Wave")
            onTriggered: {
                ActiveCtrl.applyWaveFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Ripple")
            onTriggered: {
                ActiveCtrl.applyRippleFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Squeeze")
            onTriggered: {
                ActiveCtrl.applySqueezeFilter()
            }
        }
        MyMenuItem{
            text: qsTr("WaterRipple")
            onTriggered: {
                ActiveCtrl.applyWaterRippleFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Shear")
            onTriggered: {
                ActiveCtrl.applyShearFilter()
            }
        }

    }

    //锐化
    Menu{
        title: qsTr("Sharpen")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("USMSharpen")
            onTriggered: {
                ActiveCtrl.applyUSMSharpeningFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Stabilization")
            onTriggered: {
                ActiveCtrl.applyStabilizationFilter()
            }
        }
        MyMenuItem{
            text: qsTr("EdgeSharpen")
            onTriggered:{
                ActiveCtrl.applyEdgeSharpeningFilter()
            }
        }
    }

    //像素化
    Menu{
        title: qsTr("Pixelation")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("Pixelation")
            onTriggered: {
                ActiveCtrl.applyPixelationFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Crystallize")
            onTriggered: {
                ActiveCtrl.applyCrystallizeFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Mosaic")
            onTriggered: {
            ActiveCtrl.applyMosaicFilter()
           }
        }
    }

    //渲染
    Menu{
        title: qsTr("rendering")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("Burning flames！")
            onTriggered: {
                ActiveCtrl.applyFireEffectFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Fuse everything！！")
            onTriggered: {
                ActiveCtrl.applyMoltenEffectFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Like fantastic...")
            onTriggered: {
                ActiveCtrl.applyDreamFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Cold extremely！！")
            onTriggered: {
                ActiveCtrl.applyFreezeColdFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Anime")
            onTriggered: {
                ActiveCtrl.applyAnimeFilter()
            }
        }
        MyMenuItem{
            text: qsTr("Vintage")
            onTriggered:{
                ActiveCtrl.applyVintageFilter()
            }
        }
        MyMenuItem{
            text: qsTr("LensFlare")
            onTriggered: {
                ActiveCtrl.applyLensFlareFilter()
            }
        }
    }

    //杂色
    Menu{
        title: qsTr("variegated")
        icon.source: "qrc:/modules/se/qt/menu/icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("RemoveNoise")
            onTriggered: {
                ActiveCtrl.applyRemoveNoiseFilter()
            }
        }
        MyMenuItem{
            text: qsTr("AddNoise")
            onTriggered: {
                ActiveCtrl.applyAddNoiseFilter()
            }
        }
    }
}
