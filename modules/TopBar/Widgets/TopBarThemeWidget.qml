import Quickshell
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import "../../../singletons/"

Rectangle {
  id: rootTheme
  
  //opacity: Config.loadedTheme.main.opacity
  color: "transparent"
  //border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius

  implicitHeight: 20
  implicitWidth: 20  

  Text {
    id: rootThemeText
    anchors.centerIn: parent
    text: "󰔎"
    color: Config.loadedTheme.font.color
  }

  MouseArea {
    id: themeControl
    anchors.fill: parent
    hoverEnabled: true
    onEntered: function() {
      PopupHandler.show(popupThemeMenu, rootTheme)
      hideThemePopup.stop()
      childVisible = !childVisible
    }
    onExited: function() {
      hideThemePopup.start()
    }
  }

  property bool childVisible: false

  PopupWindow {
    id: popupThemeMenu
    visible: false
    anchor.window: topBar 
    color: "transparent"

    anchor.rect.x: parentWindow.width 
    anchor.rect.y: parentWindow.height

    implicitWidth: 200  
    implicitHeight: Config.listThemes.count * 50

    Rectangle {
      id: popupThemeMenuRect

      anchors.fill: parent

      //opacity: Config.loadedTheme.main.opacity
      opacity: 0
      color: "#222222AA" // Glass Look
      //color: Config.loadedTheme.main.background
      border.color: Config.loadedTheme.main.bordercolor
      radius: Config.loadedTheme.main.radius

      // blur und schatten
      layer.enabled: true
      layer.effect: DropShadow {
        radius: 16
        samples: 24
        color: "#00000066"
        //horizontalOffest: 0
        verticalOffset: 50
        source: FastBlur {
          radius: 16
          source: popupThemeMenuRect
        }
      }
      
      Column {
        anchors {
          topMargin: 15 
          left: parent.left
          fill: parent
        }
        spacing: 10 

        Repeater {
          id: themeControlEntriesElements
          model: Config.listThemes          
          Rectangle {
            id: themeElement
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
                hideThemePopup.stop()
                themeElement.color = Config.loadedTheme.main.backgroundMarked
              }
              onExited: function() {
                hideThemePopup.start()
                themeElement.color = Config.loadedTheme.main.background
              }
              acceptedButtons: Qt.LeftButton
              onClicked: function() {
                Config.setTheme(modelData.id)
                Config.appSettings.currentThemeId = modelData.id
                for (var i = 0; i < themeControlEntriesElements.count; i++) {
                  var item = themeControlEntriesElements.itemAt(i)
                  item.color = Config.loadedTheme.main.background
                }                
                ColorHelper.reload()
                popupThemeMenu.visible = false
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
      Behavior on opacity {
        NumberAnimation {
          duration: 500
          easing.type: Easing.InOutQuad
          //easing.type: Easing.BezierSpline
          //easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
        }
      }
      Behavior on y {
        NumberAnimation {
          duration: 450
          easing.type: Easing.OutCubic
        }
      }
      states: [
        State {
          name: "visible"
          when: rootTheme.childVisible
          PropertyChanges {
            target: popupThemeMenuRect
            opacity: 1.0
            y: rootTheme.height / 2 - height / 2
          }
        },
        State {
          name: "hidden"
          when: !rootTheme.childVisible
          PropertyChanges { target: popupThemeMenuRect; opacity: 0; }
        }
      ]
    }
  }

  Component.onCompleted: function() {
    ColorHelper.addElement(rootTheme)
  }

  Timer {
    id: hideThemePopup
    interval: 1000
    onTriggered: {
      //popupThemeMenuRect.opacity = 0
      //popupThemeMenu.visible = false
      //rootTheme.color = Config.loadedTheme.main.background
      rootTheme.childVisible = false
      rootTheme.color = "transparent"
    }
  }
}