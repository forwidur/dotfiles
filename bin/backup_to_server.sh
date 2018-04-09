#!/bin/sh

set -x

BASE=mag.lambda.space:backups
DST=${BASE}/`hostname`

rsync --progress --copy-dirlinks -v -ar -z -e ssh papers work $DST

if [ -d "/media/stuff" ]; then
  rsync --progress --copy-dirlinks -v -a -e ssh --delete \
      /media/stuff/{books,audiobooks,music,music-highres} $DST
fi

#rsync --progress --copy-dirlinks -v -ar -e ssh /media/home/{photos,backup,books} fwd@uone.cu.cc:backups/home/store
