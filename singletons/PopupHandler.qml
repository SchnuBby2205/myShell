pragma Singleton
import QtQuick

QtObject {
    property var currentPopup: null
    property var currentControl: null
    function show(popup, control) {
        if (currentPopup && currentPopup !== popup) {
            currentPopup.visible = false
        }
        if(currentControl && currentControl !== control) {
            currentControl.color = Config.loadedTheme.main.background
        }
        currentPopup = popup
        popup.visible = true
        currentControl = control
        //control.color = Config.loadedTheme.main.backgroundMarked
    }
    function hideCurrent() {
        if (currentPopup) {
            currentPopup.visible = false
            currentPopup = null
        }
    }
}