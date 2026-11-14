import QtQuick
import Quickshell.Services.UPower
import qs.theme

Item {
    id: power
    implicitWidth: label.implicitWidth
    implicitHeight: label.implicitHeight

    Rectangle { 
        anchors.fill: parent 
        color: "#44ff0000"
    }

    readonly property var bat: UPower.displayDevice
    readonly property bool present: bat !== null && bat !== undefined && bat.isPresent
    readonly property int pct: present ? Math.round(bat.percentage * 100) : 0
    readonly property bool charging: present && bat.state === UPowerDeviceState.Charging

    // index 0 to 10, one icon per 10%
    readonly property var normalIcons: [
        0xf008e, 0xf007a, 0xf007b, 0xf007c, 0xf007d, 0xf007e,
        0xf007f, 0xf0080, 0xf0081, 0xf0082, 0xf0079
    ]
    readonly property var chargingIcons: [
        0xf089f, 0xf089c, 0xf0086, 0xf0087, 0xf0088, 0xf089d,
        0xf0089, 0xf089e, 0xf008a, 0xf008b, 0xf0085
    ]

    function iconFor(p, isCharging) {
        const i = Math.min(10, Math.max(0, Math.round(p / 10)));
        return String.fromCodePoint((isCharging ? chargingIcons : normalIcons)[i]);
    }

    Text {
        id: label

        text: power.iconFor(power.pct, power.charging) + "\n" + power.pct + "%"
        color: Theme.colYellow
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSize
        font.bold: true
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
    }
}
