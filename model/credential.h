#ifndef CREDENTIAL_H
#define CREDENTIAL_H

#include <QString>

struct Credential
{
    qint64 id = -1;
    QString title;
    QString username;
    QString password;
    QString notes;
};

#endif // CREDENTIAL_H
