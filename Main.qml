import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts

ApplicationWindow {
    id: root
    width: 1440
    height: 880
    minimumWidth: 1000
    minimumHeight: 820
    visible: true
    visibility: Window.Maximized
    title: "Kasa"
    color: Theme.bg

    // ---------- Izgara zemin ----------
    Item {
        anchors.fill: parent
        z: -1

        Repeater {
            model: Math.ceil(root.width / 40)
            Rectangle {
                x: index * 40
                width: 1
                height: parent.height
                color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.05)
            }
        }
        Repeater {
            model: Math.ceil(root.height / 40)
            Rectangle {
                y: index * 40
                width: parent.width
                height: 1
                color: Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.05)
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 22

        // ---------- Başlık ----------
        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Text {
                text: "KASA"
                font.family: Theme.headFont
                font.pixelSize: 38
                font.bold: true
                font.letterSpacing: 8
                color: Theme.primary
            }
            Text {
                text: "//"
                font.family: Theme.headFont
                font.pixelSize: 38
                font.bold: true
                color: Theme.secondary
            }
            Text {
                Layout.alignment: Qt.AlignBottom
                Layout.bottomMargin: 7
                text: "secure_vault v0.1"
                font.family: Theme.monoFont
                font.pixelSize: 14
                color: Theme.muted
            }
            Rectangle {
                Layout.alignment: Qt.AlignBottom
                Layout.bottomMargin: 7
                width: 10
                height: 18
                color: Theme.primary

                SequentialAnimation on opacity {
                    loops: Animation.Infinite
                    NumberAnimation { to: 0; duration: 500 }
                    NumberAnimation { to: 1; duration: 500 }
                }
            }

            Item { Layout.fillWidth: true }

            TagButton {
                text: "[ THEME: " + Theme.name + " ]"
                fontSize: 14
                onClicked: Theme.next()
            }
        }

        // ---------- Paneller ----------
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 28

            // ===== SOL SÜTUN: Form + Keygen =====
            ColumnLayout {
                Layout.preferredWidth: 400
                Layout.minimumWidth: 400
                Layout.maximumWidth: 400
                Layout.fillWidth: false
                Layout.fillHeight: true
                spacing: 28

                EntryForm {
                    id: entryForm
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumHeight: implicitHeight
                }

                PasswordGenerator {
                    Layout.fillWidth: true
                    Layout.preferredHeight: implicitHeight
                    onUseRequested: function(password) {
                        entryForm.setPassword(password)
                    }
                }
            }

            // ===== SAĞ SÜTUN: Kayıtlar =====
            CredentialList {
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: controller.filterModel
                editingId: entryForm.editingId

                onEditRequested: function(credentialId, title, username, password, notes) {
                    entryForm.startEdit(credentialId, title, username, password, notes)
                }

                onDeleteRequested: function(credentialId) {
                    if (entryForm.editingId === credentialId)
                        entryForm.clearForm()
                    controller.removeCredential(credentialId)
                }
            }
        }
    }

    // ---------- Kayan tarama çizgisi ----------
    Rectangle {
        z: 100
        width: parent.width
        height: 2
        color: Theme.primary
        opacity: 0.07

        NumberAnimation on y {
            from: 0
            to: root.height
            duration: 6000
            loops: Animation.Infinite
        }
    }

    Connections {
        target: controller
        function onErrorOccurred(message) {
            console.log("Hata:", message)
        }
    }
}