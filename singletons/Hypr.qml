pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
  id: hyprland
 
  readonly property var ws: Hyprland.workspaces
  readonly property var activeWindow: Hyprland.activeToplevel?.wayland?.activated ? Hyprland.activeToplevel : null
  readonly property HyprlandWorkspace activeWS: Hyprland.focusedWorkspace

  function dispatchWS(workspaceID: int): void {
    Hyprland.dispatch("workspace " + workspaceID)
  }
}
