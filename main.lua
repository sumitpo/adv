require("logic.player")
require("logic.init")
require("loadAsset.charLoader")
require("loadAsset.background")

local love = require("love")
local socket = require("socket")

State = {
    playerState = Player:new(),
    dtotal = 0,
    timeInterval = 0.06,
    w = 0,
    h = 0
}

function love.load()
    local joysticks = love.joystick.getJoysticks()
    Joystick = joysticks[1]
    print("load love")
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    State.playerState.w = w
    State.playerState.h = h
    CharLoader:loadAllCharacters()
    BgLoader:loadBg()
end

function love.update(dt)
    State.dtotal = State.dtotal + dt
    if State.dtotal < State.timeInterval then return end
    State.dtotal = 0
    State.playerState:idleUpdate()
    if not Joystick then return end
    local buttons = {"dpright", "dpleft", "dpup", "dpdown"}
    for _, v in ipairs(buttons) do
        if Joystick:isGamepadDown(v) then
            State.playerState:moveUpdate(v, State.playerState.w,
                                         State.playerState.h)
            break
        end
    end

    if gameIsPaused then return end
end

function love.keypressed(key, unicode)
    local buttons = {
        "right", "left", "up", "down", "dpright", "dpleft", "dpup", "dpdown"
    }
    for _, v in ipairs(buttons) do
        if v == key then
            State.playerState:moveUpdate(key, State.playerState.w,
                                         State.playerState.h)
        end
    end
    print(string.format("user at %d %d", State.playerState.posx,
                        State.playerState.posy))
end

function love.keyreleased(key, unicode)
    local buttons = {
        "right", "left", "up", "down", "dpright", "dpleft", "dpup", "dpdown"
    }
    for _, v in ipairs(buttons) do
        if v == key then State.playerState:moveStop(key) end
    end
end

function love.focus(f) gameIsPaused = not f end

function love.gamepadpressed(joystick, button)
    local buttons = {"dpright", "dpleft", "dpup", "dpdown"}
    for _, v in ipairs(buttons) do
        if v == button then
            State.playerState:moveUpdate(button, State.playerState.w,
                                         State.playerState.h)
        end
    end
end

function love.gamepadreleased(joystick, button)
    local buttons = {"dpright", "dpleft", "dpup", "dpdown"}
    for _, v in ipairs(buttons) do
        if v == button then State.playerState:moveStop(button) end
    end

    -- print(string.format("joystick %s %s pressed", joystick, button))
end

local function drawBg()
    local bgImg = BgLoader:getBg(1)
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    for i = 0, w, 32 do
        for j = 0, h, 32 do love.graphics.draw(bgImg, i, j) end
    end
end

function love.draw()
    drawBg()
    -- local currentTime = socket.gettime()
    -- print(string.format("love draw call in %s", currentTime))

    -- w, h = love.graphics.getWidth, love.graphics.getHeight
    -- love.graphics.print("Hello World", 0, 0)
    local playerImg = CharLoader:getCharacter(State.playerState.name)
    -- local idx = State.playerState.moveIdx % 7 + 1
    -- print(string.format("idx is %d", idx))
    -- State.playerState:status()
    local scalex = 1
    local scaley = 1
    local x = State.playerState.posx
    if State.playerState.direction == "left" then
        scalex = -1
        x = x + 16
    else
        scalex = 1
    end
    love.graphics.draw(playerImg[State.playerState.move]["_img"],
                       playerImg[State.playerState.move]["_quads"][State.playerState
                           .moveIdx], x, State.playerState.posy, 0, scalex,
                       scaley)
    Menu()
end

function love.quit() print("exit game") end
