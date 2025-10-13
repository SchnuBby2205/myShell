import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  color: Config.loadedDesign.font.color 
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Config.loadedDesign.font.standard
}
