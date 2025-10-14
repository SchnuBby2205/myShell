import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  color: Config.loadedTheme.font.color 
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Config.loadedTheme.font.standard
}
