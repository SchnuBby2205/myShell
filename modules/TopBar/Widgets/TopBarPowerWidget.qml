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
    color: Design.font.color
    text: "󱍤"
  }
  PopupWindow {
    id: popupPowerMenu
    visible: false
    anchor.window: topBar 
    color: "transparent"

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height

    width: 200  
    height: 100 
    Rectangle {
      anchors.fill: parent
      color: Design.main.background
      border.color: Design.main.bordercolor
      radius: Design.main.radius
      opacity: Design.main.opacity 
      Column {
        anchors {
          topMargin: 15 
          left: parent.left
          fill: parent
          //verticalCenter: parent.verticalCenter
        }
        spacing: 10 
        Repeater {
          id: powerRepeater
          model: ListModel {
            ListElement {
              name: "REBOOT"
              command: "reboot"
            }
            ListElement {
              name: "SHUTDOWN"
              command: "poweroff" 
            }
          }
          Rectangle {
            required property var modelData
            color: Design.main.background
            border.color: Design.main.bordercolor
            radius: Design.main.radius
            opacity: Design.main.opacity 
            implicitHeight: 30
            implicitWidth: 180 
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
              id: mouseOne
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton | Qt.RightButton
              onClicked: function() {
                if(modelData.command == "reboot") restartProc.running = true
              }
            }
            Text {
              anchors.centerIn: parent
              text: modelData.name 
              color: Design.font.color 
            }
          } 
        }
      } 
    }
  }
  Process {
    id: shutdownProc
    command: ["systemctl", modelData.command]
  }
  Process {
    id: restartProc
    command: ["systemctl", "reboot"]
  }
}
