#!/bin/bash

pkill -SIGTERM quickshell
QML_XHR_ALLOW_FILE_READ=1 quickshell --path /home/schnubby/.config/quickshell/myShell/shell.qml
#QML_XHR_ALLOW_FILE_READ=1 quickshell --path /programmieren/repos/myShell/shell.qml