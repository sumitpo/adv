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
    class.posx = 16
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
    if ret >= limit - 16 then ret = limit - 16 end
    if ret < 16 then ret = 16 end
    return ret
end

function Player:moveUpdate(key, w, h)
    local last_direction = self.direction
    print("player in move update")
    print(w)
    if key == "dpright" or key == "right" then
        self.move = "Run"
        self.direction = "right"
        if last_direction == self.direction then
            self.posx = box(self.posx + self.speed, w)
        else
            self.posx = self.posx - 16
        end
    elseif key == "dpleft" or key == "left" then
        self.move = "Run"
        self.direction = "left"
        if last_direction == self.direction then
            self.posx = box(self.posx - self.speed, w)
        else
            self.posx = self.posx + 16
        end
    elseif key == "dpup" or key == "up" then
        self.move = "Run"
        self.direction = "up"
        if last_direction == self.direction then
            self.posy = box(self.posy - self.speed, h)
        end
    elseif key == "dpdown" or key == "down" then
        self.move = "Run"
        self.direction = "down"
        if last_direction == self.direction then
            self.posy = box(self.posy + self.speed, h)
        end
    end
end

function Player:moveStop(key) self.move = "Idle" end

function Player:status()
    print(string.format("name: %s, [%d, %d]", self.name, self.posx, self.posy))
end
function Player:attack() end
-- return Player
