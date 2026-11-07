#include "credentialmodel.h"

CredentialModel::CredentialModel(QObject *parent):QAbstractListModel(parent)
{

}
int CredentialModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_credentials.size();
}

QVariant CredentialModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() < 0 || index.row() >= m_credentials.size())
        return QVariant();

    const Credential &c = m_credentials.at(index.row());

    switch (role) {
    case IdRole:       return c.id;
    case TitleRole:    return c.title;
    case UsernameRole: return c.username;
    case PasswordRole: return c.password;
    case NotesRole:    return c.notes;
    default:           return QVariant();
    }
}

QHash<int, QByteArray> CredentialModel::roleNames() const
{
    return {
        { IdRole,       "credentialId" },
        { TitleRole,    "title" },
        { UsernameRole, "username" },
        { PasswordRole, "password" },
        { NotesRole,    "notes" }
    };
}

void CredentialModel::setCredentials(const QList<Credential> &list)
{
    beginResetModel();
    m_credentials = list;
    endResetModel();
}