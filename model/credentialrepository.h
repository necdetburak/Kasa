#ifndef CREDENTIALREPOSITORY_H
#define CREDENTIALREPOSITORY_H

#include <QList>
#include <QSqlDatabase>
#include "credential.h"

class CredentialRepository
{
public:
    CredentialRepository();

    bool open(const QString &path);

    QList<Credential> loadAll();

    bool insert(Credential &c);

    bool update(const Credential &c);

    bool remove(qint64 id);

private:

    bool createTable();
    bool open();

    QSqlDatabase m_db;
};

#endif // CREDENTIALREPOSITORY_H
