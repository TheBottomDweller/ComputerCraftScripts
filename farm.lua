local SLOT_COUNT = 16
local cropChoice
local cropSeed

term.write("Please Provide Crop ID: ")
cropChoice = read()
term.write("Now Provide Seed ID")
cropSeed = read()

function retrieveHarvest()
    for i = 1, 6 , 1 do
        turtle.suck()
    end
end

function moveLeft()
    turtle.turnLeft()
    turtle.forward()
    turtle.turnRight()
end

function getItemIndex(itemName)
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if (item ~= nil) then
            if(item["name"] == itemName) then
                return slot
            end
        end
    end
end

isBlock, data = turtle.inspect()

if (data['state']['age'] == 7) then
    turtle.dig()
    retrieveHarvest()
    itemIndex = getItemIndex(cropChoice)
    seedIndex = getItemIndex(cropSeed)
    turtle.select(cropSeed)
    turtle.place()
end

moveLeft()