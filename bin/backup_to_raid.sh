#!/bin/sh

LOC=/media/store/

cd
rsync -a work papers bin sync ${LOC}/backup/home/
rsync -a --exclude "movies" --exclude "music-insoft" /media/stuff/* ${LOC}/
