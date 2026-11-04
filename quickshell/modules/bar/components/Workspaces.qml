import QtQuick
import Quickshell.Hyprland

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

            color: isActive ? bar.colCyan : (ws ? bar.colBlue : bar.colMuted )
            font.family: bar.fontFamily
            font.pixelSize: bar.fontSize
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
