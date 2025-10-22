pragma Singleton
import QtQuick

QtObject {
    property var elements: []
    function addElement(el) {
        elements.push(el)
    }
    function reload() {
        for (var e in elements) {
            //elements[e].color = Config.loadedTheme.main.background
            elements[e].color = "transparent"
        }
    }
}