/** toolctrl.h
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 * modified by Zengyan on 2014-6-20
 *      added getcolorfunction
 */
#pragma once

#include <QColor>
#include <QObject>
#include <QQmlEngine>
#include <opencv2/opencv.hpp>

class ToolCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(ToolCtrl)

    Q_PROPERTY(QString selectedTool READ selectedTool WRITE setSelectedTool NOTIFY
                   selectedToolChanged FINAL)
    Q_PROPERTY(QObject *showcolor READ showcolor WRITE setShowcolor NOTIFY showcolorChanged FINAL)
    Q_PROPERTY(QObject *pointtext READ pointtext WRITE setPointtext NOTIFY pointtextChanged FINAL)

public:
    explicit ToolCtrl(QObject *parent = nullptr);
    QString selectedTool() const;
    void setSelectedTool(const QString &newSelectedTool);

    Q_INVOKABLE QColor getPixelColor(const QString &imagepath, int x, int y);

    QObject *showcolor() const;
    void setShowcolor(QObject *newShowcolor);

    QObject *pointtext() const;
    void setPointtext(QObject *newPointtext);

signals:
    void selectedToolChanged();

    void showcolorChanged();

    void pointtextChanged();

private:
    QString m_selectedTool;
    QObject *m_showcolor = nullptr;
    QObject *m_pointtext = nullptr;
};
