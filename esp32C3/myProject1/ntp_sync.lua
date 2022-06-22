local sys = require "sys"

sys.subscribe("IP_READY", function()
    -- 北京时间,具体参数请看(https://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html)
    log.info("fengliang", "xxxxxxxxxxxxxxxxxxxxxxxxxxx")
    ntp.settz("CST-8") 
    -- ntp.init("ntp.ntsc.ac.cn")
    ntp.init("ntp.cloud.aliyuncs.com")
end)

sys.subscribe("NTP_SYNC_DONE", function()
    log.info("ntp", "done")
    log.info("date", os.date())
end)
