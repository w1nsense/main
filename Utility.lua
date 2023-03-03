local table = {
    ["CountElapsedTime"] = function()
        local ServerTimer=game:GetService("Workspace").DistributedGameTime
        local seconds=math.floor(ServerTimer%60);
        local minutes=math.floor(ServerTimer/60%60);
        local hours=math.floor(ServerTimer/3600);
        hours = hours < 10 and '0' .. hours or hours;
        seconds = seconds < 10 and '0' .. seconds or seconds;
        minutes = minutes < 10 and '0' .. minutes or minutes;
        return hours .. ":" .. minutes .. ":" .. seconds
    end,
    ["CountPlayers"] = function()
        return #game:GetService("Players"):GetPlayers() -- yes that simple dimple
    end,
    ["CountFPS"] = function()
        return game:GetService("Workspace"):GetRealPhysicsFPS()
    end,
    ["CountPing"] = function()
        return math.round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())
    end
}

return table
