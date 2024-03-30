import QtQuick 6.0
import org.kde.kwin 3.0

Item {
    id: qmlBase

    ShortcutHandler {
        id: shortcutDumpWindow
        name: "KwinInfoDumpWindow"
        text: "Dump window information"
        sequence: "Meta+Ctrl+F1"
        onActivated: {
            for (const property in Workspace.activeWindow) {
                console.log(property, Workspace.activeWindow[property]);
            }
        }
    }
}
