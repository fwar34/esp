-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = 'helloworld'
VERSION = '1.0.0'

print(_VERSION)

local TAG = 'main'

-- 引入必要的库文件(lua编写), 内部库不需要require
local sys = require 'sys'
log.info(TAG, 'hello world')


wdt.init(10000) -- 初始化
sys.timerLoopStart(wdt.feed, 5000)

require 'display'
require 'ntp_sync'
require 'mqttt'
require 'wifii'

sys.timerLoopStart(function()
	print('hi, LuatOS', os.date())
end, 3000)
-- 用户代码已结束---------------------------------------------
-- 结尾总是这一句
sys.run()
-- sys.run()之后后面不要加任何语句!!!!!
