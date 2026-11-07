#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "controller/credentialcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    CredentialController controller;
    if (!controller.init("sifreler.db")) {
        qWarning() << "Uygulama baslatilamadi: veritabani acilamadi";
        return -1;
    }

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("controller", &controller);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Kasa", "Main");

    return QGuiApplication::exec();
}