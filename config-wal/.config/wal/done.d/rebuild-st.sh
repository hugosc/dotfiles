#!/bin/bash
# Reload Xresources for st (st will reload via signal)

# Kill USR1 to all st instances to reload Xresources
pkill -USR1 st
