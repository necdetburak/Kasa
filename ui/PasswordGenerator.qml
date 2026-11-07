import QtQuick
import QtQuick.Layouts
import Kasa

NeonPanel {
    id: gen
    accent: Theme.highlight

    property int length: 16
    property string password: ""

    signal useRequested(string password)

    implicitHeight: content.implicitHeight + 44

    ColumnLayout {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 22
        spacing: 12

        Text {
            text: "KEYGEN"
            font.family: Theme.headFont
            font.pixelSize: 18
            font.bold: true
            font.letterSpacing: 3
            color: Theme.highlight
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 6

            TagButton {
                text: "−"
                fontSize: 15
                onClicked: gen.length = Math.max(8, gen.length - 1)
            }

            Text {
                Layout.preferredWidth: 34
                text: gen.length
                horizontalAlignment: Text.AlignHCenter
                font.family: Theme.monoFont
                font.pixelSize: 16
                font.bold: true
                color: Theme.textColor
            }

            TagButton {
                text: "+"
                fontSize: 15
                onClicked: gen.length = Math.min(64, gen.length + 1)
            }

            Item { Layout.fillWidth: true }

            TagButton { id: upperToggle;  text: "A-Z"; checkable: true; checked: true; tone: Theme.highlight }
            TagButton { id: digitToggle;  text: "0-9"; checkable: true; checked: true; tone: Theme.highlight }
            TagButton { id: symbolToggle; text: "#$%"; checkable: true; checked: true; tone: Theme.highlight }
        }

        TagButton {
            Layout.fillWidth: true
            text: "[ ÜRET ]"
            tone: Theme.highlight
            fontSize: 13
            onClicked: gen.password = controller.generatePassword(gen.length,
                                                                  upperToggle.checked,
                                                                  digitToggle.checked,
                                                                  symbolToggle.checked)
        }

        // Üretilen şifre + COPY
        CopyRow {
            visible: gen.password.length > 0
            label: "PASS"
            value: gen.password
            valueColor: Theme.highlight
        }

        Text {
            visible: gen.password.length === 0
            text: "> henüz şifre üretilmedi_"
            font.family: Theme.monoFont
            font.pixelSize: 13
            color: Theme.muted
        }

        TagButton {
            Layout.fillWidth: true
            text: "→ FORMA AKTAR"
            tone: Theme.secondary
            enabled: gen.password.length > 0
            opacity: enabled ? 1.0 : 0.35
            onClicked: gen.useRequested(gen.password)
        }
    }
}