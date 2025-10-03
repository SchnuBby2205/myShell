// Momentan sind alle pipewire dinger dependencies
// auch swww für die Hintergründe

import Quickshell
import QtQuick

import "./modules/TopBar/"

ShellRoot {
  id: shellroot
  Loader {
    id: loaderTopBar
    active: true
    sourceComponent: TopBar{}
  }
}
