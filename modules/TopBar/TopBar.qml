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
  color: "transparent"
  TopBarWorkspaceWidget {}
  TopBarActiveWindowWidget {x: parent.width / 2 - 300}
  TopBarRightWrapper {x: parent.width - 150}
}