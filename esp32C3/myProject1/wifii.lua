local sys = require 'sys'

sys.taskInit(function()
    log.info("wlan", "wlan_init:", wlan.init())
    log.info("mode", wlan.setMode(wlan.STATION))
    log.info("connect", wlan.connect("PHICOMM", "fengliang"))
    -- 等待连上路由,此时还没获取到ip
    result, _ = sys.waitUntil("WLAN_STA_CONNECTED")
    log.info("wlan", "WLAN_STA_CONNECTED", result)
    -- 等到成功获取ip就代表连上局域网了
    result, data = sys.waitUntil("IP_READY")
    log.info("wlan", "IP_READY", result, data)
end)
