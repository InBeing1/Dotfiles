import QtQuick
import Quickshell.Services.UPower

Item {
    id: power
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    Component.onCompleted: console.log("size:", width, height, implicitWidth, implicitHeight)
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
