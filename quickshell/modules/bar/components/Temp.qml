import QtQuick
import Quickshell.Io
import qs.theme

Item {
    id: temperature
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight


    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

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
        color: Theme.colBlue
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
    }
}
