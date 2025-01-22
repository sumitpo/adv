local love = require("love")
BgLoader = {bg2Img = {}}

local rootdir = "396765/"
local bgPath = "2_Locations/"
local bg = "Backgrounds/"
local tiles = "Tiles/"

function BgLoader:loadBg()
    local path = rootdir .. bgPath .. bg
    local files = ListDirectory(path)
    for _, name in ipairs(files) do
        local filepath = path .. name
        local basename = tonumber(name:match("^(.-)%.%w+$"))
        self.bg2Img[basename] = LoadImageSafely(filepath)
    end
end


function BgLoader:getBg(bgIdx)
    return self.bg2Img[bgIdx]
end