#!/usr/bin/env bash

APP=$1
if [ -z "$APP" ]; then
    echo "Usage: $0 <RemoteAppName>"
    exit 1
fi

CREDENTIALS=$(zenity --forms --title="RDP Login" \
    --text="Enter your credentials" \
    --add-entry="Username" \
    --add-password="Password")

if [ -z "$CREDENTIALS" ]; then
    exit 1
fi

USER=$(echo "$CREDENTIALS" | cut -d'|' -f1)
PASS=$(echo "$CREDENTIALS" | cut -d'|' -f2)

exec xfreerdp3 /u:"$USER" /p:"$PASS" /v:windows "/app:program:||$APP" /cert:ignore
