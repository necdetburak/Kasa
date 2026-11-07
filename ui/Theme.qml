pragma Singleton
import QtQuick

QtObject {
    property int index: 0

    readonly property var list: [
        { name: "NEON",      bg: "#07080F", panel: "#0D0F1A", field: "#111427", dim: "#252A44",
          primary: "#00F0FF", secondary: "#FF2BD6", highlight: "#F7F052",
          text: "#D8F6FF", muted: "#6C7A99", card: "#10121F", cardHover: "#141833" },

        { name: "SYNTHWAVE", bg: "#0E0620", panel: "#160A2E", field: "#1E0F3D", dim: "#3A2466",
          primary: "#FF6EC7", secondary: "#FFB347", highlight: "#7DF9FF",
          text: "#F5E6FF", muted: "#9A7FBF", card: "#1A0C35", cardHover: "#241248" },

        { name: "MATRIX",    bg: "#020A04", panel: "#06120A", field: "#0A1A0F", dim: "#1A3A22",
          primary: "#39FF14", secondary: "#00FF9C", highlight: "#CCFF00",
          text: "#D6FFD9", muted: "#5E8A66", card: "#08160C", cardHover: "#0E2214" },

        { name: "BLOOD",     bg: "#0A0203", panel: "#140507", field: "#1C080B", dim: "#3D1218",
          primary: "#FF2E4D", secondary: "#FF8A00", highlight: "#FFE45E",
          text: "#FFE3E6", muted: "#A06A72", card: "#170609", cardHover: "#220A0E" }
    ]

    readonly property var current: list[index]

    readonly property string name:      current.name
    readonly property color bg:         current.bg
    readonly property color panel:      current.panel
    readonly property color field:      current.field
    readonly property color dim:        current.dim
    readonly property color primary:    current.primary
    readonly property color secondary:  current.secondary
    readonly property color highlight:  current.highlight
    readonly property color textColor:  current.text
    readonly property color muted:      current.muted
    readonly property color card:       current.card
    readonly property color cardHover:  current.cardHover
    readonly property color danger:     "#FF3B5C"

    readonly property string monoFont: "Consolas"
    readonly property string headFont: "Bahnschrift"

    function next() {
        index = (index + 1) % list.length
    }
}