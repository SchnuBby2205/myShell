import Quickshell
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

import "../Widgets/"
import "../../../singletons/"

Item {
  id: powerWrapper
  width: 200
  height: 60
  // 1) Das eigentliche Widget
  Rectangle {
    id: powerWidgetRect
    implicitHeight: 30
    implicitWidth: 115
    //radius: Config.loadedTheme.main.radius
    radius: 25
    //color: "#222222AA"
    //color: "transparent"
    //color: Config.colors.secondary_container + "00"
    //border.color: Config.colors.primary_container
    //opacity: 0.25

    Row {
      id: itemWrapper
      spacing: 5
      anchors {
        right: parent.right
        verticalCenter: parent.verticalCenter
        rightMargin: 5 
      }
      /* Theme Widget deactivated... for now!
      TopBarThemeWidget {
        id: topBarThemeWidget
      }
      */
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
  }
  // 2) ShaderEffectSource für das Widget
  ShaderEffectSource {
      id: widgetSource
      sourceItem: powerWidgetRect
      live: true
      recursive: true
  }
  // 3) FastBlur (optional, wenn du Frosted-Glass-Look willst)
  FastBlur {
      id: widgetBlur
      anchors.fill: powerWidgetRect
      source: widgetSource
      radius: 10    // Stärke des Blurs
  }
  // 4) DropShadow
  DropShadow {
      anchors.fill: powerWidgetRect
      source: widgetSource
      radius: 16
      samples: 16
      color: "#00000066"
      horizontalOffset: 0
      verticalOffset: 4
  }
}
