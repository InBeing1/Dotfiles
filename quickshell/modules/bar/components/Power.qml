import QtQuick
import Quickshell.Services.UPower

Item {
    id: power
    implicitWidth: label.width
    implicitHeight: bar.height

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    Text {
        id: label

        text: Math.round(UPower.displayDevice.percentage * 100) + "%"
        color: bar.colYellow
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        anchors.verticalCenter: parent.verticalCenter
    }
}
