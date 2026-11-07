import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kasa

NeonPanel {
    id: form
    accent: Theme.secondary
    implicitHeight: formColumn.implicitHeight + 52

    property int editingId: -1
    readonly property bool isEditing: editingId !== -1

    function startEdit(credentialId, title, username, password, notes) {
        editingId = credentialId
        titleField.text = title
        usernameField.text = username
        passwordField.text = password
        noteField.text = notes
    }

    function clearForm() {
        editingId = -1
        titleField.text = ""
        usernameField.text = ""
        passwordField.text = ""
        noteField.text = ""
    }

    function setPassword(password) {
        passwordField.text = password
    }

    ColumnLayout {
        id: formColumn
        anchors.fill: parent
        anchors.margins: 26
        spacing: 16

        Text {
            text: form.isEditing
                  ? "EDIT_ENTRY #" + ("0000" + form.editingId).slice(-4)
                  : "NEW_ENTRY"
            font.family: Theme.headFont
            font.pixelSize: 20
            font.bold: true
            font.letterSpacing: 3
            color: Theme.secondary
        }

        NeonField { id: titleField;    label: "BAŞLIK" }
        NeonField { id: usernameField; label: "KULLANICI" }
        NeonField { id: passwordField; label: "ŞİFRE" }
        NeonField { id: noteField;     label: "NOT" }

        Item { Layout.fillHeight: true }

        Button {
            id: saveButton
            Layout.fillWidth: true
            text: form.isEditing ? "[ GÜNCELLE ]" : "[ KAYDET ]"
            enabled: titleField.text.length > 0 && usernameField.text.length > 0
            opacity: enabled ? 1.0 : 0.35

            onClicked: {
                var ok
                if (form.isEditing) {
                    ok = controller.updateCredential(form.editingId,
                                                     titleField.text,
                                                     usernameField.text,
                                                     passwordField.text,
                                                     noteField.text)
                } else {
                    ok = controller.addCredential(titleField.text,
                                                  usernameField.text,
                                                  passwordField.text,
                                                  noteField.text)
                }
                if (ok)
                    form.clearForm()
            }

            contentItem: Text {
                text: saveButton.text
                font.family: Theme.monoFont
                font.pixelSize: 16
                font.bold: true
                font.letterSpacing: 3
                color: saveButton.hovered ? Theme.bg : Theme.secondary
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                implicitHeight: 50
                color: saveButton.pressed ? Qt.darker(Theme.secondary, 1.4)
                     : saveButton.hovered ? Theme.secondary
                     : "transparent"
                border.width: 2
                border.color: Theme.secondary
            }
        }

        Button {
            id: cancelButton
            Layout.fillWidth: true
            visible: form.isEditing
            text: "[ İPTAL ]"
            onClicked: form.clearForm()

            contentItem: Text {
                text: cancelButton.text
                font.family: Theme.monoFont
                font.pixelSize: 14
                font.letterSpacing: 3
                color: cancelButton.hovered ? Theme.textColor : Theme.muted
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                implicitHeight: 40
                color: "transparent"
                border.width: 1
                border.color: cancelButton.hovered ? Theme.textColor : Theme.dim
            }
        }
    }
}