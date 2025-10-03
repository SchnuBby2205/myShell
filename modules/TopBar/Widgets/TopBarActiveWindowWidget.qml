import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: activeWindow
  color: "white"
  anchors.centerIn: parent
  text: Hypr.activeWindow ? "[ " + Hypr.activeWindow.title + " ]" : ""
  font.family: Fonts.family.standard
  font.bold: Fonts.design.standard
}
