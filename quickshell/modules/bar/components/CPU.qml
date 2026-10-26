import QtQuick
import Quickshell.Io

Item {
    id: cpu

    property int usage:0
    property real lastTotal: 0
    property real lastIdle: 0


    Process {
        id: proc
        command: ["sh", "-c", "head -1 /proc/stat"]

        // Splitparser calls onRead for each line of output
        stdout: SplitParser {
            onRead: data => {
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (lastTotal > 0) {
                    usage = Math.round(100 * (1 - (idle - lastIdle) / (total - lastTotal)))
                }
                lastTotal = total
                lastIdle = idle
            }
        }
        Component.onCompleted: running = true
    }


    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            proc.running = true
        }
    }

    Text {
        text: "CPU: " + usage + "%"
        color: bar.colYellow
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    }

}
