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
      popupDesignMenu.visible = true
      hideDesignTimer.start()
    }
  }
  Text {
    id: designIcon 
    color: Config.designs[Config.loadedDesign].font.color 
    text: "X"
  }
  PopupWindow {
    id: popupDesignMenu
    visible: false
    anchor.window: topBar 
    color: "transparent"

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height

    width: 200  
    height: 100
    Rectangle {
      anchors.fill: parent
      color: Config.designs[Config.loadedDesign].main.background
      border.color: Config.designs[Config.loadedDesign].main.bordercolor
      radius: Config.designs[Config.loadedDesign].main.radius
      opacity: Config.designs[Config.loadedDesign].main.opacity 

      MouseArea {              
        id: mouseDesignOne
        hoverEnabled: true
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function(mouse) {
          if(mouse.button == Qt.RightButton) {
            //Config.setDesign("dark")
          }
          if(mouse.button == Qt.LeftButton) {
            //Config.setDesign("light")
          }
        }
        onEntered: {
          hideDesignTimer.stop()
        }
        onExited: {
          hideDesignTimer.start()
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
          model: ListModel {
            ListElement {
              name: "dark"
              icon: "dark"
            }
            ListElement {
              name: "light"
              icon: "light"
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
            MouseArea {
              id: mouseOne
              anchors.fill: parent
              acceptedButtons: Qt.LeftButton | Qt.RightButton
              onClicked: function(mouse) {
                //if(mouse.button == Qt.RightButton) {
                  //Config.setDesign("dark")
                //}
                if(mouse.button == Qt.LeftButton) {
                  Config.setDesign(modelData.icon)
                }                
              }
            }
            Text {
              anchors.centerIn: parent
              text: modelData.icon
              color: Config.designs[Config.loadedDesign].font.color
            }
          }        
        }
      }
    }
  }
  Timer {
    id: hideDesignTimer
    interval: 1000
    onTriggered: {
      popupDesignMenu.visible = false
    }
  }
}

