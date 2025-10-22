import Quickshell
import QtQuick

import "../../../singletons/"

Rectangle {
  id: rootTheme
  
  //opacity: Config.loadedTheme.main.opacity
  color: Config.loadedTheme.main.background
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
      //popupThemeMenuRect.opacity = 1
      flyIn.running = true
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
    //anchor.rect.y: parentWindow.height
    anchor.rect.y: 0

    implicitWidth: 200  
    implicitHeight: Config.listThemes.count * 50

    Rectangle {
      id: popupThemeMenuRect

      anchors.fill: parent

      opacity: Config.loadedTheme.main.opacity
      //opacity: 0
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
      SequentialAnimation {
        id: flyIn
        //running: true
        //NumberAnimation { target: popupThemeMenu; property: "anchor.rect.x"; to: 50; duration: 1000 }
        NumberAnimation { target: popupThemeMenu; property: "anchor.rect.y"; to: 35; duration: 50 }
      }
      SequentialAnimation {
        id: flyOut
        //running: true
        //NumberAnimation { target: popupThemeMenu; property: "anchor.rect.x"; to: 50; duration: 1000 }
        NumberAnimation { target: popupThemeMenu; property: "anchor.rect.y"; to: 0; duration: 50 }
        NumberAnimation { target: popupThemeMenu; property: "visible"; to: 0; duration: 50 }
      }
      /*
      Behavior on opacity {
        PropertyAnimation {duration: 1000}
      }
      */
    }
  }

  Component.onCompleted: function() {
    ColorHelper.addElement(rootTheme)
  }

  Timer {
    id: hideThemePopup
    interval: 1000
    onTriggered: {
      //popupThemeMenu.visible = false
      //popupThemeMenuRect.opacity = 0
      flyOut.running = true
      rootTheme.color = Config.loadedTheme.main.background
    }
  }
}