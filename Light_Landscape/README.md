# Light Landscape

![Final result](preview.png)

## Basics
For general basic configuration, please read [general guide](../README.md). __I'm not allowed to post the wallpaper image here, have a look at the [mali maeder's awesome work](https://www.pexels.com/photo/cliffs-clouds-cloudy-daylight-746421/). You can download it and edit it with any image editor to make it look as mine.__

## Special software
This software/tools are not mentioned at [general guide](../README.md) and will be used in this setup:
* [Moka](https://aur.archlinux.org/packages/moka-icon-theme/) - Icon theme(for cairo dock)
* [Lua file](../Ligth_Hands/Conky/bars.lua) - Lua code to show fancy bars. __NOTE: This script was made by [wlourf](http://u-scripts.blogspot.com/2010/07/bargraph-widget.html)__, I just modified it to make it match my needs.

## Let's do it
Install `Moka` icon pack and replace the specified configuration files of each tool with the files on the repo. There are a few steps:

* `CairoDock`: We'll have two docks; one at the very left of the screen, and other at the very right. If you need to set other path or you installed the icon pack but the icons are not working properly, you can modify the path under cairo dock configuration.

* `Conky`: This will show the [date](Conky/date.conky), and the [resources](Conky/resources.conky) information, which are in different files. __Note that the resources conky needs the [bars.lua](Conky/bars.lua) script to work, so you need to modify it path, which is described in [bars.conky](Conky/bars.conky).__

* `Mixing all together`: Finally, we need all stuff to start at boot, for what we could use my [autoconfigure](../autoconfigure.sh), or the openbox autostart file, mentioned above, which is a easier approach:

      feh --bg-fill /path/to/wall1.jpg --bg-fill /path/to/wall2.jpg
      compton -CGb
      cairo-dock -o -d /path/to/cairo-dock1 &
      cairo-dock -o -d /path/to/cairo-dock2 &
      conky -q -c /path/to/date.conky &
      conky -q -c /path/to/bars.conky &
