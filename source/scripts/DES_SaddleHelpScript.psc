Scriptname DES_SaddleHelpScript extends ReferenceAlias  

bool property SaddleTutorial auto
bool property ArmorTutorial auto
bool property BarebackTutorial auto
keyword property DES_SaddleKeyword auto
keyword property DES_ArmorKeyword auto
Quest property DES_HorseCallTutorialTracker auto

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	IF akBaseItem.HasKeyword(DES_SaddleKeyword)
		IF (DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).ShowTutorials && !SaddleTutorial
			while Utility.IsInMenuMode()
				utility.wait(0.1)
			endwhile
			utility.wait(1)
			HelpMessages[0].ShowAsHelpMessage("HorseSaddleTutorial", messageDuration, 1.0, 1)
			Utility.wait(messageDuration + messageInterval + 0.1)
				IF !BarebackTutorial && game.GetPlayersLastRiddenHorse().GetNumItems() == 0
					HelpMessages[2].ShowAsHelpMessage("HorseBarebackTutorial", messageDuration, 1.0, 1)
					BarebackTutorial = true
				ENDIF
			SaddleTutorial = true
			IF (DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).HorseCallTutorial && SaddleTutorial && ArmorTutorial && BarebackTutorial || !(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).ShowTutorials
				GetOwningQuest().Stop()
			ENDIF
		ENDIF
	ELSEIF akBaseItem.HasKeyword(DES_ArmorKeyword)
		IF (DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).ShowTutorials && !ArmorTutorial
			while Utility.IsInMenuMode()
				utility.wait(0.1)
			endwhile
			utility.wait(1)
			HelpMessages[1].ShowAsHelpMessage("HorseArmorTutorial", messageDuration, 1.0, 1)
			Utility.wait(messageDuration + messageInterval + 0.1)
				IF !BarebackTutorial && game.GetPlayersLastRiddenHorse().GetNumItems() == 0
					HelpMessages[2].ShowAsHelpMessage("HorseBarebackTutorial", messageDuration, 1.0, 1)
					BarebackTutorial = true
				ENDIF
			ArmorTutorial = true
			IF (DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).HorseCallTutorial && SaddleTutorial && ArmorTutorial && BarebackTutorial || !(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).ShowTutorials
				GetOwningQuest().Stop()
			ENDIF
		ENDIF
	ENDIF
ENDEVENT