import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland // Hyprland IPC access
import Quickshell.Io // For Process type
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts // For RowLayout

PanelWindow {
    id: root

    // Themes - define once, use everywhere (Change these later)
    property color colBg: "#1a1b26"
    property color colFg: "#a9b1d6"
    property color colCyan: "#0db9d7"
    property color colMuted: "#444b6a"
    property color colBlue: "#7aa2f7"
    property color colYellow: "#e0af68"

    property string fontFamily: "Noto"
    property int fontSize: 14

    // system info widgets
    property int cpuUsage: 0
    property int memUsage: 0
    property int temp: 0
    
    //CPU Usage
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 25
    color: "#1a1b26"

    Process {
        id: tempProc
        command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone0/temp"]
        stdout: StdioCollector {
            onStreamFinished: {
                const v = parseInt(text.trim())
                temp = isNaN(v) ? "" : Math.round(v / 1000)
            }
        }
        Component.onCompleted: running = true
    }
    // CPU
    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]

        // Splitparser calls onRead for each line of output
        stdout: SplitParser {
            onRead: data => {
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (lastCpuTotal > 0) {
                    cpuUsage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
                }
                lastCpuTotal = total
                lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }

    // Memory
    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                memUsage = Math.round(100 * used / total )
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8

        Repeater {
            model: 9

            // Workspaces
            Text {
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

                text: index + 1
                color: isActive ? root.colCyan : (ws ? root.colBlue : root.colMuted )
                font.family: root.fontFamily
                font.pixelSize: root.fontSize
                font.bold: true

                // Enable Mouse clicks
                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }
        }

        Item { Layout.fillWidth: true }

        Text {
            text: {
                const ws = Hyprland.focusedWorkspace
                const tl = Hyprland.activeToplevel
                if (ws === null || ws === undefined) return ""
                if (ws.toplevels.values.length === 0) return ""
                if (tl === null || tl === undefined) return ""
                return String(tl.title)
            }
            color: root.colCyan
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true
            Layout.fillWidth: true
            elide: Text.ElideRight
            maximumLineCount: 1
        }

        Text {
            text: temp + '\u00b0C'
            color: root.colBlue
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true
        }


        Text {
            text: "CPU: " + cpuUsage + "%"
            color: root.colYellow
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true
        }

        Text {
            text: "Memory: " + memUsage + "%"
            color: root.colCyan
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true
        }
        
        Text {
            id: clock
            text: Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            color: root.colBlue
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd - HH:mm")
            }
        }

        Text {
            text: Math.round(UPower.displayDevice.percentage * 100) + "%"
            color: root.colYellow
            font.family: root.fontFamily
            font.pixelSize: root.fontSize
            font.bold: true
        }
    }

}
