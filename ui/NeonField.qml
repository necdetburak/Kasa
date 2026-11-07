import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kasa

ColumnLayout {
    id: field
    property string label
    property alias text: input.text

    Layout.fillWidth: true
    spacing: 4

    Text {
        text: "> " + field.label
        font.family: Theme.monoFont
        font.pixelSize: 12
        font.letterSpacing: 2
        color: input.activeFocus ? Theme.primary : Theme.muted
    }

    TextField {
        id: input
        Layout.fillWidth: true
        font.family: Theme.monoFont
        font.pixelSize: 15
        color: Theme.textColor
        selectionColor: Theme.secondary
        selectedTextColor: Theme.bg
        leftPadding: 12
        topPadding: 10
        bottomPadding: 10

        background: Rectangle {
            color: Theme.field
            border.width: 1
            border.color: input.activeFocus ? Theme.primary : Theme.dim

            Rectangle {
                width: 2
                height: parent.height
                color: input.activeFocus ? Theme.primary : "transparent"
            }
        }
    }
}