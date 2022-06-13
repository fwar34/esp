import network

def wifi_connect():
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    if not wlan.isconnected():
        print('connecting to network...')
        wlan.connect('PHICOMM', 'fengliang')
        while not wlan.isconnected():
            pass

    print('network config:', wlan.ifconfig())