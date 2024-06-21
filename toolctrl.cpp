/** toolctrl.cpp
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 *   modified by Zengyan on 2014-6-20
 *      added getpointposition
 *   modified by Zengyan on 2014-6-21
 *      added zoom function     
 */
#include "toolctrl.h"
#include <QColor>
#include <QQmlProperty>

ToolCtrl::ToolCtrl(QObject *parent)
    : QObject{parent}
{
    connect(this, &ToolCtrl::currentEditorViewChanged, this, &ToolCtrl::on_currentEditorViewChanged);
}

QString ToolCtrl::selectedTool() const
{
    return m_selectedTool;
}

QObject *ToolCtrl::showcolor() const
{
    return m_showcolor;
}

void ToolCtrl::setShowcolor(QObject *newShowcolor)
{
    if (m_showcolor == newShowcolor)
        return;
    m_showcolor = newShowcolor;
    emit showcolorChanged();
}

QObject *ToolCtrl::pointtext() const
{
    return m_pointtext;
}
void ToolCtrl::setPointtext(QObject *newPointtext)
{
    if (m_pointtext == newPointtext)
        return;
    m_pointtext = newPointtext;
    emit pointtextChanged();
}

QObject *ToolCtrl::currentEditorView() const
{
    return m_currentEditorView;
}

void ToolCtrl::setCurrentEditorView(QObject *newCurrentEditorView)
{
    if (m_currentEditorView == newCurrentEditorView)
        return;
    m_currentEditorView = newCurrentEditorView;
    emit currentEditorViewChanged();
}

void ToolCtrl::on_currentEditorViewChanged()
{
    if (!m_currentEditorView) {
        return;
    }
    int currentIndex = QQmlProperty::read(m_currentEditorView, "currentscale").toFloat();
    m_zoom_size->setProperty("currentIndex", currentIndex);
}

QObject *ToolCtrl::zoom_size() const
{
    return m_zoom_size;
}

void ToolCtrl::setZoom_size(QObject *newZoom_size)
{
    if (m_zoom_size == newZoom_size)
        return;
    m_zoom_size = newZoom_size;
    emit zoom_sizeChanged();
}

//选择工具
void ToolCtrl::setSelectedTool(const QString &newSelectedTool)
{
    if (m_selectedTool == newSelectedTool)
        return;
    m_selectedTool = newSelectedTool;
    emit selectedToolChanged();
}

//捕获图片点击点的颜色

QColor ToolCtrl::getPixelColor(const QString &imagepath, int x, int y)
{
    cv::Mat image = cv::imread(imagepath.toStdString());

    if (image.empty()) {
        //printf("无法加载图片!\n");
        qDebug() << "无法加载图片!";
        return -1;
    }
    cv::Vec3b pixel = image.at<cv::Vec3b>(y, x);
    qDebug() << x << " " << y;
    QColor color = QColor(pixel[2], pixel[1], pixel[0]);
    qDebug() << color;
    m_showcolor->setProperty("color", color.name());
    qDebug() << color.name();
    return color;
}
//设置底部x,y值

void ToolCtrl::getPointPositon(int x, int y)
{
    m_pointtext->setProperty("text", QString("x: %1 y: %2").arg(x).arg(y));
}

//缩放图片
void ToolCtrl::setScaleFactor(const float &Scalemultiple, int currentIndex)
{
    if (!m_currentEditorView) {
        return;
    }
    float number = Scalemultiple / 100;
    qDebug() << number;
    m_currentEditorView->setProperty("scale", number);
    m_currentEditorView->setProperty("currentscale", currentIndex);
}
// //捕获图片缩放大小倍数返回缩放值
// QString ToolCtrl::returnScale(int Scalenumber) {}
