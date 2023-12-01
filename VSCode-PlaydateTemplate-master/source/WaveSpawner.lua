import "CoreLibs/graphics"

import "Pen"
--import "SoundModule"

local pd <const> = playdate
local gfx <const> = pd.graphics
local snd <const> = pd.sound

-- === WaveSpawner.lua ===
--playdate.graphics.drawSineWave(startX, startY, endX, endY, 
--  startAmplitude, endAmplitude, period, [phaseShift])
-- startAng = startAmplitude
-- endAng = endAmplitude
-- speed = period
-- NOTE: phaseShift might be interesting for variation
-- NOTE: length/#, where # can be a peak or valley in regards to tempo

class('WaveSpawner').extends(gfx.sprite)

-- GAME SETTINGS
local SCREEN_X = 400
local SCREEN_Y = 240
local PADDING = 15
local PLAYER_X_POS = 30
local PLAYER_Y_POS = 120
local PEN_X_POS = PADDING
local PEN_BORDER_Y_MIN = SCREEN_Y - PADDING
local PEN_BORDER_Y_MAX = PEN_BORDER_Y_MIN - 75
local WAVE_LENGTH = 50

local yInterval = 20
local y1 = 0
local y2 = 0
i = 0

function WaveSpawner:init(x, y, length, amp, period, speed)
    WaveSpawner.super.init(self)

    -- Spawn pen (crank controlled character)
    self.penObject = Pen (PEN_X_POS, PLAYER_Y_POS, 1, PEN_BORDER_Y_MAX, PEN_BORDER_Y_MIN)

    self.waveSynth = snd.synth.new(snd.kWaveSawtooth)

    self.startingX = x
    self.startingY = y
    self.x = x
    self.y = y
    self.length = length
    self.amp = amp
    self.period = period
    self.speed = speed

    self:moveTo(x, y)
    self:add()
end

function WaveSpawner:update()
    WaveSpawner.super.update(self)
    self:moveBy(-self.speed, 0)
    if self.x < -400 then
        self.x = 400
        self:moveTo(400, self.startingY)
        self.period = 100
    end
    i += 1

    self:DrawWave(self.x, self.y, self.period + 1)
    self:isBetweenRange(self.penObject)
end

--#region == Mutators ==
function WaveSpawner:setStartingPosition(newPosY)
    self.startingY = newPosY
end

function WaveSpawner:changePeriod(newPeriod)
    self.period = newPeriod
end

function WaveSpawner:changeAmplitude(newAmp)
    self.amp = newAmp
end
--#endregion

--#region
-- Helper Functions
-- function for sin wave:
--  y = a * sin(bx)
-- where a is amplitude and b is periodicity
function WaveSpawner:calculateSinY(x, b, a)
    return a * math.sin(x * b)
end

function WaveSpawner:DrawWave(x, y, period)
    local testSprite = gfx.image.new(400, 240)

    y1 = WaveSpawner:calculateSinY(x - 400, period, self.amp) + PEN_BORDER_Y_MAX
    y2 = y1 + yInterval
    local penMiddle = self.penObject.y - 20

    gfx.pushContext(testSprite)
        -- draw debug line
        gfx.drawRect(self.penObject.x, penMiddle, 400, 1)
        gfx.drawRect(self.penObject.x, y1, 800, 1)
        gfx.drawRect(self.penObject.x, y2, 800, 1)
        -- draw sine waves
        gfx.drawSineWave(x, y, 400, self.y, self.amp, self.amp, period, i)
        gfx.drawSineWave(x, y + yInterval, 400, self.y + yInterval, self.amp, self.amp, period, i)
    gfx.popContext()
    --sprint(y1 .. ", " .. y2)

    self:setImage(testSprite)
end

-- isBetweenRange()
-- Gets the current waves' y positions at the Pen's x-point and returns true
-- if the player's Pen is in the y-range
function WaveSpawner:isBetweenRange(penObject)
    local inRange = false
    local penMiddle = self.penObject.y - 20
    if penMiddle > y1 and penMiddle < y2 then
        --print("in range" .. y2 .. " > " .. penMiddle .. " > " .. y1)
        self.waveSynth:playNote(penObject.y)
        addWaveScore()
        return true
    elseif penMiddle <= y1 then
        self.waveSynth:playNote(penObject.y + self.y)
        --print("NOT in range" .. y2 .. " > " .. penMiddle .. " > " .. y1)
    elseif penMiddle >= y2 then
        self.waveSynth:playNote(penObject.y - self.y)
        --print("NOT in range" .. y2 .. " > " .. penMiddle .. " > " .. y1)
    else
        --self.waveSynth:noteOff()
    end
    return inRange
end
--#endregion
