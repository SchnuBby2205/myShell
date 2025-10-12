pragma Singleton

//import Quickshell
import Quickshell.Io

JsonObject {
  
  readonly property Main main: Main {}
  readonly property Font font: Font {}

  component Main: JsonObject {
    property string background: "brown"
    property string bordercolor: "orange"
    property int radius: 5
    property real opacity: 0.7
  }

  component Font: JsonObject {
    property string color: "green"
    property string standard: "CaskaydiaCove NF"
  }
}
