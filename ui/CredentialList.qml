import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import Kasa

NeonPanel {
    id: listPanel
    accent: Theme.primary

    property var model
    property int editingId: -1

    signal editRequested(int credentialId, string title, string username,
                         string password, string notes)
    signal deleteRequested(int credentialId)

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 26
        spacing: 16

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Text {
                text: "KAYITLAR [" + (credentialGrid.count < 10 ? "0" : "")
                      + credentialGrid.count + "]"
                font.family: Theme.headFont
                font.pixelSize: 20
                font.bold: true
                font.letterSpacing: 3
                color: Theme.primary
            }

            Item { Layout.fillWidth: true }

            TextField {
                id: searchField
                Layout.preferredWidth: 280
                font.family: Theme.monoFont
                font.pixelSize: 14
                color: Theme.textColor
                placeholderText: "ara..."
                placeholderTextColor: Theme.muted
                selectionColor: Theme.secondary
                selectedTextColor: Theme.bg
                leftPadding: 34
                topPadding: 8
                bottomPadding: 8

                onTextChanged: controller.filterModel.searchText = text

                background: Rectangle {
                    color: Theme.field
                    border.width: 1
                    border.color: searchField.activeFocus ? Theme.primary : Theme.dim

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 12
                        anchors.verticalCenter: parent.verticalCenter
                        text: ">"
                        font.family: Theme.monoFont
                        font.pixelSize: 15
                        font.bold: true
                        color: searchField.activeFocus ? Theme.primary : Theme.muted
                    }
                }
            }
        }

        GridView {
            id: credentialGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            model: listPanel.model

            readonly property int columns: width >= 720 ? 2 : 1
            cellWidth: Math.floor(width / columns)
            cellHeight: 176

            ScrollBar.vertical: ScrollBar {
                contentItem: Rectangle {
                    implicitWidth: 3
                    color: Theme.primary
                    opacity: 0.6
                }
            }

            delegate: Item {
                width: credentialGrid.cellWidth
                height: credentialGrid.cellHeight

                CredentialCard {
                    anchors.fill: parent
                    anchors.rightMargin: 12
                    anchors.bottomMargin: 12

                    credentialId: model.credentialId
                    title: model.title
                    username: model.username
                    password: model.password
                    notes: model.notes
                    editing: listPanel.editingId === model.credentialId

                    onEditRequested: listPanel.editRequested(model.credentialId, model.title,
                                                             model.username, model.password,
                                                             model.notes)
                    onDeleteRequested: listPanel.deleteRequested(model.credentialId)
                }
            }

            Text {
                anchors.centerIn: parent
                visible: credentialGrid.count === 0
                text: searchField.text.length > 0 ? "> NO_MATCH_FOUND_" : "> NO_RECORDS_FOUND_"
                font.family: Theme.monoFont
                font.pixelSize: 15
                color: Theme.muted

                SequentialAnimation on opacity {
                    running: credentialGrid.count === 0
                    loops: Animation.Infinite
                    NumberAnimation { to: 0.3; duration: 700 }
                    NumberAnimation { to: 1.0; duration: 700 }
                }
            }
        }
    }
}