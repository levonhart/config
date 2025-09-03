#!/usr/bin/env bash
LANG=C
if rfkill -ro Soft list bluetooth | grep -q "^blocked"
then
	rfkill unblock bluetooth
else
	rfkill block bluetooth
fi
