-- 管脚定义
print('oled test')
local sda = 5 -- GPIO14
local scl = 6 -- GPIO12
local sla = 0x3c  -- oled的地址，一般为0x3c
-- 初始化
function init_oled()
    -- iic总线 和 oled初始化
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g2.ssd1306_i2c_128x64_noname(0, sla)
    -- 设置字体
    disp:setFont(u8g2.font_unifont_t_symbols)
    -- disp:setFont(u8g2.font_6x10_tf)
    disp:setFontRefHeightExtendedText()
    --disp:setDrawColor(1)
    disp:setFontPosTop()
    -- disp:setFontDirection(0)
    -- 画边框
    disp:drawFrame(0, 0, 128, 64)
end

local line_table =
{
    function(str)
        disp:drawStr(0, 0, str)
    end,
    function(str)
        disp:drawStr(0, 16, str)
    end,
    function(str)
        disp:drawStr(0, 32, str)
    end,
    function(str)
        disp:drawStr(0, 48, str)
    end,
}

function oled_show_str(line, str)
    if line_table[line] then
        line_table[line](str)
        -- disp:sendBuffer()
    end
end

function get_time()
    secs = rtctime.get()
    secs = secs + 8 * 60 * 60 -- 调整到北京时间
    local tm = rtctime.epoch2cal(secs)
    -- return string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
    return string.format("%04d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
end

-- 主函数
function main()
    init_oled()
    tmr.create():alarm(500, tmr.ALARM_AUTO, function() -- 这里 100 ms就超时重启
        print('oled display')
        oled_show_str(1, get_time())
        -- disp:drawStr(0, 0, get_time())
        disp:sendBuffer()
    end)
    -- display_count()
end

-- 运行程序
main()

-- init_oled()
-- rtctime.set(1436430589, 0)
-- tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
--     oled_show_str(1, get_time())
--     disp:sendBuffer()
-- end)
