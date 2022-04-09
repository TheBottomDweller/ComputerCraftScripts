local screen = peripheral.wrap("right")
local xpos = 1
local ypos = 1
screen.clear()
screen.setCursorPos(xpos,ypos)
while true do
    text = http.get("https://dashboard.twitch.tv/popout/u/thebottomdweller/stream-manager/chat?uuid=1cc5fef56301e3c0f6e020b752744553")
    screen.write(text)
    ypos = ypos + 1
    screen.setCursorPos(1, ypos)
    if ypos >= 33 then
        screen.scroll(1)
    end
end
