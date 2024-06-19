/** Menu_Layer.qml
 * Written by ZengYan on 2024-6-18
 * Funtion: Layer Menu
 */
import QtQuick
import QtQuick.Controls

Menu {
    width:300
    title: qsTr("图层(&L)")
    //新建
    Menu{
        width: 300
        icon.source:"icon/noneIcon.png"
        title: "新建(&N)"
        //图层

        MyMenuItem{
            text: qsTr("图层(&L)...")
            onTriggered: Qt.quit();
            sequence: "Shift+Ctrl+N"

        }
        //背景图层
        MyMenuItem{
            text: qsTr("背景图层(&B)...")
            onTriggered: Qt.quit();
        }
        //组
        MyMenuItem{
            text: qsTr("组(&G)...")
            onTriggered: Qt.quit();
        }
        //从图层建立组
        MyMenuItem{
            text: qsTr("从图层建立组(&A)...")
            onTriggered: Qt.quit();
        }
        //画板
        MyMenuItem{
            text: qsTr("画板...")
            onTriggered: Qt.quit();
        }
        //来自图层组的画板
        MyMenuItem{
            text: qsTr("来自图层组的画板...")
            onTriggered: Qt.quit();
        }
        //来自图层的画板
        MyMenuItem{
            text: qsTr("来自图层的画板...")
            onTriggered: Qt.quit();
        }
        //来自图层的画框
        MyMenuItem{
            text: qsTr("来自图层的画框...")
            onTriggered: Qt.quit();
        }
        //转换为图框
        MyMenuItem{
            text: qsTr("转换为图框")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        //通过拷贝的图层
        MyMenuItem{
            text: qsTr("通过拷贝的图层")
            onTriggered: Qt.quit();
            sequence: "Ctrl+J"
        }
        //通过剪切的图层
        MyMenuItem{
            text: qsTr("通过剪切的图层")
            onTriggered: Qt.quit();
            sequence: "Shift+Ctrl+J"
        }
    }
    //复制图层
    MyMenuItem {
        text: qsTr("复制图层(&D)...")
        onTriggered: console.log("Copy action triggered");

    }
    //删除

    MyMenuItem{
        text: qsTr("删除")
        onTriggered: console.log("Delete action triggered");
    }

    MenuSeparator{}
    //重命名图层
    MyMenuItem{
        text: qsTr("重命名图层...")
        onTriggered: console.log("Rename action triggered");
    }
    //图层样式
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "图层样式(&Y)"
        MyMenuItem{
            text: qsTr("ay")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("by")
            onTriggered: Qt.quit();
        }
    }
    //智能滤镜
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "智能滤镜"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }
    MenuSeparator{}
    //新建填充图层
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "新建填充图层(&W)"
        MyMenuItem{
            text: qsTr("纯色(&O)...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("渐变(&G)...")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("图案(&R)...")
            onTriggered: Qt.quit();
        }
    }
    //新建调整图层
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "新建调整图层(&J)"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }
    //图层内容选项
    MyMenuItem{
        text: qsTr("图层内容选项（&O)...")
        onTriggered: Qt.quit();
    }
    MenuSeparator{}
    //图层蒙版
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "图层蒙版(&M)"
        MyMenuItem{
            text: qsTr("显示全部(&R)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("隐藏全部(&H)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("显示选区(&V)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("隐藏选区(&D)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("从透明区域(&T)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("删除(&E)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("应用(&A)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("启用(&B)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("链接(&L)")
            onTriggered: Qt.quit();
        }
    }
    //矢量蒙版
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "矢量蒙版(&V)"
        MyMenuItem{
            text: qsTr("显示全部(&R)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("隐藏全部(&H)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("当前路径(&U)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("删除(&D)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("启用(&B)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("链接(&L)")
            onTriggered: Qt.quit();
        }
    }
    //创建剪贴蒙版
    MyMenuItem{
        text: "创建剪贴蒙版(&C)..."


        onTriggered: Qt.quit();
        sequence:"Alt+Ctrl+G"

    }
    MenuSeparator{}

    //视频图层
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "视频图层"
        MyMenuItem{
            text: qsTr("从文件新建视频图层(&N)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("新建空白视频图层(&B)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("插入空白帧(&S)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("复制帧(&P)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("删除帧(&D)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("替换素材(&O)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("解释素材(&T)...")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("显示已改变的视频(&A)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("恢复帧(&F)")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("恢复所有帧(&L)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("重新载入帧(&E)")
            onTriggered: Qt.quit();
        }
        MenuSeparator{}
        MyMenuItem{
            text: qsTr("栅格化(&Z)")
            onTriggered: Qt.quit();
        }
    }
    //栅格化
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "栅格化(&Z)"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }
    MenuSeparator{}
    //新建基于图层的切片
    MyMenuItem{
        text: qsTr("新建基于图层的切片(&B)")
        onTriggered: Qt.quit();

    }
    MenuSeparator{}
    //图层编组
    MyMenuItem{
        text: qsTr("图层编组(&G)")
        onTriggered: Qt.quit();
        sequence:"Ctrl+G"
    }
    //取消图层编组

    MyMenuItem{
        text: qsTr("取消图层编组")
        onTriggered: Qt.quit();
        sequence:"Shift+Ctrl+G"
    }
    //隐藏图层
    MyMenuItem{
        text: qsTr("隐藏图层(&R)")
        onTriggered: Qt.quit();

    }
    MenuSeparator{}
    //排列
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "排列(&A)"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }
    //合并形状
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "合并形状(&H)"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }

    MenuSeparator{}
    //对齐
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "对齐(&I)"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }
    //分布
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "分布(&T)"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }
    MenuSeparator{}
    //锁定图层
    MyMenuItem{
        text: qsTr("锁定图层(&L)...")
        onTriggered: Qt.quit();
    }
    MenuSeparator{}
    //链接图层
    MyMenuItem{
        text: qsTr("链接图层(&K)")
        onTriggered: Qt.quit();
    }
    //选择链接图层
    MyMenuItem{
        text: qsTr("选择链接图层(&S)")
        onTriggered: Qt.quit();
    }
    MenuSeparator{}
    //合并图层
    MyMenuItem{
        text: qsTr("合并图层(&E)")
        onTriggered: Qt.quit();
        sequence: "Ctrl+E"
    }
    //并可见图层
    MyMenuItem{
        text: qsTr("合并可见图层")
        onTriggered: Qt.quit();
        sequence: "Shift+Ctrl+E"
    }
    //拼合图像
    MyMenuItem{
        text: qsTr("拼合图像(&F)")
        onTriggered: Qt.quit();
    }
    MenuSeparator{}
    //修边
    Menu{
        icon.source:"icon/noneIcon.png"
        title: "修边"
        MyMenuItem{
            text: qsTr("a")
            onTriggered: Qt.quit();
        }
        MyMenuItem{
            text: qsTr("b")
            onTriggered: Qt.quit();
        }
    }

}
