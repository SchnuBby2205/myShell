import Quickshell
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import "../../../singletons/"



//=========================================================================
Rectangle {
  id: themeRoot
  implicitHeight: 20
  implicitWidth: 20
  
  //opacity: Config.loadedTheme.main.opacity
  color: "transparent"
  //border.color: Config.loadedTheme.main.bordercolor
  radius: Config.loadedTheme.main.radius
  
  //radius: 25
  //color: "red"
  //border.color: "green"
  MouseArea {
    id: themeHover
    anchors.fill: parent
    onClicked: {
      PopupHandler.show(themePopup, themeRoot)
      //hideThemePopup.stop()
      childVisible = !childVisible
    }
  }

      //color: "white"
      // blur und schatten
      /*
      layer.enabled: true
      layer.effect: DropShadow {
        radius: 5
        samples: 24
        color: "#fa0808ff"
        //horizontalOffest: 0
        verticalOffset: 1
        source: FastBlur {
          radius: 10
          source: themeControlEntriesElements
        }
      }  
      */
      Text {
        anchors.centerIn: parent
        color: Config.loadedTheme.font.color 
        text: "󰔎"
      }

  property bool childVisible: false

  PopupWindow {
    id: themePopup
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
      border.color: "#fa0808ff"

      scale: 0
      id: themePopupContainer
      anchors.fill: parent
      opacity: 0
      radius: 25
      //color: "#222222AA"
      color: "white"
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
                //hideThemePopup.stop()
                themeElement.color = Config.loadedTheme.main.backgroundMarked
              }
              onExited: function() {
                //hideThemePopup.start()
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
              text: modelData.icon
              color: Config.loadedTheme.font.color
            }
      //color: "white"
      // blur und schatten
      layer.enabled: true
      layer.effect: DropShadow {
        radius: 16
        samples: 24
        color: "#fa0808ff"
        //horizontalOffest: 0
        verticalOffset: 10
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
          when: themeRoot.childVisible
          PropertyChanges {
            target: themePopupContainer
            opacity: 1.0
            scale: 1
          }
        },
        State {
          name: "hidden"
          when: !themeRoot.childVisible
          PropertyChanges {
            target: themePopupContainer
            opacity: 0
            scale: 0
          }
        }
      ]
    }
  } //PopupWindow
}
//=========================================================================
