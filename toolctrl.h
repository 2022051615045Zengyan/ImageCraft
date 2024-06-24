/** toolctrl.h
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 * modified by Zengyan on 2014-6-20
 *      added getpiontposition
 * modified by Zengyan on 2014-6-21
 *      added zoomfuntion
 * modified by Zengyan on 2024-6-22
 *     perfected zoom function 
 */
#pragma once

#include <QColor>
#include <QObject>
#include <QQmlEngine>
#include <opencv2/opencv.hpp>
#include <set>
class ToolCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(ToolCtrl)

    Q_PROPERTY(QString selectedTool READ selectedTool WRITE setSelectedTool NOTIFY
                   selectedToolChanged FINAL)
    Q_PROPERTY(QObject *showcolor READ showcolor WRITE setShowcolor NOTIFY showcolorChanged FINAL)
    Q_PROPERTY(QObject *pointtext READ pointtext WRITE setPointtext NOTIFY pointtextChanged FINAL)

    Q_PROPERTY(QObject *currentEditorView READ currentEditorView WRITE setCurrentEditorView NOTIFY
                   currentEditorViewChanged FINAL)
    Q_PROPERTY(QObject *zoom_size READ zoom_size WRITE setZoom_size NOTIFY zoom_sizeChanged FINAL)

    Q_PROPERTY(QStringList zoomList READ zoomList WRITE setZoomList NOTIFY zoomListChanged FINAL)

    Q_PROPERTY(std::set<int> zoomSet READ zoomSet WRITE setZoomSet NOTIFY zoomSetChanged FINAL)

public:
    explicit ToolCtrl(QObject *parent = nullptr);
    QString selectedTool() const;
    void setSelectedTool(const QString &newSelectedTool);

    Q_INVOKABLE QColor getPixelColor(const QString &imagepath, int x, int y);
    Q_INVOKABLE void getPointPositon(int x, int y);
    Q_INVOKABLE void setScaleFactor(const float &Scalemultiple, int currentIndex);
    Q_INVOKABLE void returnScale(double Scalenumber);

    QObject *showcolor() const;
    void setShowcolor(QObject *newShowcolor);

    QObject *pointtext() const;
    void setPointtext(QObject *newPointtext);

    QObject *currentEditorView() const;
    void setCurrentEditorView(QObject *newCurrentEditorView);

    QObject *zoom_size() const;
    void setZoom_size(QObject *newZoom_size);

    QStringList zoomList() const;
    void setZoomList(const QStringList &newZoomList);

    std::set<int> zoomSet() const;
    void setZoomSet(const std::set<int> &newZoomSet);

signals:
    void selectedToolChanged();

    void showcolorChanged();

    void pointtextChanged();

    void currentEditorViewChanged();
    void zoom_sizeChanged();

    void zoomListChanged();

    void zoomSetChanged();

private slots:
    void on_currentEditorViewChanged();
    void modelChangedslot();

private:
    QString m_selectedTool;
    QObject *m_showcolor = nullptr;
    QObject *m_pointtext = nullptr;
    QObject *m_currentEditorView = nullptr;
    QObject *m_zoom_size = nullptr;
    std::set<int> m_zoomSet;
    QStringList m_zoomList;
    int m_modelIndex;
};
