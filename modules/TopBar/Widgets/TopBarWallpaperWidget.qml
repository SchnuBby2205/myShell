import Quickshell
import Quickshell.Io
import QtQuick

import "../../../singletons/"

Rectangle {
  color: "transparent"
  implicitHeight: 20
  implicitWidth: 20
  MouseArea {
    id: wallpaperControl
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    onClicked: function(mouse) {
      if(mouse.button == Qt.LeftButton) {
        Wallpaper.setRandomWallpaper()
      } 
      if(mouse.button == Qt.RightButton) {
        Wallpaper.togglePicker()
      }
    }
    onEntered: function() {
      popupWallpaperMenu.visible = true
      hideTimer.start()
    }
  }
  Text {
    id: wallpaperIcon 
    color: Config.loadedDesign.font.color 
    text: "󱍤"
  }
  //Process {
    //command: ["systemctl poweroff"]
  //}
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
      color: Config.loadedDesign.main.background
      border.color: Config.loadedDesign.main.bordercolor
      radius: Config.loadedDesign.main.radius
      opacity: Config.loadedDesign.main.opacity 

      MouseArea {              
        id: mouseOne
        hoverEnabled: true
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function(mouse) {
          if(mouse.button == Qt.RightButton) {
            //Quickshell.execDetached("pavucontrol")
            console.log("Right Clicked")
          }
        }
        onEntered: {
          hideTimer.stop()
        }
        onExited: {
          hideTimer.start()
        }
      }
      Text {
        anchors.centerIn: parent
        text: Wallpaper.currentWallpaperFileName 
        color: Config.loadedDesign.font.color
      }
    }
  }
  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: {
      popupWallpaperMenu.visible = false
    }
  }
}
