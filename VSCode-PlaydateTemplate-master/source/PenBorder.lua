import "CoreLibs/graphics"
local pd <const> = playdate
local gfx <const> = pd.graphics

class('PenBorder').extends(gfx.sprite)
local newPer = 60
i = 0
function PenBorder:init(x, y, length, startAng, endAng, speed)
    --playdate.graphics.drawArc(x, y, radius, startAngle, endAngle)
    gfx.setColor(gfx.kColorBlack)
    -- gfx.drawArc(x, y, length, math.pi/2, math.pi)

    --playdate.graphics.drawSineWave(startX, startY, endX, endY, 
    --  startAmplitude, endAmplitude, period, [phaseShift])
    -- startAng = startAmplitude
    -- endAng = endAmplitude
    -- speed = period
    -- NOTE: phaseShift might be interesting for variation
    -- NOTE: length/#, where # can be a peak or valley in regards to tempo

    
    -- local test = gfx.drawSineWave(50, 120, 300, 120, 45, 90, 5)
    self.x = x
    self.y = y
    self:DrawWave(x, y, 60)
    self.speed = speed
    self:moveTo(200,120)
    print("boarder init")
    

    self:add()
end

function PenBorder:DrawWave(x, y, period)
    local testSprite = gfx.image.new(400, 240)
    gfx.pushContext(testSprite)
        --gfx.fillRoundRect(0, 0, 50, 50, 10)
        -- gfx.drawArc(0, 0, 50, 0, math.pi / 2)
        --gfx.fillRect(0,0,50, 25)
        gfx.drawSineWave(self.x, self.y, 400, self.y, 100, 50, period, i)
    gfx.popContext()
    self:setImage(testSprite)
end
function PenBorder:update()
    -- self:moveBy(-self.speed, 0)
    crankAngle = math.rad(pd.getCrankPosition())

    -- Only move up or down
    -- self.tempX += math.sin(crankAngle) * self.moveSpeed
    --newPer += math.abs(math.cos(crankAngle) * 2
    i += 1
    self:DrawWave(self.x, self.y, newPer)
end

