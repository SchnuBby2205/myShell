pragma Singleton

//import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property var loadedTheme: {}
    property ListModel listThemes: ListModel{}
    property bool themesLoaded: false
    
    //property string currentWallpaper: ""

    function setTheme(design: string): void {
        for (var i = 0; i < listThemes.count; i++) {
            var _design = listThemes.get(i);
            if(_design.id == design) {
                loadedTheme = _design
            }
        }
    }
    Component.onCompleted: {
        JsonReader.parseFile("../Configs/themes.json", (data) => {
            for (var i = 0; i < data.length; ++i) {
                listThemes.append(data[i])
            }        
            themesLoaded = true
        });
        JsonReader.parseFile("../Configs/config.json", (data) => {
            Wallpaper.currentWallpaperFileName = data[0].app.currentWallpaper;
            setTheme(data[0].app.currentTheme);
        });
    } 
}