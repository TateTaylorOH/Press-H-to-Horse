scriptName ccVSVSSE001_DeedScript extends ObjectReference

;-- Properties --------------------------------------
referencealias property Alias_Reindeer auto
globalvariable property deedActive auto
ObjectReference property merchantChest auto
referencealias property PlayerHorse auto
faction property PlayerFaction auto
faction property PlayerHorseFaction auto
referencealias property PlayerReindeer auto

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GetState

FUNCTION OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

	IF akOldContainer == merchantChest && akNewContainer == game.GetPlayer() as ObjectReference
		Alias_Reindeer.GetActorRef().SetFactionRank(PlayerHorseFaction, 1)
		Alias_Reindeer.GetActorRef().SetFactionOwner(PlayerFaction)
		PlayerHorse.Clear()
		PlayerReindeer.ForceRefTo(Alias_Reindeer.GetActorRef() as ObjectReference)
		game.IncrementStat("Horses Owned", 1)
		deedActive.SetValue(100 as Float)
		
		Actor MountToRename = Alias_Reindeer.GetActorRef()
		Formlist DES_HorseMiscItems = game.GetFormFromFile(0xDD6, "H2Horse.esp") as Formlist
		Formlist DES_HorseArmors = game.GetFormFromFile(0xDD7, "H2Horse.esp") as Formlist
		Formlist DES_HorseAllForms = game.GetFormFromFile(0xDD8, "H2Horse.esp") as Formlist
		(Quest.GetQuest("DES_HorseHandler") as DES_RenameHorseQuestScript).renameUniqueHorse(MountToRename, "Cloudberry")
		(Quest.GetQuest("DES_HorseHandler") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
	ENDIF
ENDFUNCTION

; Skipped compiler generated GoToState
