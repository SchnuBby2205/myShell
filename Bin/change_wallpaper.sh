#!/bin/bash

wallpaperDir=$HOME/Bilder/Wallpapers/
cacheDir=$HOME/.cache/Wallpaper_thumbs/
returnDir=$PWD

cd $cacheDir

wallpaper=$(for a in *.jpg; do
    echo -en "$a\0icon\x1f$a\n"  
    #echo $a
done | rofi -dmenu)

matugen image ${wallpaperDir}/${wallpaper}

cd $returnDir
/bin/reload_shell.sh
