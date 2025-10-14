pragma Singleton

//import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick
import QtCore

Singleton {
    id: root
    property var loadedTheme: {}
    property ListModel listThemes: ListModel{}
    property bool themesLoaded: false

    property alias appSettings: appSettings
    
    Settings {
        id: appSettings        
        property string currentThemeId: ""
        property string currentWallpaper: ""
    }
    function setTheme(design: string): void {
        for (var i = 0; i < listThemes.count; i++) {
            var _design = listThemes.get(i);
            if(_design.id == design) {
                loadedTheme = _design
            }
        }
    }
    Component.onCompleted: {
        Qt.application.organization = "myShell"
        Qt.application.domain = "https://github.com/SchnuBby2205"
        Qt.application.name = "myShell"

        JsonHelper.parseFile("../Configs/themes.json", (data) => {
            for (var i = 0; i < data.length; ++i) {
                listThemes.append(data[i])
            }        
            themesLoaded = true
        });
        appSettings.currentThemeId ? setTheme(appSettings.currentThemeId) : setTheme("dark")
    } 
    Connections {
        target: root
        function onLoadedThemeChanged() {
            appSettings.currentThemeId = loadedTheme.id
        }
    }
}