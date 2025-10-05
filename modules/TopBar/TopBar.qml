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
    opacity:0.75 
    color: Design.main.background
    border.color: Design.main.bordercolor
    radius: Design.main.radius
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
