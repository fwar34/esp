import network

# Wi-Fi configuration
STA_SSID = "PHICOMM"
STA_PSK = "fengliang"

# Disable AP interface
ap_if = network.WLAN(network.AP_IF)
if ap_if.active():
    ap_if.active(False)
  
# Connect to Wi-Fi if not connected
sta_if = network.WLAN(network.STA_IF)
if not ap_if.active():
    sta_if.active(True)
if not sta_if.isconnected():
    sta_if.connect(STA_SSID, STA_PSK)
    # Wait for connecting to Wi-Fi
    while not sta_if.isconnected(): 
        pass

# Show IP address
print("Server started @", sta_if.ifconfig()[0])
