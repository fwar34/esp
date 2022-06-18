function is_connect()
    ip, _, _ = wifi.sta.getip()
    if ip ~= nil then
        return true
    else
        return false
    end
end


tmr1 = tmr.create()
tmr1:alarm(1000, tmr.ALARM_AUTO, function()
    print('start sync time')
    if is_connect() then
        tmr1:stop()
        sntp.sync({"0.nodemcu.pool.ntp.org"},
        function(sec, usec, server, info)
            print('sync time success:', sec, usec, server)
        end,
        function()
            print('sync time failed!')
        end
        )
        -- sntp.sync(nil, nil, nil, 1)
    end
end)
