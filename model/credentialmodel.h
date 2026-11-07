#ifndef CREDENTIALMODEL_H
#define CREDENTIALMODEL_H



#include <QAbstractListModel>
#include "credential.h"

class CredentialModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        IdRole = Qt::UserRole + 1,
        TitleRole,
        UsernameRole,
        PasswordRole,
        NotesRole
    };

    explicit CredentialModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    void setCredentials(const QList<Credential> &list);

private:
    QList<Credential> m_credentials;
};

#endif // CREDENTIALMODEL_H
