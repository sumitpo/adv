Player = {
    name = "robot",
    move = "Idle",
    direction = "left",
    moveIdx = 1,
    posx = 0,
    posy = 0
}
function Player:new()
    local class = {}
    setmetatable(class, self)
    self.__index = self
    class.name = "robot"
    class.move = "Idle"
    class.direction = "left"
    class.moveIdx = 1
    class.posx = 0
    class.posy = 0
    class.speed = 3
    return class
end
function Player:jump() end

function Player:idleUpdate()
    if self.move ~= "Idle" then return end
    self.moveIdx = self.moveIdx + 1
    if self.moveIdx == 7 then self.moveIdx = 1 end
end

local function box(x, limit)
    local ret = x
    if ret >= limit then ret = limit - 1 end
    if ret < 0 then ret = 0 end
    return ret
end

function Player:moveUpdate(key, w, h)
    local last_direction = self.direction
    -- print("player in move update")
    if key == "dpright" then
        self.move = "Run"
        self.direction = "right"
        if last_direction == self.direction then
            self.posx = box(self.posx + self.speed, w)
        end
    elseif key == "dpleft" then
        self.move = "Run"
        self.direction = "left"
        if last_direction == self.direction then
            self.posx = box(self.posx - self.speed, w)
        end
    elseif key == "dpup" then
        self.move = "Run"
        self.posy = box(self.posy - self.speed, h)
    elseif key == "dpdown" then
        self.move = "Run"
        self.posy = box(self.posy + self.speed, h)
    end
end

function Player:moveStop(key) self.move = "Idle" end

function Player:status()
    print(string.format("name: %s, [%d, %d]", self.name, self.posx, self.posy))
end
function Player:attack() end
-- return Player
