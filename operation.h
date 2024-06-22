/**operation.h
 * Wirtten by RanTianxiang on 2024-6-22
 * Used to store the types and parameters for each undo operation.
 */
#pragma once

#include <QMap>
#include <QObject>
#include <QVariant>

class Operation : public QObject
{
    Q_OBJECT
public:
    enum OperationType { MoveLayer, ScaleLayer, AddLayer, ReMoveLayer, ModifiedLayer };
    Q_ENUM(OperationType)

    Operation(OperationType type, const QVariantMap &params, QObject *parent = nullptr);

    OperationType type() const;
    QVariantMap params() const;

private:
    OperationType m_type;
    QVariantMap m_params;
};
