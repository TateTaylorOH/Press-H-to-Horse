Scriptname DES_HorseCallTutorialTrackerScript extends Quest

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto
Quest Property DES_HorseCallTutorialTracker auto
Quest Property DES_RenameHorseQuest auto
Actor Property PlayerRef Auto
Faction Property PlayerHorseFaction Auto
Formlist Property DES_ValidWorldspaces auto
GlobalVariable Property DES_PlayerOwnsHorse auto

Event OnInit()
	DES_HorseCallTutorialTracker.RegisterForMenu("RaceSex Menu")
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "RaceSex Menu"
		RegisterForAnimationEvent(PlayerRef, "tailHorseDismount")
		;Debug.MessageBox("tailHorseDismount registered")
		DES_HorseCallTutorialTracker.UnregisterForMenu("RaceSex Menu")
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	;Debug.MessageBox("OnAnimationEvent fired")
	if (akSource == PlayerRef) && (asEventName == "tailHorseDismount")
	;Debug.MessageBox("PlayerRef dismounted")
	Utility.Wait(3)
		If game.getPlayersLastRiddenHorse().isinfaction(PlayerHorseFaction)
			(DES_RenameHorseQuest as DES_HorseCallScript).horsekey = papyrusinimanipulator.PullIntFromIni("Data/HorsesPlus.ini", "Hotkeys", "HorseCall", 35)
			DES_RenameHorseQuest.RegisterForKey((DES_RenameHorseQuest as DES_HorseCallScript).horsekey)
			;Debug.MessageBox("HorseKey registered")
			Form BSHeartland = Game.GetFormFromFile(0xA764B, "BSHeartland.esm") as Worldspace
			IF !DES_ValidWorldspaces.HasForm(BSHeartland)
				DES_ValidWorldspaces.AddForm(BSHeartland)
			ENDIF
			IF (DES_RenameHorseQuest as DES_HorseCallScript).horsekey == 35
				HelpMessages[0].ShowAsHelpMessage("HorseCallTutorial", messageDuration, 1.0, 1)
				Utility.wait(messageDuration + messageInterval + 0.1)
				HelpMessages[1].ShowAsHelpMessage("HorseWaitlTutorial", messageDuration, 1.0, 1)
			ENDIF
			DES_PlayerOwnsHorse.SetValue(1)
			DES_HorseCallTutorialTracker.UnregisterForAnimationEvent(PlayerRef, "tailHorseDismount")
			DES_HorseCallTutorialTracker.Stop()
		endif
	endif
ENDEVENT