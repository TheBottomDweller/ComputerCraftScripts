local gitHubRepositoryLink = "https://raw.githubusercontent.com/TheBottomDweller/ComputerCraftScripts/main/"

function addSoftware()
    local fileRequested = ""
    local url = ""
    term.write("Provide File Name: ")
    fileRequested = read()
    if http.checkURL(gitHubRepositoryLink .. fileRequested) == true then
        if fs.exists("/"..fileRequested) == true then
            print ("File already exists")
        else
            url = (gitHubRepositoryLink .. fileRequested)
            print(http.get(url).readAll())
        end
    else
        print(fileRequested .. " doesn't exist, fuckhead")
    end
end

function updateSoftware()
    local fileRequested = ""
    term.write("Provide File Name, Dumbledick")
    fileRequested = read()
    if http.checkURL(gitHubRepositoryLink .. fileRequested) == true then
        if fs.exists("/"..fileRequested) == true then
         print("request checks out")
        else
            print("File does not exist, try add instead")
        end
    else
        print(fileRequested .. " was not found")
    end
end

local selection = ""
term.write("Add or Update?: ")
selection = read()

if selection == "Add" or selection == "add" then
    addSoftware()
elseif selection == "Update" or selection == "update" then
    updateSoftware()
else
    print(selection .. "Is an invalid argument")
end