/** activectrl.h
 * Written by ZhanXuecai on 2024-6-20
 * Funtion: control menu actions
 * Funtion: refresh and TakeAFullScreenshot
 */
#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QQuickItem>
#include <QSettings>
#include "editor.h"

class ActiveCtrl : public QObject
{
    Q_OBJECT
    QML_SINGLETON
    QML_NAMED_ELEMENT(ActiveCtrl)

    Q_PROPERTY(QString savePath READ savePath WRITE setSavePath NOTIFY savePathChanged FINAL)
    Q_PROPERTY(Editor* currentEditor READ currentEditor WRITE setCurrentEditor NOTIFY
                   currentEditorChanged FINAL)
    Q_PROPERTY(QObject* newDialogBox READ newDialogBox WRITE setNewDialogBox NOTIFY
                   newDialogBoxChanged FINAL)
    Q_PROPERTY(QObject* currentLayer READ currentLayer WRITE setCurrentLayer NOTIFY
                   currentLayerChanged FINAL)
    Q_PROPERTY(QObject* savePathDialod READ savePathDialod WRITE setSavePathDialod NOTIFY
                   savePathDialodChanged FINAL)
    Q_PROPERTY(QStringList recentFiles READ recentFiles WRITE setRecentFiles NOTIFY
                   recentFilesChanged FINAL)
    Q_PROPERTY(QObject* failToSave READ failToSave WRITE setFailToSave NOTIFY failToSaveChanged FINAL)
    Q_PROPERTY(QObject* openDialogBox READ openDialogBox WRITE setOpenDialogBox NOTIFY
                   openDialogBoxChanged FINAL)
    Q_PROPERTY(QObject* sharePage READ sharePage WRITE setSharePage NOTIFY sharePageChanged FINAL)

    Q_PROPERTY(bool modified READ modified WRITE setModified NOTIFY modifiedChanged FINAL)
    Q_PROPERTY(QSize size READ size WRITE setSize NOTIFY sizeChanged FINAL)
    Q_PROPERTY(
        int currentIndex READ currentIndex WRITE setCurrentIndex NOTIFY currentIndexChanged FINAL)

public:
    explicit ActiveCtrl(QObject* parent = nullptr);

    Q_INVOKABLE void open();
    Q_INVOKABLE void newImage();
    Q_INVOKABLE void save();
    Q_INVOKABLE void saveAs();
    Q_INVOKABLE void close();
    Q_INVOKABLE void closeAll();
    Q_INVOKABLE void addRecentFiles(const QString& filePath);
    Q_INVOKABLE void refresh();
    Q_INVOKABLE void TakeAFullScreenshot();

    Editor* currentEditor() const;
    void setCurrentEditor(Editor* newCurrentEditor);

    QObject* newDialogBox() const;
    void setNewDialogBox(QObject* newNewDialogBox);

    QObject* currentLayer() const;
    void setCurrentLayer(QObject* newCurrentLayer);

    QObject* savePathDialod() const;
    void setSavePathDialod(QObject* newSavePathDialod);

    QString savePath() const;
    void setSavePath(const QString& newSavePath);

    bool modified() const;
    void setModified(bool newModified);

    QSize size() const;
    void setSize(const QSize& newSize);

    QStringList recentFiles() const;
    void setRecentFiles(const QStringList& newRecentFiles);

    QObject* failToSave() const;
    void setFailToSave(QObject* newFailToSave);

    QObject* openDialogBox() const;
    void setOpenDialogBox(QObject* newOpenDialogBox);

    QObject* sharePage() const;
    void setSharePage(QObject* newSharePage);

    int currentIndex() const;
    void setCurrentIndex(int newCurrentIndex);

signals:

    void dialogBoxChanged();

    void currentEditorChanged();

    void newDialogBoxChanged();

    void currentLayerChanged();

    void savePathDialodChanged();

    void savePathChanged();

    void modifiedChanged();

    void sizeChanged();

    void recentFilesChanged();

    void failToSaveChanged();

    void openDialogBoxChanged();

    void sharePageChanged();

    void currentIndexChanged();

    void refreshSignal();

private slots:
    void openSlot();

private:
    QString m_savePath;
    bool m_modified;
    QSize m_size;
    qsizetype m_recentFileNum;
    QStringList m_recentFiles;
    QSettings m_setting;
    QScreen* m_screen;

    Editor* m_currentEditor = nullptr;
    QObject* m_currentLayer = nullptr;
    QString m_originalImageUrl;
    int m_currentIndex;

    QObject* m_openDialogBox = nullptr;
    QObject* m_newDialogBox = nullptr;
    QObject* m_savePathDialod = nullptr;
    QObject* m_failToSave = nullptr;
    QObject* m_sharePage = nullptr;

    void loadRecentFiles();
    void saveRecentFiles();
};
