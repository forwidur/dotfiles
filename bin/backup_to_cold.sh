#!/bin/bash

#LOC=/media/$USER/coldbackup
LOC=/mnt

rsync -rltDu --modify-window=1 --delete $@ work papers insoft/books bin ${LOC}/home/
echo "Home took ${SECONDS}s."
SECONDS=0

DEV=$(df | grep \/\$ | awk '{print $1}')
echo "Will backup $DEV to $LOC"
sudo dd if=$DEV bs=1M | gzip > $LOC/root.img_new.gz
mv $LOC/root.img_new.gz $LOC/root.img.gz
echo "Root took ${SECONDS}s,"
SECONDS=0

#rsync -rltDu --modify-window=1 --delete $@ /media/stuff ${LOC}/stuff
#echo "Stuff took ${SECONDS}s."
#SECONDS=0

rsync -rltDu --modify-window=1 --delete $@ /media/store ${LOC}/
echo "Store took ${SECONDS}s."
