-- Monitors
-- ref: https://wiki.hypr.land/Configuring/Monitors/
local s = require('lua.settings')

-- Display control script
-- exec-once = $scrpath/monitor.sh -h $hdmi_res -d $dp_res #--external-only

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

--monitor = eDP-1, disable
hl.monitor({
    output = "eDP-1",
    mode = s.dp_res,
    position = s.edp_pos,
    scale = 1,
})

hl.monitor({
    output = "desc:HKC OVERSEAS LIMITED 0xAC81",
    mode = s.dp_res,
    position = "-1920x0",
    scale = 1,
})

--monitor = HDMI-A-1, 1920x1080@60, 0x0, 1
hl.monitor({
    output = "HDMI-A-1",
    mode = s.hdmi_res,
    position = "1920x0",
    scale = 1,
})

hl.monitor({
    output = "desc:HP Inc. HP E27k",
    mode = "preferred",
    position = "1920x0",
    scale = 1.25,
})

hl.monitor({
    output = "desc:GWD ARZOPA",
    mode = s.hdmi_75,
    position = "-1920x0",
    scale = 1,
})

hl.monitor({
    output = "desc:China Star",
    mode = "1920x1200@60",
    position = s.edp_pos,
    scale = 1,
})
