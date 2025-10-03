pragma Singleton

import Quickshell
import QtQuick 

Singleton {
  id: root
  readonly property string datetime: clock.date
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
  /* für später mal aufheben....
  function getLocaleDate(): string {
    var month = Qt.formatDateTime(clock.date, "MMMM")
    if(month == "October") month = "Oktober"
    return month
  }
  */
}
