Scriptname DES_RegisterKeyOnLoad extends ReferenceAlias

GlobalVariable Property DES_PlayerOwnsHorse auto
Quest Property DES_RenameHorseQuest Auto
Quest Property DES_HorseCallTutorialTracker Auto
Formlist Property DES_ValidWorldspaces auto
ReferenceAlias Property Alias_PlayersHorse auto
ReferenceAlias Property Alias_BSBrumaHostler auto
LeveledItem Property DES_LItemMiscHostlerItems75 auto
LeveledItem Property DES_MinimumHostler auto

EVENT OnPlayerLoadGame()
	Debug.Notification("This event is firing I swear.")
	GetBaseCarryWeight()
	RegisterKey()
	InjectModdedWorldspaces()
	ImportDwarvenHorse()
	Actor BSBrumaHostler = Game.GetFormFromFile(0x650D3, "BSHeartland.esm") As Actor
	Debug.Notification("BSBrumaHostler = " + BSBrumaHostler.getDisplayName())
	;IF BSHostler != Alias_BSBrumaHostler.getactorRef()
		Alias_BSBrumaHostler.ForceRefTo(BSBrumaHostler)
	;ENDIF
ENDEVENT

FUNCTION GetBaseCarryWeight()
	Actor PlayersHorse = Alias_PlayersHorse.GetActorReference()
	(DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight = PlayersHorse.GetBaseAV("CarryWeight") as int
	IF (DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight == 0
		(DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight = 999
	ENDIF
ENDFUNCTION

FUNCTION RegisterKey()
	IF DES_PlayerOwnsHorse.getvalue() == 1
		UnregisterForKey((DES_RenameHorseQuest as DES_HorseCallScript).horsekey)
		RegisterForKey((DES_RenameHorseQuest as DES_HorseCallScript).horsekey)
	ENDIF
ENDFUNCTION

FUNCTION InjectModdedWorldspaces()
	Form BSHeartland = Game.GetFormFromFile(0xA764B, "BSHeartland.esm") as Worldspace
	IF !DES_ValidWorldspaces.HasForm(BSHeartland)
		DES_ValidWorldspaces.AddForm(BSHeartland)
	ENDIF
	
	MiscObject BSHorseshoe = Game.GetFormFromFile(0x723B8, "BSHeartland.esm") As MiscObject
	IF !(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).BSHorseshoeAdded == true
		DES_MinimumHostler.AddForm(BSHorseshoe, 1, 4)
		DES_LItemMiscHostlerItems75.AddForm(BSHorseshoe, 1, 4)
	ENDIF
	

ENDFUNCTION

FUNCTION ImportDwarvenHorse()
	IF Game.GetFormFromFile(0x38D5, "cctwbsse001-puzzledungeon.esm") 
		IF !(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).DwarvenHorseEquipped == true
			Actor DwarvenHorse = Game.GetFormFromFile(0x38D5, "cctwbsse001-puzzledungeon.esm") As Actor
			(DES_RenameHorseQuest as DES_HorseInventoryScript).FirstTimeEquipHorse(DwarvenHorse)
			(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).DwarvenHorseEquipped = true
			Alias_PlayersHorse.Clear()
		ENDIF
	ENDIF
ENDFUNCTION