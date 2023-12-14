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

local yInterval = 20
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
    self:moveBy(-self.speed, 0)
    if self.x < -400 then
        self.x = 400
        self:moveTo(400, self.startingY)
    end
    i += 1

    self:DrawWaves(self.x, self.y, self.period)
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

function WaveSpawner:DrawWaves(x, y, period)
    local testSprite = gfx.image.new(400, 240)

    --calculate with respect to the penObject x-position and the wave length
    y1 = WaveSpawner:calculateSinY(x, period, self.amp) + PEN_BORDER_Y_MAX
    y2 = y1 + yInterval

    gfx.pushContext(testSprite)
        -- draw debug line
        --gfx.drawRect(self.penObject.x, y1, 800, 1)
        --gfx.drawRect(self.penObject.x, y2, 800, 1)
        -- draw sine waves
        --gfx.drawSineWave(x, y, x+400, y, self.amp, 1, period, i)
        --gfx.drawSineWave(x, y + yInterval, x+400, y + yInterval, self.amp, 0, period, i)
        gfx.drawSineWave(x, y, x + self.length, y, self.amp, self.amp, period, 0)
        gfx.drawSineWave(x, y + yInterval, x + self.length, y + yInterval, self.amp, self.amp, period, 0)
    gfx.popContext()
    --sprint(y1 .. ", " .. y2)

    self:setImage(testSprite)
end


-- isBetweenRange()
-- Gets the current waves' y positions at the Pen's x-point and returns true
-- if the player's Pen is in the y-range
function WaveSpawner:isBetweenRange(penObject)
    local inRange = false
    local penMiddle = self.penObject.y
    if self.penObject.x >= self.x - self.length/2 then
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
