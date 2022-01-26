local SLOT_COUNT = 16
local cropChoice
local cropSeed
local stopBlock

if (#arg == 3) then
    cropChoice = (arg[1])
    cropSeed = (arg[2])
    stopBlock = (arg[3])
else
    print("Incomplete Instructions")
    shell.run("startup.lua")
end


function retrieveHarvest()
    for i = 1, 6 , 1 do
        turtle.suck()
    end
end

function checkFuel()
    print("Checking Fuel...")
    if (turtle.getFuelLevel() < 15) then
        for i = 1, SLOT_COUNT, 1 do
            local item = turtle.getItemDetail(i)
            if (item ~= nil) then
                if item["name"] == "minecraft:coal" or item["name"] == "minecraft:coal_block" then
                    turtle.refuel(all)
                end
            end
        end
        if (turtle.getFuelLevel() < 15) then
            print("Not Enough Fuel Left, Return to Origin")
            returnToOrigin()
        end
    end
end

function checkNMove()
    local checkedBlock, checkData = turtle.inspect()
    if checkData["name"] == stopBlock then
        return false
    else
        turtle.forward()
        return true
    end
end

function returnToOrigin()
    turtle.turnLeft()
    turtle.turnLeft()
    repeat
        turtle.forward()
        itemBlock, chest = turtle.inspect()
    until chest["name"] == "minecraft:chest"
    dropHarvest()
    turtle.turnLeft()
    if (turtle.getFuelLevel() > 15) then
        standbyForHarvest()
    else
        print("Not enough fuel, on Standby")
    end
end

function dropHarvest()
    for i = 1, SLOT_COUNT, 1 do
        local item = getItemIndex(cropChoice)
        if (item ~= nil) then
            turtle.select(item)
            if cropChoice == cropSeed then
             turtle.drop(turtle.getItemCount() - 1)
            else
            turtle.drop(turtle.getItemCount())
            end
        end
    end
end

function moveLeft()
    turtle.turnLeft()
    local continue = checkNMove()
    if continue == true then
        turtle.turnRight()
        standbyForHarvest()
    else
        returnToOrigin()
    end
end

function getItemIndex(itemName)
    for slot = 1, SLOT_COUNT, 1 do
        local item = turtle.getItemDetail(slot)
        if (item ~= nil) then
            if(item["name"] == itemName) then
                print (slot)
                return slot
            end
        end
    end
end

function standbyForHarvest()
    repeat
        isBlock, data = turtle.inspect()
    until data['state']['age'] == 7
        checkFuel()
        if(isBlock) then
            if (data['state']['age'] == 7) then
                turtle.dig()
                retrieveHarvest()
                itemIndex = getItemIndex(cropChoice)
                seedIndex = getItemIndex(cropSeed)
                if seedIndex ~= nil then
                    turtle.select(seedIndex)
                    turtle.place()
                    moveLeft()
                else
                    print("No more seeds, on standby")
                end
        end
     end
end

standbyForHarvest()
