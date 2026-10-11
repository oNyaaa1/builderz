local ROOT = "builder_bs/"
local sharedFiles = {"core/sh_von_config.lua","core/sv_chat.lua"}
local serverFiles = {"core/sv_core.lua", "modules/sv_core.lua",}
local clientFiles = {"core/cl_tutorial.lua","core/cl_sound.lua","core/cl_nets.lua"}
if SERVER then
    for _, path in ipairs(sharedFiles) do
        AddCSLuaFile(ROOT .. path)
    end

    for _, path in ipairs(clientFiles) do
        AddCSLuaFile(ROOT .. path)
    end
end

for _, path in ipairs(sharedFiles) do
    include(ROOT .. path)
end

if SERVER then
    for _, path in ipairs(serverFiles) do
        include(ROOT .. path)
    end
else
    for _, path in ipairs(clientFiles) do
        include(ROOT .. path)
    end
end