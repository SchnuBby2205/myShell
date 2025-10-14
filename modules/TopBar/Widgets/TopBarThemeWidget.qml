import Quickshell
import QtQuick

import "../../../singletons/"

Rectangle {
  id: rootTheme
  
  opacity: Config.loadedTheme.main.opacity
  color: Config.loadedTheme.main.background
  border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius

  implicitHeight: 20
  implicitWidth: 20  

  Text {
    id: rootThemeText
    anchors.centerIn: parent
    text: "T"
    color: Config.loadedTheme.font.color
  }

  MouseArea {
    id: themeControl
    anchors.fill: parent
    hoverEnabled: true
    onEntered: function() {
      PopupHandler.show(popupThemeMenu, rootTheme)
      hideThemePopup.stop()
    }
    onExited: function() {
      hideThemePopup.start()
    }
  }

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
                for (var i = 0; i < themeControlEntriesElements.count; i++) {
                  var item = themeControlEntriesElements.itemAt(i)
                  item.color = Config.loadedTheme.main.background
                }
                rootTheme.color = Config.loadedTheme.main.backgroundMarked
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

  Timer {
    id: hideThemePopup
    interval: 1000
    onTriggered: {
      popupThemeMenu.visible = false
      rootTheme.color = Config.loadedTheme.main.background
    }
  }
}