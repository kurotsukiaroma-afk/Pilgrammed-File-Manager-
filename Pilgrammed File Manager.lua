--[[
Discord: themaloooo
--]]

-- Load Mercury UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer

-- Remote references
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local LoadDataRemote = Remotes:WaitForChild("LoadData")
local EraseRemote = Remotes:WaitForChild("Erase")

-- Create GUI
local gui = Library:create{
    Theme = Library.Themes.Serika
}

-- Notification function
local function Notify(title, content)
    gui:prompt{
        Title = title,
        Text = content,
        Buttons = {
            Ok = function() end
        }
    }
end

-- Load/Create File (Loads data into a slot)
local function loadFile(fileNumber)
    local args = {fileNumber}
    LoadDataRemote:InvokeServer(unpack(args))
    Notify("File Manager", "Loaded File " .. fileNumber)
    print("Loaded File " .. fileNumber)
end

-- Erase File
local function eraseFile(fileNumber)
    local args = {fileNumber}
    EraseRemote:FireServer(unpack(args))
    Notify("File Manager", "Erased File " .. fileNumber)
    print("Erased File " .. fileNumber)
end

-- ==============================================
-- SAVE FILES TAB
-- ==============================================
local FilesTab = gui:tab{
    Icon = "rbxassetid://6034996695",
    Name = "Save Files"
}

-- Create file slots 1-5
for i = 1, 5 do
    local fileSection = FilesTab:section{
        Name = "File Slot " .. i
    }
    
    fileSection:button({
        Name = "Load File " .. i,
        Callback = function()
            loadFile(i)
        end
    })
    
    fileSection:button({
        Name = "Erase File " .. i,
        Callback = function()
            eraseFile(i)
        end
    })
end

-- ==============================================
-- QUICK ACTIONS TAB
-- ==============================================
local QuickTab = gui:tab{
    Icon = "rbxassetid://6034996695",
    Name = "Quick Actions"
}

local quickSection = QuickTab:section{
    Name = "Quick File Operations"
}

quickSection:button({
    Name = "Load All Files (1-5)",
    Callback = function()
        for i = 1, 5 do
            loadFile(i)
            wait(0.2)
        end
        Notify("File Manager", "Loaded all files 1-5")
    end
})

quickSection:button({
    Name = "Erase All Files (1-5)",
    Callback = function()
        for i = 1, 5 do
            eraseFile(i)
            wait(0.2)
        end
        Notify("File Manager", "Erased all files 1-5")
    end
})

quickSection:button({
    Name = "Load File 1",
    Callback = function()
        loadFile(1)
    end
})

quickSection:button({
    Name = "Erase File 1",
    Callback = function()
        eraseFile(1)
    end
})

quickSection:button({
    Name = "Load File 3",
    Callback = function()
        loadFile(3)
    end
})

quickSection:button({
    Name = "Erase File 3",
    Callback = function()
        eraseFile(3)
    end
})

-- ==============================================
-- INFO TAB
-- ==============================================
local InfoTab = gui:tab{
    Icon = "rbxassetid://6034996695",
    Name = "Info"
}

local infoSection = InfoTab:section{
    Name = "About"
}

infoSection:button({
    Name = "Show Info",
    Callback = function()
        gui:prompt{
            Title = "Pilgrammed File Manager",
            Text = "Use this script to manage your save files.\n\n- Load: Loads data into the selected file slot\n- Erase: Deletes the selected file slot\n\nFiles available: 1 through 5\n\nMade by: Themalo\nDiscord: themaloooo",
            Buttons = {
                Ok = function() end
            }
        }
    end
})

infoSection:button({
    Name = "Check Remotes",
    Callback = function()
        print("Checking remotes...")
        for _, child in pairs(Remotes:GetChildren()) do
            print("Remote found:", child.Name)
        end
        Notify("Info", "Check F9 console for remote names")
    end
})

infoSection:button({
    Name = "Discord: themaloooo",
    Callback = function()
        Notify("Creator", "Discord: themaloooo")
    end
})

-- ==============================================
-- SETTINGS TAB
-- ==============================================
local SettingsTab = gui:tab{
    Icon = "rbxassetid://6034996695",
    Name = "Settings"
}

local settingsSection = SettingsTab:section{
    Name = "UI Settings"
}

settingsSection:dropdown({
    Name = "Theme",
    Description = "Change the UI theme",
    StartingText = "Serika",
    Items = {
        "Serika",
        "Dark",
        "Light"
    },
    Callback = function(v)
        if v == "Serika" then
            gui:set_theme(Library.Themes.Serika)
        elseif v == "Dark" then
            gui:set_theme(Library.Themes.Dark)
        elseif v == "Light" then
            gui:set_theme(Library.Themes.Light)
        end
        Notify("Settings", "Theme changed to " .. v)
    end
})

settingsSection:button({
    Name = "Close UI",
    Callback = function()
        gui:close()
    end
})

-- Set status
gui:set_status("Pilgrammed File Manager")

print("Pilgrammed File Manager Loaded!")
print("Made by Themalo - Discord: themaloooo")
print("Load File X - Loads data into file slot X")
print("Erase File X - Deletes file slot X")
