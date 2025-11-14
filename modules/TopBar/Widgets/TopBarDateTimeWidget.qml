import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  //color: Config.loadedTheme.font.color 
  color: Config.colors.primary
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Config.loadedTheme.font.standard
}
