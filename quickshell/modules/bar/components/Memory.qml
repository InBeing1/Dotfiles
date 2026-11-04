import QtQuick
import Quickshell.Io

Item {
    id: memory
    implicitWidth: label.width
    implicitHeight: bar.height

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    property int usage: 0

    Process {
        id: proc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                usage = Math.round(100 * used / total )
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
        id: label
        text: "Memory: " + usage + "%"
        color: bar.colCyan
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    }
}
