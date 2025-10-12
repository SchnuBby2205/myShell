pragma Singleton

//import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

import "../Configs/"

Singleton {
    id: root

    property string loadedDesign: "Dark Theme"
    property ListModel listDesigns: ListModel{}

    property var designs: ({
        "Dark Theme": Design_dark,
        "Light Theme": Design_light
    })

    function setDesign(design: string): void {
        loadedDesign = design
    }

    Component.onCompleted: {
        for(var d in designs) {
            root.listDesigns.append({name: d, suffix: d})
        }
    }
/*
    function getDesign (): JsonObject {
        console.log(Config.designs[Config.loadedDesign].main.background)
        return Config.designs[Config.loadedDesign];
    }
*/    
/*
    property alias appearance: adapter.appearance
    ElapsedTimer {
        id: timer
    }
    FileView {
        // Muss für echt system geändert werden.
        path: `../Configs/shell.json`
        watchChanges: true
        onFileChanged: {
            timer.restart();
            reload();
        }
        onLoaded: {
            try {
                JSON.parse(text());
                if (adapter.utilities.toasts.configLoaded)
                    Toaster.toast(qsTr("Config loaded"), qsTr("Config loaded in %1ms").arg(timer.elapsedMs()), "rule_settings");
            } catch (e) {
                Toaster.toast(qsTr("Failed to load config"), e.message, "settings_alert", Toast.Error);
            }
        }
        onLoadFailed: err => {
            if (err !== FileViewError.FileNotFound)
                Toaster.toast(qsTr("Failed to read config file"), FileViewError.toString(err), "settings_alert", Toast.Warning);
        }
        onSaveFailed: err => Toaster.toast(qsTr("Failed to save config"), FileViewError.toString(err), "settings_alert", Toast.Error)

        JsonAdapter {
            id: adapter

            property AppearanceConfig appearance: AppearanceConfig {}
        }
    }
    */
}