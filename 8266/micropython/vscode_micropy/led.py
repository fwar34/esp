from machine import Pin
import time
led = Pin(2, Pin.OUT)

def led_blink():
    while True:
        led.off()
        time.sleep(1)
        led.on()
        time.sleep(1)