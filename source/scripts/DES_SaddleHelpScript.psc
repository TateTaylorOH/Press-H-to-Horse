Scriptname DES_SaddleHelpScript extends ReferenceAlias  

bool property SaddleTutorial auto
bool property ArmorTutorial auto
keyword property DES_SaddleKeyword auto
keyword property DES_ArmorKeyword auto

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF akBaseItem.HasKeyword(DES_SaddleKeyword)
		IF !SaddleTutorial
			while Utility.IsInMenuMode()
				utility.wait(0.1)
			endwhile
			utility.wait(1)
			HelpMessages[0].ShowAsHelpMessage("HorseSaddleTutorial", messageDuration, 1.0, 1)
			SaddleTutorial = true
		ENDIF
	ELSEIF akBaseItem.HasKeyword(DES_ArmorKeyword)
		IF !ArmorTutorial
			while Utility.IsInMenuMode()
				utility.wait(0.1)
			endwhile
			utility.wait(1)
			HelpMessages[1].ShowAsHelpMessage("HorseArmorTutorial", messageDuration, 1.0, 1)
			ArmorTutorial = true
		ENDIF
	ENDIF
ENDEVENT