#!/bin/sh

LOC=/media/$USER/coldbackup

rsync -rltDvu --modify-window=1 --delete $@ work papers insoft/books bin ${LOC}/home/
rsync -rltDvu --modify-window=1 --delete $@ /media/stuff ${LOC}/stuff
rsync -rltDvu --modify-window=1 --delete $@ /media/home ${LOC}/store
