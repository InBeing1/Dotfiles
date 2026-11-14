import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.theme
import "components"

PanelWindow {
    id: bar

    implicitHeight: 25
    anchors.top: true
    anchors.left: true
    anchors.right: true
    color: Theme.colBg

    // Memory
    RowLayout {
        id: leftPanel
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Workspaces{ Layout.alignment: Qt.AlignVCenter }
    }

    RowLayout {
        id: centerPanel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        ActiveWindow{ Layout.alignment: Qt.AlignVCenter }

    }

    RowLayout {
        id: rightPanel
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 5

        Wifi{ Layout.alignment: Qt.AlignVCenter }

        Temp{ Layout.alignment: Qt.AlignVCenter }

        CPU{ Layout.alignment: Qt.AlignVCenter }

        Memory{ Layout.alignment: Qt.AlignVCenter }

        Clock{ Layout.alignment: Qt.AlignVCenter }

        Power{ Layout.alignment: Qt.AlignVCenter }
    }
}
