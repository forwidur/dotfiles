#!/bin/sh

LOC=/media/store/

cd
rsync -a work papers bin ${LOC}/backup/home/
rsync -a /media/stuff/* ${LOC}/
