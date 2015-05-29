#!/bin/sh

exec nc -xlocalhost:9050 $*
