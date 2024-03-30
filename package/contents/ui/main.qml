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
            const props = getWindowProperties();
            console.log(props);
            setClipboard(props);
        }
    }

    function getWindowProperties() {
        let propsString = "";
        for (const prop in Workspace.activeWindow) {
            propsString += prop + ": " + Workspace.activeWindow[prop] + "\n";
        }
        return propsString;
    }

    function setClipboard(text) {
        // Use TextEdit workaround to access the clipboard. Works only on X11.
        textEditClipboard.text = text;
        textEditClipboard.selectAll();
        textEditClipboard.cut();
    }

    TextEdit{
        id: textEditClipboard
        visible: false
    }
}
