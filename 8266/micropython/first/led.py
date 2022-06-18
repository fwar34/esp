from machine import Pin
from machine import Timer

led_pin = 2
led = Pin(led_pin, Pin.OUT)

count = 0
def blink(t):
    global led
    global count
    led.value(count % 2)
    count += 1

def led_blink():
    ltimer = Timer(-1)
    ltimer.init(period = 1000, callback = blink)
