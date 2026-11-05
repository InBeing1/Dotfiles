import QtQuick
import Quickshell
import qs.theme

Item {
    id: clock
    implicitWidth: label.width
    implicitHeight: bar.height

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

        text: Qt.formatDateTime(systemclock.date, "HH:mm")
        color: Theme.colBlue
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        anchors.centerIn: parent
    
    }

}
