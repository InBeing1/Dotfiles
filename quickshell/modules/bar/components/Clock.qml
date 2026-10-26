import QtQuick
import Quickshell

Item {
    id: clock
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitWidth

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    Component.onCompleted: console.log("size:", width, height, implicitWidth, implicitHeight)
 
    Text {
        id: label

        SystemClock {
            id: systemclock
            precision: SystemClock.Minutes
        }

        text: Qt.formatDateTime(systemclock.date, "ddd, MMM dd - HH:mm")
        color: bar.colBlue
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    
    }

}
