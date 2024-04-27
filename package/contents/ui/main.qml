import QtQuick 6.0
import org.kde.kwin 3.0

Item {
    id: qmlBase

    property var nextCreatedHandler: undefined;

    ShortcutHandler {
        id: shortcutDumpWindowProps
        name: "KwinInfoDumpWindowProps"
        text: "Dump active window properties"
        sequence: "Meta+I"
        onActivated: {
            dumpProps(getWindowProperties(Workspace.activeWindow));
        }
    }

    ShortcutHandler {
        id: shortcutDumpWindowJson
        name: "KwinInfoDumpWindowJson"
        text: "Dump active window JSON"
        sequence: "Meta+Shift+I"
        onActivated: {
            dumpProps(getWindowJson(Workspace.activeWindow));
        }
    }

    ShortcutHandler {
        id: shortcutDumpWindowPropsCreated
        name: "KwinInfoDumpWindowPropsCreated"
        text: "Dump next created window properties"
        sequence: "Meta+O"
        onActivated: {
            setNextCreatedHandler(getWindowProperties);
        }
    }

    ShortcutHandler {
        id: shortcutDumpWindowJsonCreated
        name: "KwinInfoDumpWindowJsonCreated"
        text: "Dump next created window JSON"
        sequence: "Meta+Shift+O"
        onActivated: {
            setNextCreatedHandler(getWindowJson);
        }
    }

    function setNextCreatedHandler(getProps) {
        if (nextCreatedHandler !== undefined) {
            cleanupNextCreatedHandler();
        }

        nextCreatedHandler = (window) => {
            dumpProps(getProps(window));
            cleanupNextCreatedHandler();
        };
        Workspace.windowAdded.connect(nextCreatedHandler);
    }

    function cleanupNextCreatedHandler() {
        Workspace.windowAdded.disconnect(nextCreatedHandler);
        nextCreatedHandler = undefined;
    }

    function dumpProps(props) {
        logProps(props);
        setClipboard(props);
    }

    function getWindowProperties(window) {
        let propsString = "";
        for (const prop in window) {
            propsString += prop + ": " + window[prop] + "\n";
        }
        return propsString;
    }

    function getWindowJson(window) {
        return JSON.stringify(window, undefined, 2) + "\n";
    }
    
    function logProps(props) {
        console.log("kwin_info_dump\n" + props);
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
