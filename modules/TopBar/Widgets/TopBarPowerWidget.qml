import Quickshell
import Quickshell.Io
import QtQuick

import "../../../singletons/"

Rectangle {
  color: "transparent"
  implicitHeight: 20
  implicitWidth: 20
  MouseArea {
    id: powerControl
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: function(mouse) {
      //Wallpaper.setRandomWallpaper()
      popupPowerMenu.visible = !popupPowerMenu.visible 
    }
  }
  Text {
    id: powerIcon 
    color: "white"
    text: "󱍤"
  }
  PopupWindow {
    id: popupPowerMenu
    visible: false
    anchor.window: topBar 
    color: "white"

    anchor.rect.x: parentWindow.width - (width / 2) - 20 
    anchor.rect.y: parentWindow.height

    width: 100  
    height: 50
    Column {
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
      spacing: 5
      Rectangle {
        color: "black"
        implicitHeight: 15 
        implicitWidth: 15 
        MouseArea {
          id: mouseOne
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onClicked: function(mouse) {
            restartProc.running = true
          }
        }
      }
      Rectangle {
        color: "black"
        implicitHeight: 15 
        implicitWidth: 15 
        MouseArea {
          id: mouseTwo
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onClicked: function(mouse) {
            //Wallpaper.setRandomWallpaper()
            shutdownProc.running = true
          }
        }
      }
    } 
  }
  Process {
    id: shutdownProc
    command: ["systemctl", "poweroff"]
  }
  Process {
    id: restartProc
    command: ["systemctl", "reboot"]
  }
}
