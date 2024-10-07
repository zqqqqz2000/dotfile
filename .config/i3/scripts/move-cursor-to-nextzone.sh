#!/bin/sh

direction=$1
n=${2:-1}
# direction is either up, down, left, or right, check if it's valid
if [ "$direction" != "up" ] && [ "$direction" != "down" ] && [ "$direction" != "left" ] && [ "$direction" != "right" ]; then
  echo "Invalid direction: $direction"
  exit 1
fi

focused_window=$(xdotool getwindowfocus -f)
output=$(xdotool getwindowgeometry --shell $focused_window)
width=$(echo $output | awk '{print $4}' | cut -d "=" -f 2)
height=$(echo $output | awk '{print $5}' | cut -d "=" -f 2)

# split the current focused window into 50 zones
zone_width=$((width / 50))
zone_height=$((height / 50))

# check direction then move mouse
if [ "$direction" = "up" ]; then
  move_x=0
  move_y=$((zone_height * n * -1))
elif [ "$direction" = "down" ]; then
  move_x=0
  move_y=$((zone_height * n))
elif [ "$direction" = "left" ]; then
  move_x=$((zone_width * n * -1))
  move_y=0
elif [ "$direction" = "right" ]; then
  move_x=$((zone_width * n))
  move_y=0
fi

xdotool mousemove_relative -- $move_x $move_y
