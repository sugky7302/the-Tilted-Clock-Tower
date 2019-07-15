require 'filesystem'
local MAP_NAME = 'TheTiltedClockTower.w3x'  -- 請改為您的地圖名稱
local registry = require 'registry'
local ydwe = require 'tools.ydwe'
local process = require 'process'
if not ydwe then
    return
end

local function get_debugger()
    local path = fs.path(os.getenv('USERPROFILE')) / '.vscode' / 'extensions'
    for extpath in path:list_directory() do
        if fs.is_directory(extpath) and extpath:filename():string():sub(1, 20) == 'actboy168.lua-debug-' then
            local dbgpath = extpath / 'windows' / 'x86' / 'debugger.dll'
            if fs.exists(dbgpath) then
                return dbgpath
            end
        end
    end
end

local root = fs.path(arg[1])
if not fs.exists(root / MAP_NAME) then
    print('地圖不存在', root / MAP_NAME)
    return
end
local command = (registry.open [[HKEY_CURRENT_USER\SOFTWARE\Classes\YDWEMap\shell\run_war3\command]])['']
command = command:gsub("%%1", (root / MAP_NAME):string())
if get_debugger() then
    --command = command .. ' -debugger 4278'
end
print(command)
local p = process()
if p:create(nil, command, nil) then
    p:close()
end

