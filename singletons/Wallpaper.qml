pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {

  readonly property string wallpaperDir: "/home/schnubby/Bilder/Wallpapers/"
  property var arrWallpapers: []
  property ListModel testWallpapers: {}
  property string currentWallpaper: ""

  function setRandomWallpaper(): void {
    wallpapersReadProc.running = true
  }
  function togglePicker(): void {
    wallpaperPicker.visible = !wallpaperPicker.visible
    //console.log("test")
  }
  
  Process {
    id: wallpapersReadProc
    command: ["ls", wallpaperDir]
    stdout: StdioCollector {
      onStreamFinished: {
        arrWallpapers = []
        for(var i in text.split("\n")) {
          var wallpaperName = text.split("\n")[i]
          wallpaperName != "" ? arrWallpapers.push(wallpaperName) : null
          wallpaperName != "" ? testWallpapers.append({"name": "test", "icon":wallpaperName}) : null
        }
        var rnd = Math.floor(Math.random() * (arrWallpapers.length - 1))
        currentWallpaper = wallpaperDir + arrWallpapers[rnd]
        wallpapersSetProc.running = true
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
    color: Design.main.background 
    Row {
      anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
      }
      spacing: 5
      Repeater {
        id: test
        /*
        model: ListModel {
          ListElement {
            name: "bill"
            icon: "african-light.jpg"
          }
          ListElement {
            name: "test"
            icon: "3d-tech.jpg"
          }
        }
        */
        model: testWallpapers
        Image {
          id: testImage
          required property var modelData
          required property int index

          MouseArea {
            id: choosePic
            anchors.fill: parent
            onClicked: {
              currentWallpaper = wallpaperDir + modelData.icon
              wallpapersSetProc.running = true
            }
          }
  
          height: 200
          width: 200
          source: wallpaperDir + modelData.icon
        }
      }
    }
  }
}
