#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "model/credentialrepository.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    CredentialRepository repo;
    if (!repo.open("sifreler.db")) {
        qWarning() << "Veritabani acilamadi, test durduruldu";
        return -1;
    }
    qDebug() << "Veritabani hazir";

    // 1) INSERT
    Credential c;
    c.title    = "Gmail";
    c.username = "burak";
    c.password = "deneme123";
    c.notes    = "test kaydi";

    if (repo.insert(c))
        qDebug() << "Eklendi, id:" << c.id;

    // 2) LOAD (ekleme sonrası)
    qDebug() << "--- Ekleme sonrasi kayitlar ---";
    for (const Credential &item : repo.loadAll())
        qDebug() << item.id << item.title << item.username << item.password;

    // 3) UPDATE
    c.password = "yeniSifre";
    qDebug() << "Guncelleme:" << repo.update(c);

    // 4) LOAD (güncelleme sonrası)
    qDebug() << "--- Guncelleme sonrasi kayitlar ---";
    for (const Credential &item : repo.loadAll())
        qDebug() << item.id << item.title << item.username << item.password;

    // 5) REMOVE (olmayan kayıt, false bekleniyor)
    qDebug() << "Olmayan kaydi silme:" << repo.remove(9999);

    // 6) REMOVE (az önce eklenen kayıt)
    qDebug() << "Eklenen kaydi silme:" << repo.remove(c.id);

    // 7) LOAD (silme sonrası)
    qDebug() << "--- Silme sonrasi kayitlar ---";
    for (const Credential &item : repo.loadAll())
        qDebug() << item.id << item.title << item.username << item.password;

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Kasa", "Main");

    return QGuiApplication::exec();
}
