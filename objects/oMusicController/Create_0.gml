/// @desc 

global.audioTick = false;
global.audioBeat = 0;
coreEffectPulse = 0;
global.coreEffectTime = 0;
music = audio_play_sound(mMusic, 1, true);
lastTick = 0;
lastBar = 0;

wallPulseType = 0;
wallPulseColor = c_red;