#!/usr/bin/env bash
LC_ALL=C
if rfkill -ro Soft list wifi | grep -q "^blocked"
then
	rfkill unblock wifi
else
	rfkill block wifi
fi
