import QtQuick
import Quickshell.Hyprland
import qs.theme

Item {
    id: activewindow
    implicitWidth: label.contentWidth
    implicitHeight: label.implicitHeight

    Text {
        id: label
        color: Theme.colPri
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        width: Math.min(implicitWidth, 300)
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideMiddle
        maximumLineCount: 1
        text: {
            const ws = Hyprland.focusedWorkspace
            const tl = Hyprland.activeToplevel
            if (ws === null || ws === undefined) return ""
            if (ws.toplevels.values.length === 0) return ""
            if (tl === null || tl === undefined) return ""
            return String(tl.title)
        }
    }

}
