lib_gen = lib_gen or {}
if SERVER then
    resource.AddFile("materials/libnya/library_logo.png")
end
local function add_filessh(dir)
    local files, folders = file.Find(dir .. "*", "LUA")
    for _, file_name in pairs(files) do
        if SERVER then AddCSLuaFile(dir .. file_name) end
        include(dir .. file_name)
        print("[LibGeneration] Shared: " .. dir .. file_name)
    end

    for _, folder_name in pairs(folders) do
        add_filessh(dir .. folder_name .. "/")
    end
end

local function add_filessv(dir)
    local files, folders = file.Find(dir .. "*", "LUA")
    for _, file_name in pairs(files) do
        if SERVER then
            include(dir .. file_name)
            print("[LibGeneration] Server: " .. dir .. file_name)
        end
    end

    for _, folder_name in pairs(folders) do
        add_filessv(dir .. folder_name .. "/")
    end
end

local function add_files(dir)
    local files, folders = file.Find(dir .. "*", "LUA")
    for _, file_name in pairs(files) do
        if SERVER then AddCSLuaFile(dir .. file_name) end
        if CLIENT then
            include(dir .. file_name)
            print("[LibGeneration] Client: " .. dir .. file_name)
        end
    end

    for _, folder_name in pairs(folders) do
        add_files(dir .. folder_name .. "/")
    end
end

add_filessh("lib_gen/core/libs/")
add_files("lib_gen/core/vgui/")
add_filessh("lib_gen/core/shared/")
add_filessv("lib_gen/core/server/")
add_files("lib_gen/core/client/")
