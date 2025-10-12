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
    color: Config.designs[Config.loadedDesign].font.color 
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

    width: 200  
    height: 30
    Rectangle {
      anchors.fill: parent
      color: Config.designs[Config.loadedDesign].main.background
      border.color: Config.designs[Config.loadedDesign].main.bordercolor
      radius: Config.designs[Config.loadedDesign].main.radius
      opacity: Config.designs[Config.loadedDesign].main.opacity 

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
        color: Config.designs[Config.loadedDesign].font.color
      }
    }
/*
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
              name: "reboot"
              icon: "../../../Assets/reboot.png"
            }
            ListElement {
              name: "shutdown"
              icon: "../../../Assets/power.png"
            }
          }
          Rectangle {
            required property var modelData
            color: Config.designs[Config.loadedDesign].main.background
            border.color: Config.designs[Config.loadedDesign].main.bordercolor
            radius: Config.designs[Config.loadedDesign].main.radius
            opacity: Config.designs[Config.loadedDesign].main.opacity 
            implicitHeight: 30
            implicitWidth: 180 
            anchors.horizontalCenter: parent.horizontalCenter
            Image {
              height: 20
              width: 20
              source: modelData.icon
              anchors.centerIn: parent
            }
          } 
        }
      }
            */ 

  }
  Timer {
    id: hideTimer
    interval: 1000
    onTriggered: {
      popupWallpaperMenu.visible = false
    }
  }
}
