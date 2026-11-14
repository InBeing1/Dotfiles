import QtQuick
import Quickshell.Networking
import qs.theme

Item {
    id: wifi
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    readonly property var adapter: Networking.devices.values.find(d => d.type === DeviceType.Wifi)
    readonly property var activeNetwork: adapter ? adapter.networks.values.find(n => n.connected) : undefined
    readonly property bool isConnected: activeNetwork !== undefined && activeNetwork !== null
    readonly property int strength: isConnected ? Math.round(activeNetwork.signalStrength * 100) : 0

    function strengthIcon(level) {
        if (level <= 25) return String.fromCodePoint(0xf091f);
        if (level <= 50) return String.fromCodePoint(0xf0922);
        if (level <= 75) return String.fromCodePoint(0xf0925);
        return String.fromCodePoint(0xf0928);
    }

    Text {
        id: label
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        color: Theme.colCyan
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        text: wifi.isConnected ? wifi.strengthIcon(wifi.strength) : String.fromCodePoint(0xf092e)
    }
}
