local dialogueplay = true
local seen = false
function onStartCountdown()
	if not seen and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		startVideo('IntroRaymond')
		seen = true;
		dialogueplay = false;
		return Function_Stop;
	end
	if not dialogueplay then
		startDialogue('dialogue');
		dialogueplay = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function keyShit()
	setProperty('inCutscene', true);
end
