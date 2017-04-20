local applications
local GitHubUserUrl = "https://raw.githubusercontent.com/"
 
local function internetRequest(url)
  local success, response = pcall(component.internet.request, url)
  if success then
    local responseData = ""
    while true do
      local data, responseChunk = response.read()
      if data then
        responseData = responseData .. data
      else
        if responseChunk then
          return false, responseChunk
        else
          return true, responseData
        end
      end
    end
  else
    return false, reason
  end
end
 

local function getFromGitHubSafely(url, path)
  local success, reason = internetRequest(url)
  if success then
    fs.makeDirectory(fs.path(path) or "")
    fs.remove(path)
    local file = io.open(path, "w")
    file:write(reason)
    file:close()
    return reason
  else
    error("Can't download \"" .. url .. "\"!\n")
  end
end


print("Downloading file list")
applications = serialization.unserialize(getFromGitHubSafely(GitHubUserUrl .. "MrRagGame/Soft/master/robot/gather", "/opt/robo/gather"))
applications = serialization.unserialize(getFromGitHubSafely(GitHubUserUrl .. "MrRagGame/Soft/master/robot/gather", "/opt/robo/gather"))
print(" ")
 
for i = 1, #applications do
  if applications[i].preLoadFile then
    print("Downloading \"" .. fs.name(applications[i].name) .. "\"")
    getFromGitHubSafely(GitHubUserUrl .. applications[i].url, applications[i].name)
  end
end
 
print(" ")