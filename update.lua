local gitHubRepositoryLink = "https://https://www.github.com/TheBottomDweller/ComputerCraftScripts"



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