#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Simple script to get the current song being played by
# exaile. 
# Author: Santiago Zarate <santiago [at] zarate [dot] net [dot] ve>
# Blog: http://blog.santiago.zarate.net.ve
# Version: 0.1
# Exaile Version: 0.2.x 
# 
import sys, dbus

DEBUG = False
bus = dbus.SessionBus()

try:
    remote_object = bus.get_object("org.exaile.DBusInterface","/org/exaile")
    iface = dbus.Interface(remote_object, "org.exaile.ExaileInterface")
    if(iface.status() == 'playing'):
        message = '%s - %s - %s ' % (iface.get_title(), iface.get_album(), iface.get_artist())
    else:
        message = 'Exaile is not playing'

except dbus.exceptions.DBusException, e:
    message = 'Exaile is not running'
    if(DEBUG):
        message = 'Exaile is not running: %s' % e

print message
