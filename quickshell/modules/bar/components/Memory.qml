import QtQuick
import Quickshell.Io
import qs.theme

Item {
    id: memory
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

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
        text: "\uefc5\n" + usage + "%"
        color: Theme.colCyan
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
    }
}
