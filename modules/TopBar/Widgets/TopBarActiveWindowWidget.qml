import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: activeWindow
  color: Config.loadedTheme.font.color 
  anchors.centerIn: parent
  text: Hypr.activeWindow ? "[ " + Hypr.activeWindow.title + " ]" : ""
  font.family: Config.loadedTheme.font.standard
}
