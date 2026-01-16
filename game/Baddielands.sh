#!/bin/sh
printf '\033c\033]0;%s\a' Baddielands
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Baddielands.x86_64" "$@"
