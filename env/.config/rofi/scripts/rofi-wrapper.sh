#!/usr/bin/env bash

SCRIPT_DIR="$(dirname $(realpath $0))"

GAME_LAUNCHER_CACHE=$HOME/.cache/rofi-game-launcher
APP_PATH=$HOME/.local/share/applications/rofi-game-launcher

case "$1" in
    drun)       rofi -show drun -theme drun;;
    run)        rofi -show run -theme sidebar;;
    power)      $SCRIPT_DIR/rofi-powermenu.sh;;
    scripts)    $SCRIPT_DIR/rofi-local-scripts.sh;;
    games)
        $SCRIPT_DIR/update-steam-game-entries.sh -q &

        # Temporarily link then unlink the *.desktop files to the directory
        # where rofi looks for them to avoid having them appear when using
        # rofi normally
        if [ ! -e $APP_PATH ]; then
            ln -s $GAME_LAUNCHER_CACHE/applications $APP_PATH
            echo "Linked game launcher apps to local cache"
        fi

        rofi -show drun -theme games -drun-categories SteamLibrary,Game \
             -cache-dir $GAME_LAUNCHER_CACHE

        if [ -h $APP_PATH ]; then
            rm $APP_PATH
        fi

        # Emulate most recently used history by resetting the count
        # to 0 for each application
        sed -i -e 's/^1/0/' $HOME/.cache/rofi3.druncache
        ;;
    *)  echo "Usage: $0 {run,drun,games,windows,options}"
esac
