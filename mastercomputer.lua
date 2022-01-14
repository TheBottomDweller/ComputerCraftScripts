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
    button.setTable("Farmbots", FarmbotMenu, 2, 8, 2, 5, colors.green)
end

function FarmbotMenu()
    clearButtonTable()
end

function fill(text, color, bData)
    monitor.setBackgroundColor(color)
    local yspot = math.floor((bData["ymin"] + bData["ymax"]) /2)
    local xspot = math.floor(((bData["xmax"] - bData["xmin"]) - string.len(text)) / 2) + 1
    for j == bData["ymin"], bData["ymax"] do
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