import QtQuick
import Kasa

Rectangle {
    id: panel
    property color accent: Theme.primary

    color: Theme.panel
    border.width: 1
    border.color: Qt.rgba(accent.r, accent.g, accent.b, 0.45)

    Rectangle {
        z: -1
        anchors.fill: parent
        anchors.margins: -4
        color: "transparent"
        border.width: 2
        border.color: Qt.rgba(panel.accent.r, panel.accent.g, panel.accent.b, 0.12)
    }

    Rectangle { x: -1; y: -1; width: 22; height: 2; color: panel.accent }
    Rectangle { x: -1; y: -1; width: 2; height: 22; color: panel.accent }

    Rectangle {
        anchors.right: parent.right; anchors.bottom: parent.bottom
        anchors.rightMargin: -1; anchors.bottomMargin: -1
        width: 22; height: 2; color: panel.accent
    }
    Rectangle {
        anchors.right: parent.right; anchors.bottom: parent.bottom
        anchors.rightMargin: -1; anchors.bottomMargin: -1
        width: 2; height: 22; color: panel.accent
    }
}