#!/usr/bin/python

import os
import time

import pyudev

monitor = pyudev.Monitor.from_netlink(pyudev.Context())
monitor.filter_by('input')
ts = time.time()

for device in iter(monitor.poll, None):
#  print(list(device.items()))
  now = time.time()
  if now - ts > 1 and device.action == 'add' and \
     'XKBLAYOUT' in device.properties:
    #print(list(device.items()))
    print('Input added. Running kbd.sh')
    os.system('/home/mag/bin/kbd.sh')
    ts = now
