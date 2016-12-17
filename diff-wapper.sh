#!/bin/zsh

old=$2
new=$5

diff -Nau <(lv -c $old) <(lv -c $new) | less
