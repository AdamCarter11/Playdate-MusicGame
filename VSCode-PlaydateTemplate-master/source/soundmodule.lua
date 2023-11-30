local snd <const> = playdate.sound

class('SoundModule').extends()

local SoundModule = {}

-- define array of notes
local UDLR_notes = {
    "Sounds/TestNotes/Note_1",
    "Sounds/TestNotes/Note_2",
    "Sounds/TestNotes/Note_3",
    "Sounds/TestNotes/Note_4",
    "Sounds/TestNotes/Note_5",
    "Sounds/TestNotes/Note_6",
    "Sounds/TestNotes/Note_7",
    "Sounds/TestNotes/Note_8",
    "Sounds/TestNotes/Note_9",
    "Sounds/TestNotes/Note_10",
    "Sounds/TestNotes/Note_11",
    "Sounds/TestNotes/Note_12",
    "Sounds/TestNotes/Note_13",
    "Sounds/TestNotes/Note_14",
    "Sounds/TestNotes/Note_15",
    "Sounds/TestNotes/Note_16",
}
local game_notes = {
    "Sounds/bad miss",
    "Sounds/perfect",
}

local noteTable = {}

local abInstrument = snd.instrument.new()
local sampleInstrument = snd.instrument.new()

-- sound testing
-- Song Order: 1 --> 16
local s = snd.sequence.new('Sounds/currentTrack.mid')

-- pd.sound.channel.setVolume(0.5)
-- playNote format
--   pitch: Hertz values. 261.63 = C4, can also use string for Db3 (D flat 3)
--   volume: 0 to 1
--   length: in seconds if omitted, note will play until you call noteOff
--   when: seconds since the sound engine started, defaults to current time

-- pd.sound.synth:playMIDINote(C4, 1)

-- Synths only have a buffer of one note event, need to createa a sequence instead
--  to play over a period of time
-- pd.sound.synth:setWaveform(pd.sound.kWaveSine)
-- pd.sound.channel:addsource()
-- pd.sound.channel:addeffect()
-- pd.sound.getCurrentTime()
-- pd.sound.synth:playMIDINote(C4, 1)

function SoundModule:init()
    SoundModule.super.init(self)

    SoundModule:loadSamples()
    SoundModule:loadSequence()
end

function SoundModule:loadSamples()
    for i, name in ipairs(UDLR_notes) do
        noteTable["Note_"..i] = name
        -- add voice
        sampleInstrument:addVoice(newSampleSound(noteTable["Note_"..i]))
    end
    noteTable["Note_BadMiss"] = game_notes[1]
    noteTable["Note_Perfect"] = game_notes[2]
end

function SoundModule:loadSequence()
    for i=1, 16 do
        s:addTrack(UDLR_notes[i])
    end
end

function SoundModule:newSampleSound(filename)
    local sample = pd.sound.sample.new(filename)
    s:setVolume(0.2)
    s:setAttack(0)
    s:setDecay(0.15)
    s:setSustain(0.2)
    s:setRelease(0)
    return sample
end

function SoundModule:newSynth()
    local synth = snd.synth.new(snd.kWaveSawtooth)
    s:setVolume(0.2)
    s:setAttack(0)
    s:setDecay(0.15)
    s:setSustain(0.2)
    s:setRelease(0)
    return synth
end

function SoundModule:playSound(soundName, duration)
    print(noteTable[soundName])
end

function SoundModule:playWaveSound(penPosition, duration)
    waveSynth:playNote(penPosition, 1, duration)
end

function SoundModule:playSequence(time)
    local i = s:getTrackCount()
    local track = s:getTrackAtIndex(i)
    s:setTempo(2.5)
    s:setLoops(1, 16)
    s:playSequence()
    while (i < time) do
        i += 1
    end
        
end

return SoundModule
