import Quickshell
import QtQuick

import "../../../singletons/"
import "../../../Configs/"

Text {
  id: activeWindow
  color: Config.designs[Config.loadedDesign].font.color 
  anchors.centerIn: parent
  text: Hypr.activeWindow ? "[ " + Hypr.activeWindow.title + " ]" : ""
  font.family: Config.designs[Config.loadedDesign].font.standard
}
