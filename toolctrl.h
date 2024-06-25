/** toolctrl.h
 * Written by Rentianxiang on 2024-6-20
 * Funtion: control menuBar
 * modified by Zengyan on 2014-6-20
 *      added getpiontposition
 * modified by Zengyan on 2014-6-21
 *      added zoomfuntion
 * modified by Zengyan on 2024-6-22
 *     perfected zoom function 
 *   Modified by Zengyan on 2024-6-25
 * added rotation function
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
    Q_PROPERTY(QObject *imageSize READ imageSize WRITE setImageSize NOTIFY imageSizeChanged FINAL)
    Q_PROPERTY(QObject *zoomRepeater READ zoomRepeater WRITE setZoomRepeater NOTIFY
                   zoomRepeaterChanged FINAL)
    Q_PROPERTY(QObject *zoomColumnLayout READ zoomColumnLayout WRITE setZoomColumnLayout NOTIFY
                   zoomColumnLayoutChanged FINAL)
public:
    explicit ToolCtrl(QObject *parent = nullptr);
    QString selectedTool() const;
    void setSelectedTool(const QString &newSelectedTool);

    Q_INVOKABLE QColor getPixelColor(const QString &imagepath, int x, int y);
    Q_INVOKABLE void getPointPositon(int x, int y);
    Q_INVOKABLE void setScaleFactor(const float &Scalemultiple, int index);
    Q_INVOKABLE void returnScale(double Scalenumber);
    Q_INVOKABLE void getSize(const QString &size);
    Q_INVOKABLE void getRepeaterIndex(int index);
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

    QObject *imageSize() const;
    void setImageSize(QObject *newImageSize);

    QObject *zoomRepeater() const;
    void setZoomRepeater(QObject *newZoomRepeater);

    QObject *zoomColumnLayout() const;
    void setZoomColumnLayout(QObject *newZoomColumnLayout);

signals:
    void selectedToolChanged();

    void showcolorChanged();

    void pointtextChanged();

    void currentEditorViewChanged();
    void zoom_sizeChanged();

    void zoomListChanged();

    void zoomSetChanged();

    void imageSizeChanged();

    void zoomRepeaterChanged();

    void zoomColumnLayoutChanged();

private slots:
    void on_currentEditorViewChanged();
    void modelChangedslot();

private:
    QString m_selectedTool;
    QObject *m_showcolor = nullptr;
    QObject *m_pointtext = nullptr;
    QObject *m_imageSize = nullptr;
    QObject *m_currentEditorView = nullptr;
    QObject *m_zoom_size = nullptr;
    QObject *m_zoomRepeater = nullptr;
    QObject *m_zoomColumnLayout = nullptr;
    std::set<int> m_zoomSet;
    QStringList m_zoomList;
    int m_modelIndex;
};
