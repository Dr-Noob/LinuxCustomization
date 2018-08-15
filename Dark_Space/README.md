# Dark Space

![Final result](preview.gif)

## Basics
For general basic configuration, please read [general guide](../README.md). This wallpaper is special because, as you can see, there is a video running on it. __I will not share any video/image of this setup since they are taken from nasa, so you can always download it yourself and modify as I'm explaning:__

To get the left part:

1. I downloaded [this wallpaper](https://unsplash.com/photos/CpHNKNRwXps)
2. Removed background of the image and saved it as png, in a way that you can place the background you want behind it.
3. I downloaded all images from `Balearic Sea to Lake Turkana` at [this nasa webpage](https://eol.jsc.nasa.gov/BeyondThePhotography/CrewEarthObservationsVideos/).
4. I created a timelapse from this images
5. I rendered a video with the image and the timelapse behind it. At this point, you could get something like this setup. However, it would eat too much CPU to be running 24/7. That's what there are some things left to do...
6. I rendered a 760x760 pixels video from the previous one(this was minimum size to not to lose any part of the timelapse)
7. I set up the wallpaper and after that, I run the video, moving it to fit exactly the image(so you can't tell just a 760x760 video is playing). To play this video, I'm using `xwinwrap -ni -b -nf -ov -g 760x760+625+124 -- mpv --wid WID --no-config --keepaspect=no --no-border --vd-lavc-fast --x11-bypass-compositor=no --gapless-audio=no --vo=xv --hwdec=auto --really-quiet --name=mpvbg --geometry=760x760 --loop file.mp4`

On the right site, I'm using a second wallpaper which contains [the fancy falcon heavy wallpaper](https://gitlab.com/jstpcs/lnxpcs/blob/master/non-distro/falcon-heavy.png).

## Special software
This software/tools are not mentioned at [general guide](../README.md) and will be used in this setup:
* [La Capitaine](https://aur.archlinux.org/packages/la-capitaine-icon-theme/) - Icon theme from Sardi pack(for cairo dock)
* [Lua file](Conky/bars.lua) - Lua code to show fancy bars. __NOTE: This script was made by [wlourf](http://u-scripts.blogspot.com/2010/07/bargraph-widget.html)__, I just modified it to make it match my needs.

## Let's do it
Install `La Capitaine` icon pack and replace the specified configuration files of each tool with the files on the repo. There are a few steps:

* `CairoDock`: We'll have two docks; one at the very left of the screen, and other at the very right. If you need to set other path or you installed the icon pack but the icons are not working properly, you can modify the path under cairo dock configuration.

* `Conky`: This will show the [date](Conky/space2.conky), the [top processes and network status](Conky/space2.conky) and the [per cpu core status](Conky/space.conky) information, which are in different files. __Note that the [space2.conky](Conky/space2.conky) needs [bars.lua](Conky/bars.lua) script to work, so you need to modify it path, which is described in [bars.conky](Conky/bars.conky).__

* `Mixing all together`: Finally, we need all stuff to start at boot, for what we could use my [autoconfigure](../autoconfigure.sh), or the openbox autostart file, mentioned above, which is a easier approach:

      feh --bg-fill /path/to/wall1.jpg --bg-fill /path/to/wall2.jpg
      compton -CGb
      cairo-dock -o -d /path/to/cairo-dock1 &
      cairo-dock -o -d /path/to/cairo-dock2 &
      conky -q -c /path/to/space.conky &
      conky -q -c /path/to/space2.conky &
      xwinwrap -ni -b -nf -ov -g 760x760+625+124 -- mpv --wid WID --no-config --keepaspect=no --no-border --vd-lavc-fast --x11-bypass-compositor=no --gapless-audio=no --vo=xv --hwdec=auto --really-quiet --name=mpvbg --geometry=760x760 --loop file.mp4
