#!/usr/bin/bash

echo
read -p "Please enter ID of your keyboard (Default: 1): " hidraw_id


chmod a+rw /dev/hidraw${hidraw_id}:-1

chromium --app=https://usevia.com

chmod a-rw /dev/hidraw${hidraw_id}:-1
