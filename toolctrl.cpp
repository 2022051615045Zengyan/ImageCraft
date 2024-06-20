/** toolctrl.cpp
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 *   modified by Zengyan on 2014-6-20
 *      added getcolorfunction
 */
#include "toolctrl.h"
#include <QColor>

ToolCtrl::ToolCtrl(QObject *parent)
    : QObject{parent}
{}

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
    m_pointtext->setProperty("text", QString("x: %1 y: %2").arg(x).arg(y));
    return color;
}
//设置底部x,y值
void ToolCtrl::setPointtext(QObject *newPointtext)
{
    if (m_pointtext == newPointtext)
        return;
    m_pointtext = newPointtext;
    emit pointtextChanged();
}
