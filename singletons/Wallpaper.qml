pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

Singleton {
  id: root

  readonly property string wallpaperDir: "/home/schnubby/Bilder/Wallpapers/"
  readonly property string wallpaperCacheDir: "/home/schnubby/.cache/Wallpaper_thumbs/"
  property var arrWallpapers: []
  property ListModel listWallpapers: ListModel{} 
  property string currentWallpaper: ""
  //property bool wallpapersLoaded: false  

  function setRandomWallpaper(): void {
    var rnd = Math.floor(Math.random() * (arrWallpapers.length - 1))
    Config.appSettings.currentWallpaper = arrWallpapers[rnd]
    currentWallpaper = wallpaperDir + arrWallpapers[rnd]
    wallpapersSetProc.running = true
  }
  function togglePicker(): void {
    cacheWallpapers()
    wallpapersReadProc.running = true
    wallpaperPicker.visible = !wallpaperPicker.visible
  }
  function cacheWallpapers(): void {
    Quickshell.execDetached("/bin/create_thumbnails.sh")
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
        //wallpapersLoaded = true
      }
    }
  }
  Process {
    id: wallpapersSetProc
    command: ["matugen", "image", currentWallpaper]
    stdout: StdioCollector {
      onStreamFinished: Quickshell.execDetached("/bin/reload_shell.sh")
    }
  } 
  FloatingWindow {
    id: wallpaperPicker
    implicitHeight: 100
    implicitWidth: 100
    visible: false
    color: "transparent" 

    Rectangle {
      id: wallpapers

      opacity: Config.loadedTheme.main.opacity
      color: Config.loadedTheme.main.background
      radius: Config.loadedTheme.main.radius

      anchors.fill: parent

      ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn  // optional
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded        

        Grid {
          anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.hoarizontalCenter
          }
          columns: 8
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
                  console.log(currentWallpaper)
                  wallpapersSetProc.running = true
                }
              }
            }  
          }
        }
      }
    }
  }
}
