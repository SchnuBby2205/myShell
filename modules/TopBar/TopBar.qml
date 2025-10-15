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
  }
  //color: "grey"
  // Wenn das Panel transparent ist, kann das rectangle rounded sein.
  color: "transparent"
  Rectangle {
    id: topBarContent
    opacity: Config.loadedTheme.main.opacity
    color: Config.loadedTheme.main.background
    //border.color: Config.loadedTheme.main.bordercolor
    radius: Config.loadedTheme.main.radius
    anchors {
      fill: parent
      topMargin: 2
      bottomMargin: 2
      leftMargin: 2
      rightMargin: 2
    }
    TopBarWorkspaceWidget {
      id: topBarWorkspaceWidget
    }
    TopBarActiveWindowWidget {
      id: topBarActiveWindowWidget
    }
    TopBarRightWrapper {
      id: topBarRightWrapper
    }
  }
}
