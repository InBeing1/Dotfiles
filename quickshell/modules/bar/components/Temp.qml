import QtQuick
import Quickshell.Io

Item {
    id: temperature

    property int temp: 0

    Process {
        id: proc
        command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone0/temp"]
        stdout: StdioCollector {
            onStreamFinished: {
                const v = parseInt(text.trim())
                temp = isNaN(v) ? "" : Math.round(v / 1000)
            }
        }
        Component.onCompleted: running = true
    }

    Text {
        id: label
        text: temp + '\u00b0C'
        color: bar.colBlue
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    }
}
