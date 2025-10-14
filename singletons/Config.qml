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

    function setTheme(design: string): void {
        for (var i = 0; i < listThemes.count; i++) {
            var _design = listThemes.get(i);
            if(_design.id == design) {
                loadedTheme = _design
            }
        }
    }
    function readJson(filePath: string): void {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", Qt.resolvedUrl(filePath), false)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var data = JSON.parse(xhr.responseText)
                for (var i = 0; i < data.length; ++i) {
                    listThemes.append(data[i])
                }
                setTheme("dark");
                themesLoaded = true
            }
        }
        xhr.send()
    }
    Component.onCompleted: {
        readJson("../Configs/themes.json");
        //readJson("../Configs/config.json")
    } 
}