import QtQuick
import Quickshell.Networking

Item {
    id: wifi
    implicitWidth: label.width
    implicitHeight: bar.height

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    readonly property var adapter: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    readonly property var activeNetwork: adapter ? adapter.networks.values.find(n => n.connected) : undefined

    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: bar.colCyan
        font.family: bar.fontFamily
        font.pixelSize: bar.fontSize
        font.bold: true
        text: wifi.activeNetwork
            ? wifi.activeNetwork.name + " " + Math.round(wifi.activeNetwork.signalStrength * 100) + "%"
            : "Disconnected"
        }
}
