local SLOT_COUNT = 16
local cropChoice
local cropSeed
local stopBlock

term.write("Please Provide Crop ID: ")
cropChoice = read()
term.write("Now Provide Seed ID: ")
cropSeed = read()
term.write("Finally, Provide the Stop Block: ")
stopBlock = read()
print("Setup Complete, Make sure a chest is at the starting point")


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
    until turtle.inspect() == "minecraft:chest"
    turtle.drop()
    turtle.turnRight()
    if (turtle.getFuelLevel() > 15) then
    standbyForHarvest()
    else
        print("Not enough fuel, on Standby")
    end
end

function moveLeft()
    turtle.turnLeft()
    local continue = checkNMove()
    if continue == true then
        turtle.turnRight()
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
        wait(1)
    until data['state']['age'] == 7
        checkFuel()
        if(isBlock) then
            if (data['state']['age'] == 7) then
                turtle.dig()
                retrieveHarvest()
                itemIndex = getItemIndex(cropChoice)
                seedIndex = getItemIndex(cropSeed)
                turtle.select(seedIndex)
                turtle.place()
                if cropChoice == cropSeed then
                    turtle.dropDown(turtle.getItemCount() - 1)
                else
                    turtle.dropDown(turtle.getItemCount() - 1)
                    turtle.select(getItemIndex)
                end
            end
        end
     moveLeft()
end


standbyForHarvest()