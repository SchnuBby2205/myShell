import Quickshell
import QtQuick

import "../../../singletons/"

Rectangle {
  id: rootWallpaper
  
  //opacity: Config.loadedTheme.main.opacity
  color: "transparent"
  //border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius

  implicitHeight: 20
  implicitWidth: 20  

  property alias rootWallpaper: rootWallpaper

  visible: true

  Text {
    id: rootWallpaperText
    anchors.centerIn: parent
    text: "󰸉"
    //color: Config.loadedTheme.font.color
    color: Config.colors.colors.color10
  }

  MouseArea {
    id: wallpaperControl
    anchors.fill: parent
    //hoverEnabled: true
    /*
    onEntered: function() {
      PopupHandler.show(popupWallpaperMenu, rootWallpaper)
      flyIn.running = true
      hideWallpaperPopup.stop()
    }
    */
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
    //anchor.rect.y: parentWindow.height
    anchor.rect.y: 0

    implicitWidth: 200  
    implicitHeight: 30

    Rectangle {
      id: popupWallpaperMenuRect
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
      
      ParallelAnimation {
        id: flyIn
        //running: true
        NumberAnimation { target: popupWallpaperMenu; property: "anchor.rect.y"; to: 35; duration: 100 }
        NumberAnimation { target: popupWallpaperMenuRect; property: "opacity"; to: Config.loadedTheme.main.opacity; duration: 100 }
      }
      SequentialAnimation {
        id: flyOut
        ParallelAnimation {
          //running: true
          NumberAnimation { target: popupWallpaperMenu; property: "anchor.rect.y"; to: 0; duration: 100 }
          NumberAnimation { target: popupWallpaperMenuRect; property: "opacity"; to: 0; duration: 100 }
        }
        PropertyAction {target: popupWallpaperMenu; property: "visible"; value: false}
      }
      

    }
  }

  Timer {
    id: hideWallpaperPopup
    interval: 1000
    onTriggered: {
      //popupWallpaperMenu.visible = false
      flyOut.running = true
      rootWallpaper.color = "transparent"
    }
  }
  
  Component.onCompleted: {
    Wallpaper.cacheWallpapers()
    ColorHelper.addElement(rootWallpaper)
  }

}