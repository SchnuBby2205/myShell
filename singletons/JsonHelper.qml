pragma Singleton

//import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    function parseFile(filePath: string, callback): void {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", Qt.resolvedUrl(filePath), false)
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                var data = JSON.parse(xhr.responseText);
                callback(data)
            }
        }
        xhr.send()
    }
}