import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: root

    visible: false
    color: "transparent"
    implicitWidth: 500
    implicitHeight: 400
    // no anchors: the window is centered on screen

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

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
        root.visible = false;
    }

    onVisibleChanged: {
        if (visible) {
            input.text = "";
            list.currentIndex = 0;
            input.forceActiveFocus();
        }
    }

    // toggled from a keybind: qs ipc call launcher toggle
    IpcHandler {
        target: "launcher"
        function toggle(): void { root.visible = !root.visible }
    }

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: "#1e1e2e"
        border.width: 1
        border.color: "#45475a"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 8

            Rectangle {
                Layout.fillWidth: true
                implicitHeight: 36
                radius: 8
                color: "#313244"

                TextInput {
                    id: input
                    anchors.fill: parent
                    anchors.margins: 8
                    verticalAlignment: TextInput.AlignVCenter
                    color: "white"
                    font.pixelSize: 15
                    onTextChanged: { root.query = text; list.currentIndex = 0 }

                    Keys.onEscapePressed: root.visible = false
                    Keys.onDownPressed: list.incrementCurrentIndex()
                    Keys.onUpPressed: list.decrementCurrentIndex()
                    Keys.onReturnPressed: {
                        if (root.results.length > 0)
                            root.launch(root.results[list.currentIndex])
                    }
                }
            }

            ListView {
                id: list
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: root.results
                highlightMoveDuration: 0

                delegate: Rectangle {
                    required property var modelData
                    required property int index
                    width: ListView.view.width
                    height: 32
                    radius: 6
                    color: ListView.isCurrentItem ? "#45475a" : "transparent"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        text: modelData.name
                        color: "white"
                        font.pixelSize: 14
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.launch(modelData)
                    }
                }
            }
        }
    }
}
