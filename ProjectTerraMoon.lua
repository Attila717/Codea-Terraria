
--# Main
-- Project Terra Moon

function setup()
    
    Constants:init()
    WorldGen:NewWorld("World", vec2(worlddepth, worldwidth))
    
end

function draw()
    
    background(0, 0, 0, 255)
    DrawWorld:Consistant()
    
end

function touched(touch)
    
    if touch.state == BEGAN then
        WorldGen:NewWorld("World", vec2(worlddepth, worldwidth))
        WorldGen:LoadWorld("World")
    end
    
end

--# Constants
Constants = class()

function Constants:init()
    currentworld ="None"
    rectMode(CORNER)
    
    worlddepth = 100
    worldwidth = 100
    
    parameter.watch("currentworld")
    
end

--# WorldGen
WorldGen = class()

function WorldGen:init()
    
end

function WorldGen:NewWorld(name, size)
    local worldtable = {}
    for row = 1, size.x do
        table.insert(worldtable, {})
        for column = 1, size.y do
            if column > 50 then
                table.insert(worldtable[row], 1)
            elseif column <= 50 and column >= 49 then
                if column == 50 then 
                    if worldtable[row][49] == 2 then
                        table.insert(worldtable[row], math.random(1,2))
                    end
                else
                    table.insert(worldtable[row], math.random(1,2))
                end
            else
                table.insert(worldtable[row], 2)
            end
        end
    end
    local tempjson = json.encode(worldtable)
    saveText("Project:"..name, tempjson)
end

function WorldGen:LoadWorld(name)
    currentworldtable = json.decode(readText("Project:"..name))
    currentworld = name
    --[[
    for i,v in pairs(currentworldtable) do
        for u,y in pairs(v) do
            if y == 1 then
                fill(255, 0, 0, 255)
                rect(i, u, 2, 2)
            else
                fill(54, 255, 0, 255)
                rect(i, u, 2, 2)
            end
        end
    end
      ]]
end
--# DrawWorld
DrawWorld = class()

function DrawWorld:init()
    
end

function DrawWorld:Consistant()
    if currentworldtable then
        for i,v in pairs(currentworldtable) do
            for u,y in pairs(v) do
                if y == 1 then
                    fill(0, 116, 255, 255)
                    rect((i*10)-11.5, (u*10)-11.5, 11.5, 11.5)
                else
                    fill(52, 139, 28, 255)
                    rect((i*10)-11.5, (u*10)-11.5, 11.5, 11.5)
                end
            end
        end
    end
end
--# TestCode
    --local namechunk = loadstring(name.."={}")
    --namechunk()

    -- This is a test of json table saving and interpreting 
    
    --[[
    test = {
    {3,4},
    {12,13} 
    }
    
    for i,v in pairs(test) do
        for o,x in pairs(v) do
            print(x)
        end
    end
    
    local str = json.encode(test)

    saveText("Project:data", str)
    newtable = json.decode(readText("Project:data"))
    
    for e,r in pairs(newtable) do
        for q,w in pairs(r) do
            print(e)
            print(w)
        end
    end
      ]]
