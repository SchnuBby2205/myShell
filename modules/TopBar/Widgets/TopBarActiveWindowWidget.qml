import Quickshell
import QtQuick
import QtQuick.Effects
import Qt5Compat.GraphicalEffects

import "../../../singletons/"

//===================================
Item {
    id: activeWindowWrapper
    width: 600
    height: 30
    // 1) Das eigentliche Widget
    Rectangle {
        id: activeWindowWidgetRect
        implicitHeight: 30
        implicitWidth: 600
        radius: Config.loadedTheme.main.radius
        //color: "#222222AA"
        color: "transparent"
        //color: Config.colors.secondary_container + "AA"
        //border.color: Config.colors.primary_container
        Text {
            id: activeWindow
            //color: Config.loadedTheme.font.color 
            //color: "#ffffff"
            color: Config.colors.primary_container
            anchors.centerIn: parent
            text: Hypr.activeWindow ? "[ " + Hypr.activeWindow.title + " ]" : ""
            font.family: Config.loadedTheme.font.standard
        }
    }/*
    // 2) ShaderEffectSource für das Widget
    ShaderEffectSource {
        id: widgetSource
        sourceItem: activeWindowWidgetRect
        live: true
        recursive: true
    }    
    
    // 3) FastBlur (optional, wenn du Frosted-Glass-Look willst)
    FastBlur {
        id: widgetBlur
        anchors.fill: activeWindowWidgetRect
        source: widgetSource
        radius: 10    // Stärke des Blurs
    }
    
    // 4) DropShadow
    DropShadow {
        anchors.fill: activeWindowWidgetRect
        source: widgetSource
        radius: 16
        samples: 16
        color: "#00000066"
        horizontalOffset: 0
        verticalOffset: 4
    }
    */

}
//===================================