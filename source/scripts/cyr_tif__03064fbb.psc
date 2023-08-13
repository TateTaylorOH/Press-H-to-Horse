scriptName CYR_TIF__03064FBB extends TopicInfo hidden

;-- Properties --------------------------------------
miscobject property Gold001 auto
referencealias property PlayerHorse auto
referencealias property Alias_Horse auto
faction property PlayerFaction auto
faction property PlayerHorseFaction auto

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GoToState

FUNCTION Fragment_0(ObjectReference akSpeakerRef)
	game.GetPlayer().RemoveItem(Gold001 as form, 3000, false, none)
	Alias_Horse.GetActorRef().SetFactionRank(PlayerHorseFaction, 1)
	Alias_Horse.GetActorRef().SetFactionOwner(PlayerFaction)
	PlayerHorse.ForceRefTo(Alias_Horse.GetActorRef())
	game.IncrementStat("Horses Owned", 1)
	Actor MountToRename = Alias_Horse.GetActorRef()
	(Quest.GetQuest("DES_HorseHandler") as DES_RenameHorseQuestScript).renameCyrodiilHorse(MountToRename)
	(Quest.GetQuest("DES_HorseHandler") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
ENDFUNCTION
