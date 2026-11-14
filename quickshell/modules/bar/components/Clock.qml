import QtQuick
import Quickshell
import qs.theme

Item {
    id: clock
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }
 
    Text {
        id: label

        SystemClock {
            id: systemclock
            precision: SystemClock.Minutes
        }

        text: Qt.formatDateTime(systemclock.date, "HH\nmm")
        color: Theme.colBlue
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
    }

}
