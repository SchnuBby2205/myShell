pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property var animTarget: ""
    property var animTarget2: ""

    function flyIn(target: var, target2: var): void {
        animTarget = target
        animTarget2 = target2
        flyIn.running = true
    }

    function flyOut(target: var, target2: var): void {
        animTarget = target
        animTarget2 = target2
        flyOut.running = true
    }

    ParallelAnimation {
        id: flyIn
        //running: true
        NumberAnimation { target: animTarget; property: "anchor.rect.y"; to: 35; duration: 100 }
        NumberAnimation { target: animTarget2; property: "opacity"; to: Config.loadedTheme.main.opacity; duration: 100 }
    }
    SequentialAnimation {
        id: flyOut
        ParallelAnimation {
          //running: true
          NumberAnimation { target: animTarget; property: "anchor.rect.y"; to: 0; duration: 100 }
          NumberAnimation { target: animTarget2; property: "opacity"; to: 0; duration: 100 }
        }
        PropertyAction {target: animTarget; property: "visible"; value: false}
    }
}