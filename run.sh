#!/bin/sh
printf '\033c\033]0;%s\a' GJ4
base_path="$(dirname "$(realpath "$0")")"
"$base_path/game/Baddielands.x86_64" "$@"

