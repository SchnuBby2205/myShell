import Quickshell
import Quickshell.Io
import QtQuick

import "../../../singletons/"

Rectangle {
  color: "transparent"
  implicitHeight: 20
  implicitWidth: 20
  MouseArea {
    id: designControl
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    onClicked: function(mouse) {
      if(mouse.button == Qt.LeftButton) {
        //Wallpaper.setRandomWallpaper()
      } 
      if(mouse.button == Qt.RightButton) {
        //Wallpaper.togglePickeyr()
      }
    }
    onEntered: function() {
      popupThemeMenu.visible = true
      hideThemeTimer.start()
    }
  }
  Text {
    id: designIcon 
    color: Config.loadedTheme.font.color 
    text: "X"
  }
  PopupWindow {
    id: popupThemeMenu
    visible: false
    anchor.window: topBar 
    color: "transparent"

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height

    implicitWidth: 200  
    implicitHeight: 400
    Rectangle {
      anchors.fill: parent
      color: Config.loadedTheme.main.background
      border.color: Config.loadedTheme.main.bordercolor
      radius: Config.loadedTheme.main.radius
      opacity: Config.loadedTheme.main.opacity 

      MouseArea {              
        id: mouseThemeOne
        hoverEnabled: true
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function(mouse) {
          if(mouse.button == Qt.RightButton) {
            //Config.setTheme("dark")
          }
          if(mouse.button == Qt.LeftButton) {
            //Config.setTheme("light")
          }
        }
        onEntered: {
          hideThemeTimer.stop()
        }
        onExited: {
          hideThemeTimer.start()
        }
      }
      Column {
        anchors {
          topMargin: 15 
          left: parent.left
          fill: parent
          //verticalCenter: parent.verticalCenter
        }
        spacing: 10 

        Repeater {
          id: designRepeater
          model: Config.listThemes
          Rectangle {
            required property var modelData
            color: Config.loadedTheme.main.background
            border.color: Config.loadedTheme.main.bordercolor
            radius: Config.loadedTheme.main.radius
            opacity: Config.loadedTheme.main.opacity 
            implicitHeight: 30
            implicitWidth: 180 
            anchors.horizontalCenter: parent.horizontalCenter
            MouseArea {
              id: mouseOne
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton | Qt.RightButton
              onClicked: function(mouse) {
                //if(mouse.button == Qt.RightButton) {
                  //Config.setTheme("dark")
                //}
                if(mouse.button == Qt.LeftButton) {
                  Config.setTheme(modelData.id)
                }                
              }
            }
            Text {
              anchors.centerIn: parent
              text: modelData.name
              color: Config.loadedTheme.font.color
            }
          }        
        }
      }
    }
  }
  Timer {
    id: hideThemeTimer
    interval: 1000
    onTriggered: {
      popupThemeMenu.visible = false
    }
  }
}

