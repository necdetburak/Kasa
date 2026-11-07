import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kasa

RowLayout {
    id: row
    property string label
    property string value
    property color valueColor: Theme.textColor

    Layout.fillWidth: true
    spacing: 8

    Text {
        Layout.preferredWidth: 56
        text: row.label + " >"
        font.family: Theme.monoFont
        font.pixelSize: 14
        color: Theme.muted
    }

    TextEdit {
        Layout.fillWidth: true
        Layout.preferredWidth: 1
        text: row.value
        readOnly: true
        selectByMouse: true
        clip: true
        font.family: Theme.monoFont
        font.pixelSize: 14
        color: row.valueColor
        selectionColor: Theme.secondary
        selectedTextColor: Theme.bg
    }

    Button {
        id: copyButton
        property bool copied: false

        onClicked: {
            if (controller.copyToClipboard(row.value)) {
                copied = true
                resetTimer.restart()
            }
        }

        contentItem: Text {
            text: copyButton.copied ? "✓" : "COPY"
            font.family: Theme.monoFont
            font.pixelSize: copyButton.copied ? 16 : 11
            font.bold: true
            font.letterSpacing: 1
            color: copyButton.copied ? Theme.highlight
                 : copyButton.hovered ? Theme.primary
                 : Theme.muted
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        background: Rectangle {
            implicitWidth: 60
            implicitHeight: 26
            color: copyButton.hovered
                   ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.12)
                   : "transparent"
            border.width: 1
            border.color: copyButton.copied ? Theme.highlight
                        : copyButton.hovered ? Theme.primary
                        : Theme.dim
        }

        Timer {
            id: resetTimer
            interval: 1500
            onTriggered: copyButton.copied = false
        }
    }
}