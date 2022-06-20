-- LuaTools需要PROJECT和VERSION这两个信息
PROJECT = "mytest"
VERSION = "0.0.1"

sys = require("sys")

--第一个任务
sys.taskInit(function()
    while true do
        log.info("task1","wow")
        sys.wait(1000) --延时1秒，这段时间里可以运行其他代码
        sys.publish("TASK1_DONE")--发布这个消息，此时所有在等的都会收到这条消息
    end
end)

--第二个任务
sys.taskInit(function()
    while true do
        sys.waitUntil("TASK1_DONE")--等待这个消息，这个任务阻塞在这里了
        log.info("task2","wow")
    end
end)

--第三个任务
sys.taskInit(function()
    while true do
        local result = sys.waitUntil("TASK1_DONE",500)--等待超时时间500ms，超过就返回false而且不等了
        log.info("task3","wait result",result)
    end
end)

--单独订阅，可以当回调来用
sys.subscribe("TASK1_DONE",function()
    log.info("subscribe","wow")
end)

sys.run()
