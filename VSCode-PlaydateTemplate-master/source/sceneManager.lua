
local pd <const> = playdate;
local gfx <const> = pd.graphics;

class('SceneManager').extends()
local transitioning = false

function SceneManager:init()
    
    transitionTime = 1000
    print(transitionTime)
end

function SceneManager:switchScene(scene,...)
    if  not transitioning then
        transitioning = true
        self.newScene = scene
        self.sceneArgs = ...
        self:startTransition()
    end
    
end

function SceneManager:loadNewScene()
    self:cleanupScene()
    self.newScene(self.sceneArgs)
end

function SceneManager:cleanupScene()
    
    gfx.sprite.removeAll()
    self:removeAllTimers()
    gfx.setDrawOffset(0,0)
end

-- Transition still has bugs need to figure out so it's not calling here.

function SceneManager:startTransition()
    transitionTimer = self:wipeTransition(0,400)

    transitionTimer.timerEndedCallback = function()
        self:loadNewScene()
        transitionTimer = self:wipeTransition(400,0)
        transitioning = false
    end
    
end


function SceneManager:wipeTransition(startValue, endValue)
    local transitionSprite = self:createTransitionSprite()

    transitionSprite:setClipRect(0,0,startValue,240)

    transitionTimer = pd.timer.new(transitionTime, startValue, endValue, pd.easingFunctions.inOutCubic)
    transitionTimer.updateCallback = function(timer)
        transitionSprite:setClipRect(0,0,timer.value,240)
    end
    return transitionTimer
end

function SceneManager:createTransitionSprite()
    local filledRect = gfx.image.new(400,240, gfx.kColorBlack)
    local transitionSprite = gfx.sprite.new(filledRect)
    transitionSprite:moveTo(200,120)
    transitionSprite:setZIndex(10000)
    transitionSprite:setIgnoresDrawOffset(true)
    transitionSprite:add()
    return transitionSprite
end


function SceneManager:removeAllTimers()
    local allTimers = pd.timer.allTimers()
    for _, timer in ipairs(allTimers) do
        timer:remove()
    end
end

function returnTransitionState()
    return transitioning
end