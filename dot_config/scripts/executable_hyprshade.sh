#!/bin/bash

hyprshade install
systemctl --user enable --now hyprshade.timer
