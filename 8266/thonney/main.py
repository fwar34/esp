from machine import Timer, Pin

led = Pin(2, Pin.OUT)

count = 0
def print_count(t):
    global count
    #print('count:', count)
    
    led.value(count % 2)
    count += 1

def timer():
    tim = Timer(-1)
    tim.init(period = 500, callback = print_count)
    
if __name__ == '__main__':
    timer()
