import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  color: Design.font.color 
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Design.font.standard
}
