import Quickshell
import QtQuick

import "./Widgets/" 
import "./Wrappers/"
import "../../singletons/"

PanelWindow {
  id: topBar
  implicitHeight: 30
  anchors {
    top: true
    left: true
    right: true
  }
  margins {
    left: 0
    right: 0
    top: 5
  }
  //color: "grey"
  // Wenn das Panel transparent ist, kann das rectangle rounded sein.
  color: "transparent"
  Rectangle {
    id: topBarContent
    opacity: Config.loadedTheme.main.opacity
    //color: Config.loadedTheme.main.background
    //border.color: Config.loadedTheme.main.bordercolor
    color: "transparent"
    radius: Config.loadedTheme.main.radius
    anchors {
      fill: parent
      topMargin: 0
      bottomMargin: 2
      leftMargin: 2
      rightMargin: 2
    }
    Rectangle {
      implicitHeight: 30
      implicitWidth: 105
      radius: Config.loadedTheme.main.radius
      color: Config.loadedTheme.main.background
      opacity: Config.loadedTheme.main.opacity
      TopBarWorkspaceWidget {
        id: topBarWorkspaceWidget
      }
    }
    Rectangle {
      implicitHeight: 30
      implicitWidth: 500
      radius: Config.loadedTheme.main.radius
      color: Config.loadedTheme.main.background
      opacity: Config.loadedTheme.main.opacity
      anchors.centerIn: parent
      TopBarActiveWindowWidget {
        id: topBarActiveWindowWidget
      }
    }
    Rectangle {
      implicitHeight: 30
      implicitWidth: 140
      radius: Config.loadedTheme.main.radius
      color: Config.loadedTheme.main.background
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        //rightMargin: 5 
      }
      TopBarRightWrapper {
        id: topBarRightWrapper
      }
    }
  }
}
