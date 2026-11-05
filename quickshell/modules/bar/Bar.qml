import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland // Hyprland IPC access
import Quickshell.Io // For Process type
import QtQuick
import QtQuick.Layouts // For RowLayout
import qs.theme
import "components"

PanelWindow {
    id: bar

    implicitHeight: 25
    anchors.top: true
    anchors.left: true
    anchors.right: true
    color: Theme.colBg

    // Memory
    Row {
        id: leftPanel
        anchors.left: parent.left
        spacing: 5

        Workspaces{}
    }

    Row {
        id: centerPanel
        anchors.horizontalCenter: parent.horizontalCenter

        ActiveWindow{}

    }

    Row {
        id: rightPanel
        anchors.right: parent.right
        spacing: 5

        Wifi{}

        Temp{}

        CPU{}

        Memory{}

        Clock{}

        Power{}
    }
}
