pragma Singleton

//import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

import "../Configs/"

Singleton {
    id: root

    property var loadedDesign: {}
    property ListModel listDesigns: ListModel{}
    property bool designsLoaded: false

    property var designs: ({
        "Dark Theme": Design_dark,
        "Light Theme": Design_light,
        "Orange Theme": Design_orange
    })
    function setDesign(design: string): void {
        for (var i = 0; i < listDesigns.count; i++) {
            var _design = listDesigns.get(i);
            if(_design.id == design) {
                loadedDesign = _design
            }
        }
    }
    function readDesigns(): void {
        if(designsLoaded) return
        var xhr = new XMLHttpRequest()
        xhr.open("GET", Qt.resolvedUrl("../Configs/dark.theme"), false)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var data = JSON.parse(xhr.responseText)
                for (var i = 0; i < data.length; ++i) {
                    listDesigns.append(data[i])
                }
                setDesign("dark");
                designsLoaded = true
            }
        }
        xhr.send()
    }
    Component.onCompleted: {
        readDesigns();
    } 
}