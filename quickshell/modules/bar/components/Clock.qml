import QtQuick
import Quickshell

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
        color: bar.colBlue
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    
    }

}
