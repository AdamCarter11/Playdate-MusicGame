local pd <const> = playdate
local gfx <const> = pd.graphics

class('PenBorder').extends(gfx.sprite)

function PenBorder:init(x, y, length, startAng, endAng, speed)
    --playdate.graphics.drawArc(x, y, radius, startAngle, endAngle)
    gfx.setColor(gfx.kColorBlack)
    gfx.drawArc(x, y, length, math.pi/2, math.pi)

    --playdate.graphics.drawSineWave(startX, startY, endX, endY, 
    --  startAmplitude, endAmplitude, period, [phaseShift])
    -- startAng = startAmplitude
    -- endAng = endAmplitude
    -- speed = period
    -- NOTE: phaseShift might be interesting for variation
    -- NOTE: length/#, where # can be a peak or valley in regards to tempo
    --gfx.drawSineWave(x, y, x + length, y + length, startAng, endAng, length/3)

    self.speed = speed
    self:moveTo(200,120)
    self:add()
end

function PenBorder:update()
    --self:moveBy(-self.speed, 0)
end

