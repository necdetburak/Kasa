import QtQuick
import QtQuick.Controls.Basic
import Kasa

Button {
    id: btn
    property color tone: Theme.primary
    property int fontSize: 11

    contentItem: Text {
        text: btn.text
        font.family: Theme.monoFont
        font.pixelSize: btn.fontSize
        font.bold: true
        font.letterSpacing: 1
        color: btn.checked ? Theme.bg
             : btn.hovered ? btn.tone
             : Theme.muted
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: Math.max(36, btn.contentItem.implicitWidth + 18)
        implicitHeight: 28
        color: btn.checked ? btn.tone
             : btn.hovered ? Qt.rgba(btn.tone.r, btn.tone.g, btn.tone.b, 0.15)
             : "transparent"
        border.width: 1
        border.color: btn.checked || btn.hovered ? btn.tone : Theme.dim
    }
}