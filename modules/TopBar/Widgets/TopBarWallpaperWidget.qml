import Quickshell
import QtQuick

import "../../../singletons/"

Rectangle {
  id: rootWallpaper
  
  opacity: Config.loadedTheme.main.opacity
  color: Config.loadedTheme.main.background
  border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius

  implicitHeight: 20
  implicitWidth: 20  

  property alias rootWallpaper: rootWallpaper

  Text {
    id: rootWallpaperText
    anchors.centerIn: parent
    text: "W"
    color: Config.loadedTheme.font.color
  }

  MouseArea {
    id: wallpaperControl
    anchors.fill: parent
    hoverEnabled: true
    onEntered: function() {
      PopupHandler.show(popupWallpaperMenu, rootWallpaper)
      hideWallpaperPopup.stop()
    }
    onExited: function() {
      hideWallpaperPopup.start()
    }
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: function(mouse) {
      if(mouse.button == Qt.LeftButton) {Wallpaper.setRandomWallpaper()}
      if(mouse.button == Qt.RightButton) {Wallpaper.togglePicker()}
    }
  }

  PopupWindow {
    id: popupWallpaperMenu
    visible: false
    anchor.window: topBar 
    color: "transparent"

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height

    implicitWidth: 200  
    implicitHeight: 30

    Rectangle {
      anchors.fill: parent

      opacity: Config.loadedTheme.main.opacity
      color: Config.loadedTheme.main.background
      border.color: Config.loadedTheme.main.bordercolor
      radius: Config.loadedTheme.main.radius

      MouseArea {
        id: popupWallpaperCurrentWallpaper
        anchors.fill: parent
        hoverEnabled: true
        onEntered: function () {
          hideWallpaperPopup.stop();
        }
        onExited: function () {
          hideWallpaperPopup.start();
        }
      }

      Text {
        id: wallpaperName
        anchors.centerIn: parent
        color: Config.loadedTheme.font.color
        text: Config.appSettings.currentWallpaper
      }
    }
  }

  Timer {
    id: hideWallpaperPopup
    interval: 1000
    onTriggered: {
      popupWallpaperMenu.visible = false
      rootWallpaper.color = Config.loadedTheme.main.background
    }
  }
  
  Component.onCompleted: {
    Wallpaper.wallpapersReadProc.running = true
    ColorHelper.addElement(rootWallpaper)
  }

}