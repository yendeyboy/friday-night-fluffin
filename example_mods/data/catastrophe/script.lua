local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then 
		startDialogue('dialogue');
	end
end

local seen = false 
function onEndSong()
	if not seen and isStoryMode then
		startVideo('OutroRaymond')
		seen = true;
		return Function_Stop;
	end
	return Function_Continue;
end
