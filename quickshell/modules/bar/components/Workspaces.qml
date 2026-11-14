import QtQuick
import Quickshell.Hyprland
import qs.theme

Repeater {
    id: workspaces
    model: 9

    // Workspaces
    Item {
        implicitWidth: label.width
        implicitHeight: bar.implicitHeight

        Text {
            id: label

            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
            property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

            text: index + 1

            color: isActive ? Theme.colPri : (ws ? Theme.colBlue : Theme.colMuted )
            font.family: Theme.fontFamily
            font.pixelSize: Theme.fontSize
            font.bold: true
            anchors.centerIn: parent
        }
    }
}
