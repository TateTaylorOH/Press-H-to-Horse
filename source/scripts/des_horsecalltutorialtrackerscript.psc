Scriptname DES_HorseCallTutorialTrackerScript extends Quest

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto
Quest Property DES_HorseCallTutorialTracker auto
Quest Property DES_RenameHorseQuest auto
Quest Property ccBGSSSE034_WildHorsesQuest auto
Actor Property PlayerRef Auto
Faction Property PlayerHorseFaction Auto
Formlist Property DES_ValidWorldspaces auto
GlobalVariable Property DES_PlayerOwnsHorse auto
bool property HorseCallTutorial auto
ReferenceAlias Property Alias_Player  auto
bool Property ShowTutorials auto
LeveledItem Property DES_LItemMiscHostlerItems75 auto
LeveledItem Property DES_MinimumHostler auto
bool Property DwarvenHorseEquipped auto
bool Property BSHorseshoeAdded auto
ReferenceAlias Property DES_RenameHorseQuestAlias auto

Event OnInit()
	DES_HorseCallTutorialTracker.RegisterForMenu("RaceSex Menu")
	ccBGSSSE034_WildHorsesQuest.SetStage(10)
EndEvent

Event OnMenuClose(String MenuName)
	MiscObject BSHorseshoe = Game.GetFormFromFile(0x723B8, "BSHeartland.esm") As MiscObject
	If MenuName == "RaceSex Menu"
		RegisterForAnimationEvent(PlayerRef, "tailHorseDismount")
		DES_HorseCallTutorialTracker.UnregisterForMenu("RaceSex Menu")
		IF !DwarvenHorseEquipped == true
			Actor DwarvenHorse = Game.GetFormFromFile(0x38D5, "cctwbsse001-puzzledungeon.esm") As Actor
			(DES_RenameHorseQuest as DES_HorseInventoryScript).FirstTimeEquipHorse(DwarvenHorse)
			DwarvenHorseEquipped = true
			DES_RenameHorseQuestAlias.Clear()
		ENDIF
		DES_MinimumHostler.AddForm(BSHorseshoe, 1, 4)
		DES_LItemMiscHostlerItems75.AddForm(BSHorseshoe, 1, 4)
		BSHorseshoeAdded = true
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	;Debug.MessageBox("OnAnimationEvent fired")
	if (akSource == PlayerRef) && (asEventName == "tailHorseDismount")
	Utility.Wait(3)
		IF !HorseCallTutorial
			If game.getPlayersLastRiddenHorse().isinfaction(PlayerHorseFaction)
				(DES_RenameHorseQuest as DES_HorseCallScript).horsekey = papyrusinimanipulator.PullIntFromIni("Data/H2Horse.ini", "General", "HorseKey", 35)
				ShowTutorials = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "ShowTutorials", True)
				DES_RenameHorseQuest.RegisterForKey((DES_RenameHorseQuest as DES_HorseCallScript).horsekey)
				Form BSHeartland = Game.GetFormFromFile(0xA764B, "BSHeartland.esm") as Worldspace
				IF !DES_ValidWorldspaces.HasForm(BSHeartland)
					DES_ValidWorldspaces.AddForm(BSHeartland)
				ENDIF
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
				DES_HorseCallTutorialTracker.UnregisterForAnimationEvent(PlayerRef, "tailHorseDismount")
				HorseCallTutorial = true
				(Alias_Player as DES_SaddleHelpScript).BarebackTutorial = true
				IF HorseCallTutorial && (Alias_Player as DES_SaddleHelpScript).SaddleTutorial && (Alias_Player as DES_SaddleHelpScript).ArmorTutorial && (Alias_Player as DES_SaddleHelpScript).BarebackTutorial || !ShowTutorials
					DES_HorseCallTutorialTracker.stop()
				ENDIF
			ENDIF
		endif
	endif
ENDEVENT