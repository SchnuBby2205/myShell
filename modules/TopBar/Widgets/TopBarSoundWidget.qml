import Quickshell
import QtQuick

import "../../../singletons/"

Rectangle {
  color: "transparent"
  implicitHeight: 20
  implicitWidth: 20
  MouseArea {
    id: volumeControl
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: function(mouse) {
      if(mouse.button == Qt.LeftButton) {Sound.toggleMute()}
      if(mouse.button == Qt.RightButton) {Quickshell.execDetached("pavucontrol")}
    }
    onWheel: function(wheel) {
      Sound.setVolumeWithMouseWheel(wheel)
    }
  }
  Text {
    id: activeSink
    //color: Config.loadedTheme.font.color 
    color: Config.colors.colors.color10
    text: Sound.getVolumeIcon()
  }
}
