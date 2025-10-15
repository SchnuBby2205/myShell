pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root

  readonly property string wallpaperDir: "/home/schnubby/Bilder/Wallpapers/"
  readonly property string wallpaperCacheDir: "/home/schnubby/.cache/Wallpapers_thumbs/"
  property var arrWallpapers: []
  property ListModel listWallpapers: ListModel{} 
  property string currentWallpaper: ""
  

  function setRandomWallpaper(): void {
    var rnd = Math.floor(Math.random() * (arrWallpapers.length - 1))
    Config.appSettings.currentWallpaper = arrWallpapers[rnd]
    currentWallpaper = wallpaperDir + arrWallpapers[rnd]
    wallpapersSetProc.running = true
  }
  function togglePicker(): void {
    wallpaperPicker.visible = !wallpaperPicker.visible
  }

  property alias wallpapersReadProc: wallpapersReadProc
  Process {
    id: wallpapersReadProc
    running: false
    //command: ["ls", wallpaperDir]
    command: ["ls", wallpaperCacheDir]
    stdout: StdioCollector {
      onStreamFinished: {
        arrWallpapers = []
        for(var i in text.split("\n")) {
          var wallpaperName = text.split("\n")[i]
          wallpaperName != "" ? arrWallpapers.push(wallpaperName) : null
          wallpaperName != "" ? root.listWallpapers.append({name: "test", icon:wallpaperName}) : null
        }
      }
    }
  }
  Process {
    id: wallpapersSetProc
    command: ["swww", "img", currentWallpaper]
  } 
  FloatingWindow {
    id: wallpaperPicker
    implicitHeight: 100
    implicitWidth: 100
    visible: false
    color: "transparent" 
    Grid {
      anchors {
        verticalCenter: parent.verticalCenter
        horizontalCenter: parent.hoarizontalCenter
      }
      columns: 4
      spacing: 15
      Repeater {
        id: test
        model: listWallpapers
        Image {
          required property var modelData
          required property int index
          source: wallpaperCacheDir + modelData.icon
          width: 100
          height: 100
          MouseArea {
            id: choosePic
            anchors.fill: parent
            onClicked: {
              Config.appSettings.currentWallpaper = modelData.icon
              currentWallpaper = wallpaperDir + modelData.icon
              wallpapersSetProc.running = true
            }
          }
        }  
        /*
        Text {
          required property var modelData
          required property int index
          text: modelData.icon
          color: Config.loadedTheme.font.color
          MouseArea {
            id: choosePic
            anchors.fill: parent
            onClicked: {
              Config.appSettings.currentWallpaper = modelData.icon
              currentWallpaper = wallpaperDir + modelData.icon
              wallpapersSetProc.running = true
            }
          }
        }  
        */
      }
    }
  }
}
