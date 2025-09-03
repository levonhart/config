#!/usr/bin/env bash
LANG=C
if rfkill -ro Soft list wifi | grep -q "^blocked"
then
	rfkill unblock wifi
else
	rfkill block wifi
fi
