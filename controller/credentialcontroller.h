#ifndef CREDENTIALCONTROLLER_H
#define CREDENTIALCONTROLLER_H

#include <QObject>
#include "../model/credentialrepository.h"
#include "../model/credentialmodel.h"
#include "../model/credentialfiltermodel.h"

class CredentialController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(CredentialModel* model READ model CONSTANT)
    Q_PROPERTY(CredentialFilterModel* filterModel READ filterModel CONSTANT)
public:
    explicit CredentialController(QObject *parent =nullptr);

    bool init(const QString &dbPath);
    CredentialModel *model()const;
    CredentialFilterModel *filterModel() const;

    Q_INVOKABLE bool addCredential(const QString &title,const QString &username,const QString &password,const QString &notes);
    Q_INVOKABLE bool updateCredential(qint64 id,const QString &title, const QString &username, const QString &password, const QString &notes);
    Q_INVOKABLE bool removeCredential(qint64 id);
    Q_INVOKABLE bool copyToClipboard(const QString &text);
    Q_INVOKABLE QString generatePassword(qint64 length,bool useUpper,bool useDigit, bool useSymbol);

signals:
    void errorOccurred(const QString &message);

private:
    void reload();

    CredentialRepository m_repository;
    CredentialModel *m_model;
    CredentialFilterModel *m_filterModel;
};

#endif // CREDENTIALCONTROLLER_H
