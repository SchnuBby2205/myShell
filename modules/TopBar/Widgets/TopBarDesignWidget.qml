import Quickshell
import Quickshell.Io
import QtQuick

import "../../../singletons/"

Rectangle {

  color: "transparent"
  implicitHeight: 20
  implicitWidth: 20
  MouseArea {
    id: designControl
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: function(mouse) {
      if(mouse.button == Qt.LeftButton) {
        //Wallpaper.setRandomWallpaper()
        Config.setDesign("light")
      } 
      if(mouse.button == Qt.RightButton) {
        //Wallpaper.togglePicker()
        Config.setDesign("dark")
      }
    }
  }
  Text {
    id: designIcon 
    color: Config.designs[Config.loadedDesign].font.color 
    text: "X"
  }
}
