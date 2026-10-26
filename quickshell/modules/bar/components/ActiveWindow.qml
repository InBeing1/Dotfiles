import QtQuick
import Quickshell.Hyprland

Rectangle{
    Text {
        text: {
            const ws = Hyprland.focusedWorkspace
            const tl = Hyprland.activeToplevel
            if (ws === null || ws === undefined) return ""
            if (ws.toplevels.values.length === 0) return ""
            if (tl === null || tl === undefined) return ""
            return String(tl.title)
        }
        color: bar.colCyan
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        elide: Text.ElideMiddle
        maximumLineCount: 1
        anchors.verticalCenter: parent.verticalCenter
    }

}
