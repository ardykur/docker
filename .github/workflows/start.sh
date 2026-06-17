#!/bin/bash

# Start DBus
service dbus start

# Start XRDP
service xrdp start

# Start VNC server
su - user -c "vncserver :1 -geometry 1280x720 -depth 24"

# Start noVNC (web access)
websockify --web=/usr/share/novnc/ 6080 localhost:5901 &

# Auto start Anydesk + set password
anydesk --set-password 123456
anydesk --service

echo "✅ Container ready"
tail -f /dev/null
