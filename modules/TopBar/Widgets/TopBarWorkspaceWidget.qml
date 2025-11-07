import Quickshell
import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import "../../../singletons/"

//===================================
Item {
    id: workspaceWrapper
    width: 200
    height: 60
    // 1) Das eigentliche Widget
    Rectangle {
      id: workspaceWidgetRect
      implicitHeight: 30
      implicitWidth: 105
      radius: Config.loadedTheme.main.radius
      //color: "#222222AA"
      color: "transparent"
      Row {
        id: workspaceRow
        spacing: 5
        anchors {
          left: parent.left
          verticalCenter: parent.verticalCenter
          leftMargin: 5 
        }
        Repeater {
          id: workspaceRowRepeater
          model: Hypr.ws
          Rectangle {
            implicitHeight: 20
            implicitWidth: 20
            radius: 25
            //color: Hypr.activeWS && modelData.id == Hypr.activeWS.id ? Config.loadedTheme.main.backgroundMarked : "grey"
            color: Hypr.activeWS && modelData.id == Hypr.activeWS.id ? Config.colors.colors.color10 : Config.colors.colors.color15
            opacity: Hypr.activeWS && modelData.id == Hypr.activeWS.id ? 1 : 0.25
            Text {
              id: workspaceId
              font.family: Config.loadedTheme.font.standard
              anchors {
                centerIn: parent
                verticalCenter: parent.verticalCenter
              }
            }
            MouseArea {
              id: workspaceRowHandler
              anchors.fill: parent
              onClicked: {
                Hypr.dispatchWS(modelData.id)
              }
            }
          }
        }
      }
    }
    // 2) ShaderEffectSource für das Widget
    ShaderEffectSource {
        id: widgetSource
        sourceItem: workspaceWidgetRect
        live: true
        recursive: true
    }
    // 3) FastBlur (optional, wenn du Frosted-Glass-Look willst)
    FastBlur {
        id: widgetBlur
        anchors.fill: workspaceWidgetRect
        source: widgetSource
        radius: 10    // Stärke des Blurs
    }
    // 4) DropShadow
    DropShadow {
        anchors.fill: workspaceWidgetRect
        source: widgetSource
        radius: 16
        samples: 16
        color: "#00000066"
        horizontalOffset: 0
        verticalOffset: 4
    }
}
//===================================






