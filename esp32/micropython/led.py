from machine import Timer
from machine import Pin

led = Pin(15, Pin.OUT)
count = 0

def led_blink(t):
    global count
    count += 1
    led.value(count % 2)

tim0 = Timer(0)
tim0.init(period = 1000, mode = Timer.PERIODIC, callback = led_blink)
# tim0.init(period = 1000, mode = Timer.PERIODIC, callback = lambda t: print(t))
