import QtQuick 6.0
import org.kde.kwin 3.0

Item {
    id: qmlBase

    ShortcutHandler {
        id: shortcutDumpWindowProps
        name: "KwinInfoDumpWindowProps"
        text: "Dump window properties"
        sequence: "Meta+I"
        onActivated: {
            const props = getWindowProperties();
            console.log(props);
            setClipboard(props);
        }
    }

    ShortcutHandler {
        id: shortcutDumpWindowJson
        name: "KwinInfoDumpWindowJson"
        text: "Dump window JSON"
        sequence: "Meta+Shift+I"
        onActivated: {
            const props = getWindowJson();
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

    function getWindowJson() {
        return JSON.stringify(Workspace.activeWindow, undefined, 2) + "\n";
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
