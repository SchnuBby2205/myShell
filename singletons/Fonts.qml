pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
  readonly property FontFamily family: FontFamily {}
  readonly property FontDesign design: FontDesign {}

  component FontFamily: JsonObject {
    property string standard: "CaskaydiaCove NF"
  }
  component FontDesign: JsonObject {
    property bool standard: false 
  }
}
