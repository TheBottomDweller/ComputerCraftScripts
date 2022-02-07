local modem = peripheral.find("modem") or error("no modem found", 0)
peripheral.find("modem", rednet.open)

rednet.host("Default", "Blank")

while true do
    local id, message = rednet.receive("Farmbots")
    print(message)
    
    if message ~= nil then
        shell.run(message)
        break
    end
end