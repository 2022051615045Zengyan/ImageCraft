/**operation.cpp
 * Wirtten by RanTianxiang on 2024-6-22
 * Used to store the types and parameters for each undo operation.
 */
#include "operation.h"

Operation::Operation(OperationType type, const QVariantMap &params, QObject *parent)
    : QObject(parent)
    , m_type(type)
    , m_params(params)
{}

Operation::OperationType Operation::type() const
{
    return m_type;
}

QVariantMap Operation::params() const
{
    return m_params;
}
