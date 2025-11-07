import Quickshell.Io
import Quickshell
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects


import "../../../singletons/"

Rectangle {
  id: rootPower
  
  //opacity: Config.loadedTheme.main.opacity
  color: "transparent"
  //border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius

  implicitHeight: 20
  implicitWidth: 20  

  property alias rootPower: rootPower

  Text {
    id: rootPowerText
    anchors.centerIn: parent
    text: "󰤆"
    //color: Config.loadedTheme.font.color
    color: Config.colors.primary_container
  }

  MouseArea {
    id: powerControl
    anchors.fill: parent
    hoverEnabled: true
    onEntered: function() {
      //PopupHandler.show(popupPowerMenu, rootPower)
      popupPowerMenu.visible = true
      //flyIn.running = true
      hidePowerPopup.stop()
      //childVisible = !childVisible
      childVisible = true
    }
    onExited: function() {
      hidePowerPopup.start()
    }
  }
  property bool childVisible: false
  PopupWindow {
    id: popupPowerMenu
    anchor.window: topBar
    
    // Nutze ein eigenes Property zur Animation:
    property real popupOffset: 5

    anchor.rect.x: topBar.width
    anchor.rect.y: topBar.height + popupOffset
    //anchor.rect.y: 0
    implicitWidth: 200
    implicitHeight: Config.listThemes.count * 50
    color: "transparent"
    Rectangle {
      //border.color: "#fa0808ff"

      scale: 0
      id: themePopupContainer
      anchors.fill: parent
      opacity: 0
      radius: 25
      //color: "#222222AA"
      //color: "white"
      //color: Config.colors.primary_container
      color: "transparent"
      Column {
        anchors {
          topMargin: 15 
          left: parent.left
          fill: parent
        }
        spacing: 10 

        Repeater {
          id: themeControlEntriesElements
          model: ListModel {
            ListElement {
              name: "󰜉"
              command: "reboot"
            }
            ListElement {
              name: "󰐥"
              command: "shutdown"
            }
          }
          Rectangle {
            id: themeElement
            required property var modelData

            opacity: Config.loadedTheme.main.opacity
            //color: Config.loadedTheme.main.background
            color: Config.colors.primary_container
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
                themeElement.color = Config.colors.primary_container
              }
              onExited: function() {
                //hideThemePopup.start()
                hidePowerPopup.start()
                themeElement.color = Config.colors.primary_container
              }
              acceptedButtons: Qt.LeftButton
              onClicked: function() {
                modelData.command == "reboot" ? restartProc.running = true : shutdownProc.running = true
                popupPowerMenu.visible = false
              }
            }

            Text {
              id: themeElementText
              anchors.centerIn: parent
              text: modelData.name
              color: Config.loadedTheme.font.color
            }
      //color: "white"
      // blur und schatten
      layer.enabled: true
      layer.effect: DropShadow {
        radius: 10
        samples: 25
        color: "#fa0808ff"
        //horizontalOffest: 0
        verticalOffset: 0
        source: FastBlur {
          radius: 16
          source: themeControlEntriesElements
        }
      }
      
          }
        }
      }
      Behavior on opacity {
        ParallelAnimation {
          NumberAnimation {
            duration: 500
            //easing.type: Easing.InOutQuad
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
          }
        }
      }
      Behavior on scale {
        NumberAnimation {
          duration: 500
          //easing.type: Easing.InOutQuad
          easing.type: Easing.BezierSpline
          easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
        }
      }
      states: [
        State {
          name: "visible"
          when: rootPower.childVisible
          PropertyChanges {
            target: themePopupContainer
            opacity: 1.0
            scale: 1
          }
        },
        State {
          name: "hidden"
          when: !rootPower.childVisible
          PropertyChanges {
            target: themePopupContainer
            opacity: 0
            scale: 0
          }
        }
      ]
    }
  } //PopupWindow


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
    interval: 250
    onTriggered: {
      //popupPowerMenu.visible = false
      //flyOut.running = true
      childVisible = false
      //rootPower.color = Config.loadedTheme.main.background
      rootPower.color = "transparent"
    }
  }

}