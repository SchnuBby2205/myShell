pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
  readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
      if (!node.isStream) {
          if (node.isSink)
              acc.sinks.push(node);
          else if (node.audio)
              acc.sources.push(node);
      }
      return acc;
  }, {
      sources: [],
      sinks: []
  })

  readonly property list<PwNode> sinks: nodes.sinks
  readonly property list<PwNode> sources: nodes.sources

  readonly property PwNode activeSink: Pipewire.defaultAudioSink
  readonly property PwNode activeSource: Pipewire.defaultAudioSource
  
  readonly property real volume: Math.round(activeSink?.audio?.volume*100) ?? 0
  readonly property real sourceVolume: activeSource?.audio?.volume ?? 0

  readonly property bool muted: !!activeSink?.audio?.muted
  readonly property bool sourceMuted: !!activeSource?.audio?.muted

  function getVolumeIcon(): string {
    if(muted) return ""
    if(volume >= 50) {
      return ""
    } else if (volume < 50) {
      return ""
    }
  }

  function toggleMute(): void {
    Pipewire.defaultAudioSink.audio.muted = !Pipewire.defaultAudioSink.audio.muted
  }

  function setVolumeWithMouseWheel(wheel: var): void {
    var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
    var newVol = Math.max(0, Math.min(1, Pipewire.defaultAudioSink.audio.volume + delta))
    Pipewire.defaultAudioSink.audio.volume = newVol
  }

  PwObjectTracker {
    objects: [activeSink]
  }
}
