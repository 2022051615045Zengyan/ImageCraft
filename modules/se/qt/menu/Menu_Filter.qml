/** Menu_Filter.qml
 * Written by ZhanXuecai on 2024-6-18
 * Funtion: Filter Menu
 */
import QtQuick
import QtQuick.Controls

Menu {
    width:300
    title: qsTr("滤镜（&T)")

    //上次滤镜操作
    MyMenuItem {
        text: "上次滤镜操作(&F)"
        onTriggered:Qt.quit();
        sequence: "Ctrl+F"
    }
    MenuSeparator{}
    //转换为智能滤镜
    MyMenuItem {
        text: "转换为智能滤镜"
        onTriggered:Qt.quit();
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
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("查找边缘")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("等高线...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("风...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("浮雕效果...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("扩散...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("拼贴...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("曝光过度")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("凸出...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("油画...")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //模糊
    Menu{
        title: "模糊"
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("表面模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("动感模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("方框模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("高斯模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("进一步模糊")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("径向模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("镜头模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("模糊")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("平均")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("特殊模糊...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("形状模糊...")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //扭曲
    Menu{
        title: "扭曲"
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("波浪...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("波纹...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("极坐标...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("挤压...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("切变...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("球面化...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("水波...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("旋转扭曲...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("置换...")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //锐化
    Menu{
        title: "锐化"
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("USM锐化...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("防抖...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("进一步锐化")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("锐化")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("锐化边缘")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("智能锐化...")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //视频
    Menu{
        title: "视频"
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("NTSC颜色")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("逐行...")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //像素化
    Menu{
        title: "像素化"
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("彩块化")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("彩色半调...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("点状化...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("晶格化...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("马赛克...")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("碎片")
            onTriggered: console.log("Delete action triggered");
        }
        MyMenuItem{
            text: qsTr("铜版雕刻...")
            onTriggered: console.log("Delete action triggered");
        }
    }

    //渲染
    Menu{
        title: "渲染"
        icon.source: "icon/noneIcon.png"
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
        icon.source: "icon/noneIcon.png"
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

    //其它
    Menu{
        title: "其它"
        icon.source: "icon/noneIcon.png"
        MyMenuItem{
            text: qsTr("HSB/HSL")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("高反差保留...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("位移...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("自定...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("最大值...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("最小值...")
            onTriggered: Qt.quit();
        }
    }
}
