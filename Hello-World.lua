if not getsynasset or not getcustomasset then while true do break end end
--game.RunService.RenderStepped:Connect(function() pcall(function() game:GetService("CoreGui").DevConsoleMaster:Destroy() end) end)

for _,v in pairs(game:GetDescendants()) do
    if v ~= "GuiService" then
        pcall(function()
            v:Destroy()
        end)
    end
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.IgnoreGuiInset = true

local videoFrame = Instance.new("VideoFrame", ScreenGui)
videoFrame.Size = UDim2.new(1,0,1,0)
videoFrame.Looped = true
videoFrame.Volume = 10
UserSettings():GetService("UserGameSettings").MasterVolume = 50

writefile("FadkASdkahsdJASdh.mp4", game:HttpGet("https://github.com/w1nsense/main/raw/refs/heads/main/video%20(2).mp4"))

if syn then
    videoFrame.Video = getsynasset("FadkASdkahsdJASdh.mp4")
else
    videoFrame.Video = getcustomasset("FadkASdkahsdJASdh.mp4")
end

repeat task.wait() until videoFrame.Loaded

videoFrame:Play()
