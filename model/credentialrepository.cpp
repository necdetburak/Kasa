#include "credentialrepository.h"

#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

CredentialRepository::CredentialRepository() {}

bool CredentialRepository::open(const QString &path)
{
    m_db = QSqlDatabase::addDatabase("QSQLITE");
    m_db.setDatabaseName(path);

    if(!m_db.open())
    {
        qWarning()<<"Veritabanı acılmadi"<<m_db.lastError().text();
        return false;
    }
    return createTable();
}

bool CredentialRepository::createTable()
{
    QSqlQuery query(m_db);

    const QString sql =
        "CREATE TABLE IF NOT EXISTS credentials ("
        "  id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "  title TEXT NOT NULL,"
        "  username TEXT NOT NULL,"
        "  password TEXT,"
        "  notes TEXT"
        ")";

    if (!query.exec(sql)) {
        qWarning() << "Tablo olusturulamadi:" << query.lastError().text();
        return false;
    }

    return true;
}

bool CredentialRepository::insert(Credential &c)
{
    QSqlQuery query(m_db);
    query.prepare(
        "INSERT INTO credentials (title, username, password, notes) "
        "VALUES (:title, :username, :password, :notes)"
        );

    query.bindValue(":title",c.title);
    query.bindValue(":username",c.username);
    query.bindValue(":password",c.password);
    query.bindValue(":notes",c.notes);

    if(!query.exec()){
        qWarning() << "insert olusturulamadi:" << query.lastError().text();
        return false;
    }
    c.id=query.lastInsertId().toLongLong();
    return true;
}

QList<Credential> CredentialRepository::loadAll()
{
    QList<Credential> list;

    QSqlQuery query(m_db);
    if (!query.exec("SELECT * FROM credentials ORDER BY title")) {   // 1)
        qWarning() << "load olusturulamadi:" << query.lastError().text();
        return list;
    }

    while (query.next()) {
        Credential c;
        c.title = query.value("title").toString();
        c.id = query.value("id").toLongLong();
        c.username = query.value("username").toString();
        c.password = query.value("password").toString();
        c.notes = query.value("notes").toString();
        list.append(c);
    }

    return list;
}

bool CredentialRepository::update(const Credential &c)
{
    QSqlQuery query(m_db);
    query.prepare(
        "UPDATE credentials "
        "SET title = :title, username = :username, "
        "password = :password, notes = :notes "
        "WHERE id = :id"
        );

    query.bindValue(":title",    c.title);
    query.bindValue(":username", c.username);
    query.bindValue(":password", c.password);
    query.bindValue(":notes",    c.notes);
    query.bindValue(":id",       c.id);

    if (!query.exec()) {
        qWarning() << "Kayit guncellenemedi:" << query.lastError().text();
        return false;
    }

    if (query.numRowsAffected() == 0) {
        qWarning() << "Guncellenecek kayit bulunamadi, id:" << c.id;
        return false;
    }

    return true;
}

bool CredentialRepository::remove(qint64 id)
{
    QSqlQuery query(m_db);
    query.prepare("DELETE FROM credentials WHERE id = :id");
    query.bindValue(":id", id);

    if (!query.exec()) {
        qWarning() << "Kayit silinemedi:" << query.lastError().text();
        return false;
    }

    if (query.numRowsAffected() == 0) {
        qWarning() << "Silinecek kayit bulunamadi, id:" << id;
        return false;
    }

    return true;
}