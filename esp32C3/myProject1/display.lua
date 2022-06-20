local sys = require 'sys'

u8g2.begin({ic = 'ssd1306', direction = 0, mode = 'i2c_hw', i2c_id = 0, i2c_speed = i2c.FAST}) -- direction 可选0 90 180 270

u8g2.SetFontMode(1)
u8g2.ClearBuffer()
u8g2.SetFont(u8g2.font_opposansm8)
u8g2.DrawUTF8('U8g2+Luatos', 32, 22)

if u8g2.font_opposansm12_chinese then
    u8g2.SetFont(u8g2.font_opposansm12_chinese)
else
    u8g2.SetFont(u8g2.font_opposansm10_chinese)
end

u8g2.SetFont(u8g2.font_opposansm12_chinese)
u8g2.DrawUTF8("中文测试", 40, 38) -- 若中文不显示或乱码,代表所刷固件不带这个字号的字体数据, 可自行云编译一份. wiki.luatos.com 有文档.
u8g2.SendBuffer()

--主流程
sys.taskInit(function()
    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("屏幕宽度", 0, 24)
    u8g2.DrawUTF8("屏幕高度", 0, 42)
    u8g2.DrawUTF8(":"..u8g2.GetDisplayWidth(), 80, 24)
    u8g2.DrawUTF8(":"..u8g2.GetDisplayHeight(), 80, 42)
    u8g2.SendBuffer()

    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("画线测试：", 30, 24)
    for i = 0, 128, 8 do
        u8g2.DrawLine(0,40,i,40)
        u8g2.DrawLine(0,60,i,60)
        u8g2.SendBuffer()
        sys.wait(100)
    end

    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("画圆测试：", 30, 24)
    u8g2.DrawCircle(30,50,10,15)
    u8g2.DrawDisc(90,50,10,15)
    u8g2.SendBuffer()

    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("椭圆测试：", 30, 24)
    u8g2.DrawEllipse(30,50,6,10,15)
    u8g2.DrawFilledEllipse(90,50,6,10,15)
    u8g2.SendBuffer()

    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("方框测试：", 30, 24)
    u8g2.DrawBox(30,40,30,24)
    u8g2.DrawFrame(90,40,30,24)
    u8g2.SendBuffer()

    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("圆角方框：", 30, 24)
    u8g2.DrawRBox(30,40,30,24,8)
    u8g2.DrawRFrame(90,40,30,24,8)
    u8g2.SendBuffer()

    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawUTF8("三角测试：", 30, 24)
    u8g2.DrawTriangle(30,60, 60,30, 90,60)
    u8g2.SendBuffer()


    -- qrcode测试
    sys.wait(1000)
    u8g2.ClearBuffer()
    u8g2.DrawDrcode(4, 4, "https://wiki.luatos.com/chips/air101/mcu.html", 10);

    u8g2.SendBuffer()

    --sys.wait(1000)
    log.info("main", "u8g2 demo done xxxx")
end)
