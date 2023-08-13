Scriptname DES_HorseCallTutorialTrackerScript extends Quest

Actor Property PlayerRef Auto
bool Property BSHorseshoeAdded auto
bool property HorseCallTutorial auto
bool Property ShowTutorials auto
Faction Property PlayerHorseFaction Auto
Formlist Property DES_HorseMiscItems auto
Formlist Property DES_ValidWorldspaces auto
GlobalVariable Property DES_PlayerOwnsHorse auto
LeveledItem Property DES_LItemMiscHostlerItems75 auto
LeveledItem Property DES_MinimumHostler auto
Quest Property ccBGSSSE034_WildHorsesQuest auto
Quest Property DES_HorseCallTutorialTracker auto
Quest Property DES_RenameHorseQuest auto
ReferenceAlias Property Alias_HorseQuestPlayer  auto
ReferenceAlias Property Alias_Player  auto
ReferenceAlias Property DES_RenameHorseQuestAlias auto

Message[] Property HelpMessages Auto
float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto

EVENT OnInit()
	DES_HorseCallTutorialTracker.RegisterForMenu("RaceSex Menu")
	ccBGSSSE034_WildHorsesQuest.SetStage(10)
	Alias_HorseQuestPlayer.AddInventoryEventFilter(DES_HorseMiscItems)
ENDEVENT

EVENT OnMenuClose(String MenuName)
	DES_RegisterKeyOnLoad OnLoadScript = Alias_Player as DES_RegisterKeyOnLoad
	IF MenuName == "RaceSex Menu"
		Form BSHeartland = Game.GetFormFromFile(0xA764B, "BSHeartland.esm") as Worldspace
		RegisterForAnimationEVENT(PlayerRef, "tailHorseDismount")
		DES_HorseCallTutorialTracker.UnregisterForMenu("RaceSex Menu")
		OnLoadScript.GetBaseCarryWeight()
		OnLoadScript.RegisterKey()
		IF Game.GetFormFromFile(0xA764B, "BSHeartland.esm")
			OnLoadScript.ImportCyrodiil()
		ENDIF
	ENDIF
ENDEVENT

EVENT OnAnimationEVENT(ObjectReference akSource, string AsEventName)
	;Debug.MessageBox("OnAnimationEVENT fired")
	IF (akSource == PlayerRef) && (AsEventName == "tailHorseDismount")
	Utility.Wait(3)
		IF !HorseCallTutorial
			IF game.getPlayersLastRiddenHorse().isinfaction(PlayerHorseFaction)
				ShowTutorials = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "ShowTutorials", True)
				IF ShowTutorials && (DES_RenameHorseQuest as DES_HorseCallScript).horsekey == 35
					HelpMessages[0].ShowAsHelpMessage("HorseCallTutorial", messageDuration, 1.0, 1)
					Utility.wait(messageDuration + messageInterval + 0.1)
					HelpMessages[1].ShowAsHelpMessage("HorseWaitTutorial", messageDuration, 1.0, 1)
					Utility.wait(messageDuration + messageInterval + 0.1)
					HelpMessages[2].ShowAsHelpMessage("HorseInventoryTutorial", messageDuration, 1.0, 1)
					Utility.wait(messageDuration + messageInterval + 0.1)
					HelpMessages[3].ShowAsHelpMessage("HorseFoodTutorial", messageDuration, 1.0, 1)
				ENDIF
				DES_PlayerOwnsHorse.SetValue(1)
				DES_HorseCallTutorialTracker.UnregisterForAnimationEVENT(PlayerRef, "tailHorseDismount")
				HorseCallTutorial = true
				(Alias_Player as DES_SaddleHelpScript).BarebackTutorial = true
				IF HorseCallTutorial && (Alias_Player as DES_SaddleHelpScript).SaddleTutorial && (Alias_Player as DES_SaddleHelpScript).ArmorTutorial && (Alias_Player as DES_SaddleHelpScript).BarebackTutorial || !ShowTutorials
					DES_HorseCallTutorialTracker.stop()
				ENDIF
			ENDIF
		ENDIF
	ENDIF
ENDEVENT