local screen = peripheral.wrap("right")
screen.clear()
screen.setCursorPos(1,1)
while true do
    text = http.get("https://dashboard.twitch.tv/popout/u/thebottomdweller/stream-manager/chat?uuid=1cc5fef56301e3c0f6e020b752744553")
    screen.write(text)
    curCursorPos = screen.getCursorPos(y)
    screen.setCursorPos(1, curCursorPos+1)
end
