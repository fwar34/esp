led = 4
print('Setting up WIFI...')
wifi.setmode(wifi.STATION)
wifi.sta.config{ssid='FAST_4DF8', pwd='renyongjia'}
wifi.sta.connect()

wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function(T)
    print("\n\tSTA - GOT IP".."\n\tStation IP: "..T.IP.."\n\tSubnet mask: "..T.netmask.."\n\tGateway IP: "..T.gateway)
    gpio.mode(led, gpio.OUTPUT)
    timer = tmr.create()
    timer:alarm(500, tmr.ALARM_AUTO, function()
        input = gpio.read(led)
        gpio.write(led, input == 1 and gpio.LOW or gpio.HIGH)
    end)
    -- flash_button_init(timer)
end)

