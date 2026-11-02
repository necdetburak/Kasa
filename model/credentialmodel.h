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
        // 1) kalan üç rolü ekle
    };

    explicit CredentialModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

    void setCredentials(const QList<Credential> &list);

private:
    // 2) verileri tutacak üye değişken
};

#endif // CREDENTIALMODEL_H
