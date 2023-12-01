local pd <const> = playdate
local gfx <const> = pd.graphics
local snd <const> = pd.sound

--#region Notes on Crank input
-- We care about using:
--   getCrankPosition() - for float position from range 0-359.9999
--      as the crank changes from starting position to clockwise
--      rotation back to starting position
--   getCrankChange() - returns 2 values:
--    change: represents the angle change (in degrees) of the 
--      crank since the last time this function (or the 
--      playdate.cranked() callback) was called. 
--      Negative values are anti-clockwise.
--    acceleratedChange is change multiplied by a value that 
--      increases as the crank moves faster, similar to the way
--      mouse acceleration works.
--#endregion

class('Pen').extends(gfx.sprite)

function Pen:init(x, y, moveSpeed, yMax, yMin)
    local penImage = gfx.image.new("Sprites/Pointer")
    self:setImage(penImage)
    self:setCollideRect(0, 0, self:getSize())

    self.x = x
    self.y = y
    self.currentCrankAngle = math.rad(pd.getCrankPosition())
    self.moveSpeed = moveSpeed
    self.yMax = yMax
    self.yMin = yMin

    --self.crankSynth = snd.synth.new(snd.kWaveSquare)

    self:moveTo(x, y)
    self:add()
end

function Pen:update()
    -- Get current crank position
    crankAngle = math.rad(pd.getCrankPosition())

    -- Call sound gen function

    -- Only move up or down
    -- self.tempX += math.sin(crankAngle) * self.moveSpeed
    self.y -= math.cos(crankAngle) * self.moveSpeed

    -- Internal collision
    if self.y < self.yMin and self.y > self.yMax then
        self:moveTo(self.x, self.y)
        --Pen:playCrankSound()
    elseif self.y >= self.yMin then
        -- Manual clamp
        self.y = math.max(self.yMin, math.min(self.yMax, self.y))
    elseif self.y <= self.yMax then
        self.y = math.min(self.yMax, math.max(self.yMin, self.y))
    end
end

--TODO
--#region
-- playCrankSound()
-- produce a sound based on the position, angle of change,
-- and direction of the crank
function Pen:playCrankSound()
    local crankAngle = math.rad(pd.getCrankPosition())
    local crankChange, crankDirection = pd.getCrankChange()

    self.crankSynth.playNote(crankAngle)
end
--#endregion