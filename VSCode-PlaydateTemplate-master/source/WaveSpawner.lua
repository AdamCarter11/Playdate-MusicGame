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
local PEN_Y_POS = 220
local PEN_X_POS = 55
local PEN_BORDER_Y_MIN = 230
local PEN_BORDER_Y_MAX = 200
local turnOnWave = true
local yInterval = 8
y1 = 0
y2 = 0
i = 0

function WaveSpawner:init(x, y, length, amp, period, speed)
    WaveSpawner.super.init(self)

    -- Spawn pen (crank controlled character)
    self.penObject = Pen (PEN_X_POS, PEN_Y_POS, 1, PEN_BORDER_Y_MAX, PEN_BORDER_Y_MIN)

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
    -- if self.x < -25 and turnOnWave then
    --     self.x = 500
    --     self:moveTo(500, self.startingY)
    -- end
    i += 1

    if turnOnWave then
        if self.x > 410 then
            self.x = 350
            self:moveTo(350, self.startingY)
        end
        self:moveBy(-self.speed, 0)
        self:DrawWaves(self.x, self.y, self.period)
        self:isBetweenRange(self.penObject)
    else
        self.x = 700
        self:moveTo(700, self.startingY)
    end
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

function WaveSpawner:DrawWaves(x, y, period)
    --TOP LEFT: 43, 199
    --BOTTOM RIGHT: 357, 231
    -- W: 314, H: 32
    local testSprite = gfx.image.new(314, 64)

    --calculate with respect to the penObject x-position and the wave length
    y1 = WaveSpawner:calculateSinY(x, period, self.amp) + 215 - yInterval
    y2 = y1 + 2 * yInterval

    gfx.pushContext(testSprite)
        -- draw sine waves
        gfx.drawSineWave(x, 32 - yInterval, x + self.length, 32 - yInterval, self.amp, self.amp, period, 0)
        gfx.drawSineWave(x, 32 + yInterval, x + self.length, 32 + yInterval, self.amp, self.amp, period, 0)

        --gfx.drawSineWave(x, y, x + self.length, y, self.amp, self.amp, period, 0)
        --gfx.drawSineWave(x, y + yInterval, x + self.length, y + yInterval, self.amp, self.amp, period, 0)
    gfx.popContext()

    self:setImage(testSprite)
end


-- isBetweenRange()
-- Gets the current waves' y positions at the Pen's x-point and returns true
-- if the player's Pen is in the y-range
function WaveSpawner:isBetweenRange(penObject)
    local inRange = false
    local penMiddle = self.penObject.y
    if self.penObject.x >= self.x - self.length/3 then
        if penMiddle > y1 and penMiddle < y2 then
            print("in range " .. y2 .. " > " .. penMiddle .. " > " .. y1)
            --self.waveSynth:playNote(penObject.y)
            addWaveScore()
            return true
        elseif penMiddle <= y1 then
            --self.waveSynth:playNote(penObject.y + self.y)
            print("NOT in range " .. y2 .. " > " .. penMiddle .. " > " .. y1)
        elseif penMiddle >= y2 then
            --self.waveSynth:playNote(penObject.y - self.y)
            print("NOT in range " .. y2 .. " > " .. penMiddle .. " > " .. y1)
        else
            --self.waveSynth:noteOff()
        end
    end
    return inRange
end
--#endregion

function TurnOffWave()
    turnOnWave = false
    --self.x = 400
    --Bself:moveTo(400, self.startingY)
end

function TurnOnWave()
    --self.x = 400
    --Bself:moveTo(400, self.startingY)
    turnOnWave = true
end