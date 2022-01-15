
local monitor = peripheral.wrap("back")
local modem = peripheral.wrap("top")
monitor.clear()
monitor.setTextScale(1)
monitor.setTextColor(colors.white)
local button = {}
monitor.setBackgroundColor((colors.black))

function clearButtonTable()
    button = {}
    monitor.clear()
end

function createButton(name, func, xmin, xmax, ymin, ymax, color)
    button[name] = {}
    button[name]["func"] = func
    button[name]["active"] = false
    button[name]["xmin"] = xmin
    button[name]["xmax"] = xmax
    button[name]["ymin"] = ymin
    button[name]["ymax"] = ymax
    button[name]["color"] = color
end

function MainMenuTable()
    clearButtonTable()
    screenName("Main Screen")
    createButton("Farmbots", FarmbotMenu, 2, 10, 2, 5, colors.green)
    screen()
end

function FarmbotMenu()
    clearButtonTable()
    screenName("Farmbot Menu")
    createButton("Test", buttonCheck, 2, 10, 2, 4, colors.red)
    createButton("Back", MainMenuTable, 2, 10, 6, 8, colors.green)
    screen()
end

function buttonCheck()
    print("Button Works")
end

function fill(text, color, bData)
    monitor.setBackgroundColor(color)
    local yspot = math.floor((bData["ymin"] + bData["ymax"]) /2)
    local xspot = math.floor(((bData["xmax"] - bData["xmin"]) - string.len(text)) / 2) + 1
    for j = bData["ymin"], bData["ymax"] do
        monitor.setCursorPos(bData["xmin"], j)
        if j == yspot then
            for k = 0, bData["xmax"] - bData["xmin"] - string.len(text) + 1 do
                if k == xspot then
                    monitor.write(text)
                else
                    monitor.write(" ")
                end
            end
        else
            for i = bData["xmin"], bData["xmax"] do
                monitor.write(" ")
            end
        end
    end
    monitor.setBackgroundColor(colors.black)
end

function screenName(text)
    w, h = monitor.getSize()
    monitor.setCursorPos((w - string.len(text)) /2 + 1, 1)
    monitor.write(text)
end

function screen()
    local currColor
    for name, data in pairs(button) do
        local on = data["active"]
        if on == true then
            currColor = colors.lime
        else
            currColor = data["color"]
        end
        fill(name, currColor, data)
    end
end

function flash(name)
    toggleButton(name)
    screen()
    sleep(0.15)
    toggleButton(name)
    screen()
end

function checkClick(x, y)
    for name, data in pairs(button) do
        if y >= data["ymin"] and y <= data["ymax"] then
            if x >= data["xmin"] and x <= data["xmax"] then
                data["func"]()
                return true
            end
        end
    end
end

function toggleButton(name)
    button[name]["active"] = not button[name]["active"]
    screen()
end

function getClick()
    event, side, x, y = os.pullEvent("monitor_touch")
    print("event: " .. event)
    print("side: " .. side)
    print(x .. " " .. y)
    checkClick(x, y)
end

MainMenuTable()
while true do
    getClick()
end