import QtQuick
import Quickshell.Services.UPower
import qs.theme

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
        color: Theme.colYellow
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        anchors.centerIn: parent
    }
}
