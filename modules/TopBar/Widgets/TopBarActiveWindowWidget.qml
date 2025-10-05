import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: activeWindow
  color: Design.font.color 
  anchors.centerIn: parent
  text: Hypr.activeWindow ? "[ " + Hypr.activeWindow.title + " ]" : ""
  font.family: Design.font.standard
}
