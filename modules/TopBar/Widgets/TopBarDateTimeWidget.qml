import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  color: Config.designs[Config.loadedDesign].font.color 
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Config.designs[Config.loadedDesign].font.standard
}
