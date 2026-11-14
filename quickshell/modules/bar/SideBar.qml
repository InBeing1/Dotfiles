import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.theme
import "components"

PanelWindow {
    id: bar

    implicitWidth: 36
    anchors.top: true
    anchors.left: true
    anchors.bottom: true
    color: Theme.colBg

    // Memory
    ColumnLayout {
        id: leftPanel
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5

        Workspaces{ Layout.alignment: Qt.AlignHCenter }
    }

    ColumnLayout {
        id: centerPanel
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        rotation: -90

        ActiveWindow{ Layout.alignment: Qt.AlignHCenter }

    }

    ColumnLayout {
        id: rightPanel
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5

        Wifi{ Layout.alignment: Qt.AlignHCenter }

        Temp{ Layout.alignment: Qt.AlignHCenter }

        CPU{ Layout.alignment: Qt.AlignHCenter }

        Memory{ Layout.alignment: Qt.AlignHCenter }

        Clock{ Layout.alignment: Qt.AlignHCenter }

        Power{ Layout.alignment: Qt.AlignHCenter }
    }
}
