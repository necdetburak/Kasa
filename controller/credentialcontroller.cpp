#include "credentialcontroller.h"
#include <QGuiApplication>
#include <QClipboard>
#include <QRandomGenerator>


CredentialController::CredentialController(QObject *parent)
    :QObject(parent)
    ,m_model(new CredentialModel(this))
    , m_filterModel(new CredentialFilterModel(this))
{
    m_filterModel->setSourceModel(m_model);
}

bool CredentialController::init(const QString &dbPath)
{
    if(!m_repository.open(dbPath)){
        emit errorOccurred("veritabani acilmadi");
        return false;
    }
    reload();
    return true;
}

CredentialModel *CredentialController::model() const
{
    return m_model;
}

void CredentialController::reload()
{
m_model->setCredentials(m_repository.loadAll());
}

bool CredentialController::addCredential(const QString &title,
                                         const QString &username,
                                         const QString &password,
                                         const QString &notes)
{
    Credential c;
    c.title    = title;
    c.username = username;
    c.password = password;
    c.notes    = notes;

    if (!m_repository.insert(c)) {
        emit errorOccurred("Kayit eklenemedi");
        return false;
    }

    reload();
    return true;
}

bool CredentialController::updateCredential(qint64 id,const QString &title, const QString &username, const QString &password, const QString &notes)
{
    Credential c;
    c.id       = id;
    c.title    = title;
    c.username = username;
    c.password = password;
    c.notes    = notes;

    if (!m_repository.update(c)) {
        emit errorOccurred("Kayit güncellenmedi");
        return false;
    }

    reload();
    return true;
}

bool CredentialController::removeCredential(qint64 id)
{
    if(!m_repository.remove(id)){
        emit errorOccurred("Kayit silinmedi");
        return false;
    }

    reload();
    return true;
}

bool CredentialController::copyToClipboard(const QString &text)
{
    QClipboard *clipboard = QGuiApplication::clipboard();
    clipboard->setText(text);
    return clipboard->text() == text;
}

CredentialFilterModel *CredentialController::filterModel() const
{
    return m_filterModel;
}


QString CredentialController::generatePassword(qint64 length,bool useUpper,bool useDigit, bool useSymbol)
{
    QString charpool={"abcdefghijklmnopqrstuvwxyz"};
    QString upperCharpool={"ABCDEFGHIJKLMNOPQRSTUVWXYZ"};
    QString digitPool={"0123456789"};
    QString symbolPool={"!@#$%^&*()-_=+[]{};:,.?"};
    QString result;
    if (useUpper)
        charpool += upperCharpool;
    if (useSymbol)
        charpool += symbolPool;
    if (useDigit)
        charpool += digitPool;
    for (int i = 0; i < length; ++i) {
    int pos = QRandomGenerator::system()->bounded(charpool.length());
        result.append(charpool.at(pos));
    }
    return result;
}

