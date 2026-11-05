import QtQuick
import Quickshell.Hyprland
import qs.theme

Item {
    id: activewindow
    width: label.width
    height: bar.height

    Text {
        id: label
        text: {
            const ws = Hyprland.focusedWorkspace
            const tl = Hyprland.activeToplevel
            if (ws === null || ws === undefined) return ""
            if (ws.toplevels.values.length === 0) return ""
            if (tl === null || tl === undefined) return ""
            return String(tl.title)
        }
        color: Theme.colPri
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        elide: Text.ElideMiddle
        maximumLineCount: 1
        anchors.verticalCenter: parent.verticalCenter
    }

}
