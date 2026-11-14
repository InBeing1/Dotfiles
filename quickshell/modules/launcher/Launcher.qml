import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import qs.theme

PanelWindow {
    id: launcher

    visible: false
    color: "transparent"
    implicitWidth: 500
    implicitHeight: 400

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    IpcHandler {
        target: "launcher"
        function toggle(): void { launcher.visible = !launcher.visible }
    }

    property string query: ""

    readonly property var results: {
        const q = query.trim().toLowerCase();
        const all = DesktopEntries.applications.values.filter(e => !e.noDisplay);
        const hits = q === "" ? all : all.filter(e =>
        e.name.toLowerCase().includes(q) ||
        (e.genericName || "").toLowerCase().includes(q));
        return hits.sort((a, b) => a.name.localeCompare(b.name));
    }

    function launch(entry) {
        entry.execute();
        launcher.visible = false;
    }

    onVisibleChanged: {
        if (visible) {
            input.text = "";
            list.currentIndex = 0;
            input.forceActiveFocus();
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.colBg
        border.width: 1
        border.color: Theme.colBd

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 36
                color: Theme.colBd

                TextInput {
                    id: input
                    anchors.fill: parent
                    anchors.margins: 8
                    verticalAlignment: TextInput.AlignVCenter
                    color: Theme.colPri
                    font.pixelSize: Theme.fontSize
                    onTextChanged: { launcher.query = text; list.currentIndex = 0 }

                    Keys.onEscapePressed: launcher.visible = false
                    Keys.onDownPressed: list.incrementCurrentIndex()
                    Keys.onUpPressed: list.decrementCurrentIndex()
                    Keys.onReturnPressed: {
                        if (launcher.results.length > 0)
                        launcher.launch(launcher.results[list.currentIndex])
                    }
                }
            }

            ListView {
                id: list
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: launcher.results
                highlightMoveDuration: 0

                delegate: Rectangle {
                    required property var modelData
                    required property int index
                    width: ListView.view.width
                    height: 32
                    color: ListView.isCurrentItem ? Theme.colBd : "transparent"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: modelData.name
                        color: Theme.colPri
                        font.pixelSize: Theme.fontSize
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: launcher.launch(modelData)
                    }
                }
            }
        }
    }
}
