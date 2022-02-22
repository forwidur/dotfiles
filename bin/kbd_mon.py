#!/usr/bin/python

import os

import pyudev

monitor = pyudev.Monitor.from_netlink(pyudev.Context())
monitor.filter_by('input')
for device in iter(monitor.poll, None):
  if device.action == 'add' and \
     'XKBLAYOUT' in device.properties and \
     device.properties['.LOCAL_ifNum'] == '00':
    #print(list(device.items()))
    print('Input added. Running kbd.sh')
    os.system('/home/mag/bin/kbd.sh')
