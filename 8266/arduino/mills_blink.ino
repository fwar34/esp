/*********
  Rui Santos
  Complete project details at http://randomnerdtutorials.com  
*********/

#include <Ticker.h>
#include <U8g2lib.h>
#include <Wire.h>

#include <NTPClient.h>
// change next line to use with another board/shield
#include <ESP8266WiFi.h>
//#include <WiFi.h> // for WiFi shield
//#include <WiFi101.h> // for WiFi 101 shield or MKR1000
#include <WiFiUdp.h>

const char *ssid     = "PHICOMM";
const char *password = "fengliang";

WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "ntp1.aliyun.com",60*60*8, 30*60*1000);

#define SCL 5
#define SDA 4

Ticker timer1;
Ticker oled_timer;
Ticker scan_timer;
Ticker sync_timer;

// constants won't change. Used here to set a pin number :
const int ledPin =  2;      // the number of the LED pin

// Variables will change :
int ledState = LOW;             // ledState used to set the LED

// Generally, you should use "unsigned long" for variables that hold time
// The value will quickly become too large for an int to store
unsigned long previousMillis = 0;        // will store last time LED was updated

// constants won't change :
const long interval = 1000;           // interval at which to blink (milliseconds)

U8G2_SSD1306_128X64_NONAME_F_SW_I2C u8g2(U8G2_R0, /*clock=*/SCL, /*data=*/SDA, /*reset=*/U8X8_PIN_NONE);   

static bool disp_flag = false;

void timer1_cb(int led_pin) 
{
  //Serial.println("led callback");
  int state = digitalRead(led_pin);  // 获取当前led引脚状态
  digitalWrite(led_pin, !state);     // 翻转LED引脚电平
}


void display_flag()
{
  disp_flag = true;
}

int count = 0;
void display()
{
    //u8g2.drawStr(0, 15, "Hello World!");
    u8g2.drawStr(0, 15, timeClient.getFormattedTime().c_str());
    //Serial.println("display>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    Serial.println(timeClient.getFormattedTime());
    u8g2.sendBuffer();
}

typedef enum
{
  KEY_UNPRESS,
  KEY_PRESS,
  KEY_RELEASE,
} KEY_STATE;

#define keyPin 0
static uint32_t key_press_duration_count = 0;
static uint32_t key_state = KEY_UNPRESS;

void scan_key()
{
  //Serial.println("onUpdate");
  switch (key_state) {
    case KEY_UNPRESS:
      if (digitalRead(keyPin) == LOW) {
        key_state = KEY_PRESS;
      }
      break;
    case KEY_PRESS:
      if (digitalRead(keyPin) == HIGH) {
        if (key_press_duration_count == 0) {
          key_state = KEY_UNPRESS;
        } else {
          key_state = KEY_RELEASE;
        }
      } else {
        key_press_duration_count++;
      }
      break;
    case KEY_RELEASE:
      if (key_press_duration_count < 50) {
        Serial.println("short press.....");
      } else {
        Serial.println("long press.....");
      }
      key_press_duration_count = 0;
      key_state = KEY_UNPRESS;
      break;
    default:
      key_press_duration_count = 0;
      key_state = KEY_UNPRESS;
  }
}

void time_sync()
{
  if (WiFi.status() == WL_CONNECTED) {
    sync_timer.detach();
    return;
  }
  timeClient.update();
}

void setup() {
  Serial.begin(115200); 
  WiFi.begin(ssid, password);

  while ( WiFi.status() != WL_CONNECTED ) {
    delay ( 500 );
    Serial.print ( "." );
  }

  timeClient.begin();
  // set the digital pin as output:
  pinMode(ledPin, OUTPUT);
  pinMode(keyPin, INPUT);
  u8g2.begin();
  u8g2.enableUTF8Print(); // enable UTF8 support for the Arduino print() function
  u8g2.setFont(u8g2_font_unifont_t_symbols);

  /* 设置周期性定时0.5s，即500ms，回调函数为timer1_cb，参数为LED引脚号，并启动定时器 */
  timer1.attach_ms(1000, timer1_cb, ledPin);
  oled_timer.attach_ms(100, display_flag);
  scan_timer.attach_ms(10, scan_key);
  sync_timer.attach(1, time_sync);
}

void loop() {
  
  //Serial.println(timeClient.getFormattedTime());
  //Serial.println("loop...........................................");
  /* 检测定时器是否为存活状态 */
  if(timer1.active()){
    //Serial.println("timer1 is active.");
  } else {
    //Serial.println("timer1 is not active!");
  }

  if (disp_flag) {
    //Serial.println("display loop...........................................");
    disp_flag = false;
    display();
  }
}
