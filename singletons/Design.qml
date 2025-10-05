pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  
  readonly property Main main: Main {}
  readonly property Font font: Font {}

  component Main: JsonObject {
    property string background: "black"
    property string bordercolor: "grey"
    property int radius: 5
    property real opacity: 0.75
  }

  component Font: JsonObject {
    property string color: "white"
    property string standard: "CaskaydiaCove NF"
  }
}
