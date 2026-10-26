import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland // Hyprland IPC access
import Quickshell.Io // For Process type
import QtQuick
import QtQuick.Layouts // For RowLayout
import "components"

PanelWindow {
    id: bar

    // Themes - define once, use everywhere (Change these later)
    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colCyan: "#0db9d7"
    property color colMuted: "#444b6a"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"

    property string fontFamily: "Noto"
    property int fontSize: 14

    implicitHeight: 29
    anchors.top: true
    anchors.left: true
    anchors.right: true
    color: colBg


    // Memory
    RowLayout {
        id: left
        anchors.fill: parent


        // Workspaces{}

        // ActiveWindow{}

    }

    RowLayout {
        id: right
        anchors.fill: parent

        // Temp{}

        // CPU{}

        // Memory{}

        Clock{}

        Power{}
    }

}
