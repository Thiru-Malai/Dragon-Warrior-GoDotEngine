#!/bin/sh
echo -ne '\033c\033]0;DragonWarrior\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DragonWarrior.x86_64" "$@"
