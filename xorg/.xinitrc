
erresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Keyboard Layout
setxkbmap en_AU &

setxkbmap -option caps:escape &

# Display Resolution
xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-0 --mode 1920x1080 --pos 1080x181 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 3000x181 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off

# Keyboard pressed delay ms | per sec
xset r rate 200 35 &

# Compositor
picom &

# Status Bar
slstatus &

# Wallpaper
exec feh --bg-scale ~/Pictures/synth_WP_01.jpg &

# Execute DWM
exec dwm

