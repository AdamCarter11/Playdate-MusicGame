import "CoreLibs/graphics"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('WaveSpawner').extends(gfx.sprite)

local newPer = 100
local yInterval = 50
i = 0

function WaveSpawner:init(x, y, length, startAng, endAng, speed)
    --playdate.graphics.drawArc(x, y, radius, startAngle, endAngle)
    --gfx.setColor(gfx.kColorBlack)
    --gfx.drawArc(x, y, length, math.pi/2, math.pi)

    --playdate.graphics.drawSineWave(startX, startY, endX, endY, 
    --  startAmplitude, endAmplitude, period, [phaseShift])
    -- startAng = startAmplitude
    -- endAng = endAmplitude
    -- speed = period
    -- NOTE: phaseShift might be interesting for variation
    -- NOTE: length/#, where # can be a peak or valley in regards to tempo
    
    -- local test = gfx.drawSineWave(50, 120, 300, 120, 45, 90, 5)
    self.startingX = x
    self.startingY = y
    self.x = x
    self.y = y
    self.length = length
    self.startAng = startAng
    self.endAng = endAng
    self.speed = speed
    --self:DrawWave(x, y, 60)

    self:moveTo(200,120)
    self:add()
end

function WaveSpawner:DrawWave(x, y, period)
    local testSprite = gfx.image.new(400, 240)
    gfx.pushContext(testSprite)
        --gfx.fillRoundRect(0, 0, 50, 50, 10)
        -- gfx.drawArc(0, 0, 50, 0, math.pi / 2)
        --gfx.fillRect(0,0,50, 25)
        gfx.drawSineWave(x, y, 400, self.y, 5, 5, period, i)
        gfx.drawSineWave(x, y + yInterval, 400, self.y + yInterval, 5, 5, period, i)
    gfx.popContext()
    self:setImage(testSprite)
end
function WaveSpawner:update()
    self:moveBy(-self.speed, 0)
    --crankAngle = math.rad(pd.getCrankPosition())
    --newPer = math.rad(pd.getCrankPosition())
    -- Only move up or down
    -- self.tempX += math.sin(crankAngle) * self.moveSpeed
    --newPer += math.abs(math.cos(crankAngle) * 2
    if self.x < -400 then
        self.x = 400
        self:moveTo(400, self.y)
    end
    i += 1
    self:DrawWave(self.x, self.y, newPer + 1)
end

--TODO
--#region == Accesors ==
-- getYRange()
-- Returns the lower y-value first and the greater y-value second
-- between the current sine waves
function WaveSpawner:getCurrentYRange()
    return self.startingY, self.startingY + yInterval
end
--#endregion

--#region == Mutators ==
function WaveSpawner:setStartingPosition(newPos)
    if self.x < -400 then
        self.x = newPos
        self:moveTo(400, self.y)
        return true
    else
        return false
    end
end

function WaveSpawner:changePeriod()
    
end

function WaveSpawner:changeAmplitude()
    
end

function WaveSpawner:changeWavePeriod()
    
end
--#endregion