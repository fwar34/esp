local num = 0
tmr.create():alarm(2000, tmr.ALARM_AUTO, function()
    print('print task:' .. num)
    num = num + 1
end)
