import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  //color: Config.loadedTheme.font.color 
  color: Config.colors.colors.color10
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Config.loadedTheme.font.standard
}
