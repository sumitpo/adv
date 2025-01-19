require "common.utils"
local love = require("love")

CharLoader = {chars2Imgs = {}}

local rootdir = "396765/"
local characterPath = "1_Main_Characters/"
local charName2Path = {human = "1/", robot = "2/", fox = "3/"}

local function load_image_safely(filename)
    local info = love.filesystem.getInfo(filename)

    if info then
        return love.graphics.newImage(filename)
    else
        local errorStr = string.format("Error: Image file %s does not exists",
                                       filename)
        print(errorStr)
        return nil
    end
end

local function splitImgs(origin_img)
    local frameW = 32
    local frameH = 32
    local imgWidth = origin_img:getWidth()
    local imgHeight = origin_img:getHeight()
    local assets = {}
    assets["_img"] = origin_img
    local quad = {}
    for y = 0, imgHeight - frameH, frameH do
        for x = 0, imgWidth - frameW, frameW do
            table.insert(quad, love.graphics
                             .newQuad(x, y, frameW, frameH, imgWidth, imgHeight))
        end
    end
    assets["_quads"] = quad
    return assets
end

function CharLoader:loadAllCharacters()
    print("in load all _Main_Characters")
    for name, path in pairs(charName2Path) do
        local charPath = rootdir .. characterPath .. path
        self.chars2Imgs[name] = self:loadOneCharacter(charPath)
    end
end

function CharLoader:loadOneCharacter(path)
    local act2img = {}
    local files = ListDirectory(path)
    for i, name in ipairs(files) do
        local filepath = path .. name
        local basename = name:match("^(.-)%.%w+$")
        act2img[basename] = splitImgs(load_image_safely(filepath))
    end
    return act2img
end

function CharLoader:getCharacter(name)
    if self.chars2Imgs[name] == nil then
        print(string.format("character %s not exists", name))
        return {}
    end
    return self.chars2Imgs[name]
end
