pragma Singleton

//import Quickshell
import Quickshell.Io

JsonObject {
  
  readonly property Main main: Main {}
  readonly property Font font: Font {}

  component Main: JsonObject {
    property string background: "white"
    property string bordercolor: "black"
    property int radius: 5
    property real opacity: 0.7
  }

  component Font: JsonObject {
    property string color: "black"
    property string standard: "CaskaydiaCove NF"
  }
}
