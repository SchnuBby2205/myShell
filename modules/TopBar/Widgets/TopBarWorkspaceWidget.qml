import Quickshell
import QtQuick

import "../../../singletons/"

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
      radius: 5
      //color: modelData.active ? Config.loadedTheme.main.backgroundMarked : "grey"
      color: Hypr.activeWS && modelData.id == Hypr.activeWS.id ? Config.loadedTheme.main.backgroundMarked : "grey"
      Text {
        id: workspaceId
        //text: Hypr.activeWS && modelData.id == Hypr.activeWS.id ? "🌑" : ""
        //font.underline: Hypr.activeWS && modelData.id == Hypr.activeWS.id ? true : false
        text: modelData.id
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

