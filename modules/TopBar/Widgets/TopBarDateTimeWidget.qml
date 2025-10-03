import Quickshell
import QtQuick

import "../../../singletons/"

Text {
  id: datetime
  color: "white"
  text: Qt.formatDateTime(DateTime.datetime, "hh:mm")
  font.family: Fonts.family.standard
  font.bold: Fonts.design.standard
}
