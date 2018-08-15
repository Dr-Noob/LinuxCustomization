#!/bin/bash -u

####################
# Autoconfigure    #
#######################################
# Switch different themes dinamically #
#######################################


#All stuff dirs
conkysdir="?"
light1="$conkysdir/?"
dark1="$conkysdir/?"

#Cairo dock folder name by default
cd_folder_default="?"

declare -a THEME1
declare -a THEME2
######   root-dir  wallpaper-left   wallpaper-right conky1        conky2         conky3            video           video_res  video_pos
THEME1=("$light1"  "?"              "?"             "?"           "?"            "?"               "?"             "?"        "?")
THEME2=("$dark1"   "?"              "?"             "?"           "?"            "?"               "?"             "?"        "?")

function set_theme() {
  arr=("$@")
  pkill conky 2> /dev/null
  pkill cairo-dock 2> /dev/null

  feh --bg-fill "${arr[0]}/${arr[1]}" --bg-fill "${arr[0]}/${arr[2]}"

  cairo-dock -o -d "${arr[0]}/$cd_folder_default""-i" &
  cairo-dock -o -d "${arr[0]}/$cd_folder_default""-d" &

  if [ "${arr[3]}" != "none" ]; then
    conky -c "${arr[0]}/${arr[3]}" & disown
  fi

  if [ "${arr[4]}" != "none" ]; then
    conky -c "${arr[0]}/${arr[4]}" & disown
  fi

  if [ "${arr[5]}" != "none" ]; then
    conky -c "${arr[0]}/${arr[5]}" & disown
  fi

  if [ "${arr[6]}" != "none" ]; then
    #Play video
    mpv="mpv --wid WID --no-config --keepaspect=no --no-border --vd-lavc-fast --x11-bypass-compositor=no --gapless-audio=no --vo=xv --hwdec=auto --really-quiet --name=mpvbg --geometry="${arr[7]}" --loop"
    xwin="xwinwrap -ni -b -nf -ov -g "${arr[7]}"+"${arr[8]}" -- "
    $xwin $mpv "${arr[0]}/${arr[6]}" &
  fi
}

style="empty"
while true
do
  currenttime=$(date +%H)
  if [[ $currenttime -gt 18 || ($currenttime -ge 0 && $currenttime -lt 8) ]]; then
    #DARK THEME
    set_theme "${THEME1_dark[@]}"
    style="dark"
  else
    #LIGHT THEME

    #Just set new wall if previous was not light
    if [ "$style" != "light" ]; then
      if [ $(( ( RANDOM % 2 ) )) -eq 0 ]; then
        set_theme "${THEME1_light[@]}"
      else
        set_theme "${THEME2_light[@]}"
      fi
      style="light"
    fi
  fi
  sleep 3600
done
