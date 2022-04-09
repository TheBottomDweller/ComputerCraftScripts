local screen = peripheral.wrap("right")
while true do
    text = http.get("https://dashboard.twitch.tv/popout/u/thebottomdweller/stream-manager/chat?uuid=1cc5fef56301e3c0f6e020b752744553")
    monitor.write(text)
end