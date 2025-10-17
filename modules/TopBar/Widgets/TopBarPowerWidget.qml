import Quickshell
import Quickshell.Io
import QtQuick

import "../../../singletons/"

Rectangle {
  id: rootPower
  
  opacity: Config.loadedTheme.main.opacity
  color: Config.loadedTheme.main.background
  border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius

  implicitHeight: 20
  implicitWidth: 20  

  property alias rootPower: rootPower

  Text {
    id: rootPowerText
    anchors.centerIn: parent
    text: "P"
    color: Config.loadedTheme.font.color
  }

  MouseArea {
    id: powerControl
    anchors.fill: parent
    hoverEnabled: true
    onEntered: function() {
      PopupHandler.show(popupPowerMenu, rootPower)
      hidePowerPopup.stop()
    }
    onExited: function() {
      hidePowerPopup.start()
    }
  }

  PopupWindow {
    id: popupPowerMenu
    visible: false
    anchor.window: topBar 
    color: "transparent"

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height

    implicitWidth: 200  
    implicitHeight: 100

    Rectangle {
      anchors.fill: parent

      opacity: Config.loadedTheme.main.opacity
      color: Config.loadedTheme.main.background
      border.color: Config.loadedTheme.main.bordercolor
      radius: Config.loadedTheme.main.radius
      
      Column {
        anchors {
          topMargin: 15 
          left: parent.left
          fill: parent
        }
        spacing: 10 

        Repeater {
          id: powerControlEntriesElements
          model: ListModel {
            ListElement {
              name: "Reboot"
              command: "reboot"
            }
            ListElement {
              name: "Shutdown"
              command: "shutdown"
            }
          }
          Rectangle {
            id: powerElement
            required property var modelData

            opacity: Config.loadedTheme.main.opacity
            color: Config.loadedTheme.main.background
            border.color: Config.loadedTheme.main.bordercolor
            radius: Config.loadedTheme.main.radius

            implicitHeight: 30
            implicitWidth: 180 
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
              anchors.fill: parent
              hoverEnabled: true
              onEntered: function() {
                hidePowerPopup.stop()
                powerElement.color = Config.loadedTheme.main.backgroundMarked
              }
              onExited: function() {
                hidePowerPopup.start()
                powerElement.color = Config.loadedTheme.main.background
              }
              acceptedButtons: Qt.LeftButton
              onClicked: function() {
                modelData.command == "reboot" ? restartProc.running = true : shutdownProc.running = true
              }
            }

            Text {
              id: themeElementText
              anchors.centerIn: parent
              text: modelData.name
              color: Config.loadedTheme.font.color
            }
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

  Component.onCompleted: function() {
    ColorHelper.addElement(rootPower)
  }

  Timer {
    id: hidePowerPopup
    interval: 1000
    onTriggered: {
      popupPowerMenu.visible = false
      rootPower.color = Config.loadedTheme.main.background
    }
  }

}