local gitHubRepositoryLink = "https://raw.githubusercontent.com/TheBottomDweller/ComputerCraftScripts/main/"

function addSoftware()
    local fileRequested = ""
    local url = ""
    term.write("Provide File Name: ")
    fileRequested = read()
    if http.checkURL(gitHubRepositoryLink .. fileRequested) == true then
        url = (gitHubRepositoryLink .. fileRequested)
        http.get(url).readAll()
    else
        print(fileRequested .. " doesn't exist, fuckhead")
    end
end

function updateSoftware()
    local fileRequested = ""
    term.write("Provide File Name, Dumbledick")
    fileRequested = read()
    if http.checkURL(gitHubRepositoryLink .. fileRequested) == true then
        print("request checks out")
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