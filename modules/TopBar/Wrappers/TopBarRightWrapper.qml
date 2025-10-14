import Quickshell
import QtQuick

import "../Widgets/"

Row {
  id: workspaceRow
  spacing: 5
  anchors {
    right: parent.right
    verticalCenter: parent.verticalCenter
    rightMargin: 5 
  }
  TopBarThemeWidget {
    id: topBarThemeWidget
  }
  TopBarWallpaperWidget {
    id: topBarWallpaperWidget
  }
  TopBarSoundWidget {
    id: topBarSoundWidget
  }
  TopBarDateTimeWidget {
    id: topBarDateTimeWidget
  }
  TopBarPowerWidget {
    id: topBarPowerWidget
  }
}
