import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kasa

Rectangle {
    id: card
    property int credentialId: -1
    property string title
    property string username
    property string password
    property string notes
    property bool editing: false

    signal editRequested()
    signal deleteRequested()

    color: hover.hovered ? Theme.cardHover : Theme.card
    border.width: editing ? 2 : 1
    border.color: editing ? Theme.secondary
                : hover.hovered ? Theme.primary
                : Theme.dim

    HoverHandler { id: hover }

    Rectangle {
        width: 3
        height: parent.height
        color: hover.hovered ? Theme.secondary : Theme.primary
    }

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.rightMargin: 16
        anchors.topMargin: 14
        spacing: 6

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            Text {
                Layout.fillWidth: true
                text: card.title
                font.family: Theme.headFont
                font.pixelSize: 19
                font.bold: true
                font.letterSpacing: 1
                font.capitalization: Font.AllUppercase
                color: Theme.primary
                elide: Text.ElideRight
            }

            Text {
                text: "#" + ("0000" + card.credentialId).slice(-4)
                font.family: Theme.monoFont
                font.pixelSize: 12
                color: Theme.secondary
            }

            TagButton {
                text: "EDIT"
                tone: Theme.secondary
                onClicked: card.editRequested()
            }

            Button {
                id: deleteButton
                property bool armed: false

                onClicked: {
                    if (armed) {
                        card.deleteRequested()
                    } else {
                        armed = true
                        disarmTimer.restart()
                    }
                }

                contentItem: Text {
                    text: deleteButton.armed ? "SİL?" : "✕"
                    font.family: Theme.monoFont
                    font.pixelSize: deleteButton.armed ? 12 : 14
                    font.bold: true
                    color: deleteButton.armed ? Theme.bg
                         : deleteButton.hovered ? Theme.danger
                         : Theme.muted
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    implicitWidth: 48
                    implicitHeight: 28
                    color: deleteButton.armed ? Theme.danger
                         : deleteButton.hovered
                           ? Qt.rgba(Theme.danger.r, Theme.danger.g, Theme.danger.b, 0.15)
                           : "transparent"
                    border.width: 1
                    border.color: deleteButton.armed || deleteButton.hovered
                                  ? Theme.danger : Theme.dim
                }

                Timer {
                    id: disarmTimer
                    interval: 3000
                    onTriggered: deleteButton.armed = false
                }
            }
        }

        CopyRow {
            label: "USER"
            value: card.username
        }

        CopyRow {
            label: "PASS"
            value: card.password
            valueColor: Theme.highlight
        }

        Text {
            Layout.fillWidth: true
            visible: card.notes.length > 0
            text: "// " + card.notes
            font.family: Theme.monoFont
            font.pixelSize: 13
            color: Theme.muted
            wrapMode: Text.Wrap
            maximumLineCount: 2
            elide: Text.ElideRight
        }
    }
}