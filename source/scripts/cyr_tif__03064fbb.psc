;/ Decompiled by Champollion V1.0.1
Source   : CYR_TIF__03064FBB.psc
Modified : 2015-04-07 07:00:48
Compiled : 2015-04-07 07:00:49
User     : Blackstorm
Computer : BLACKST-4R0FPJ1
/;
scriptName CYR_TIF__03064FBB extends TopicInfo hidden

;-- Properties --------------------------------------
miscobject property Gold001 auto
referencealias property PlayerHorse auto
referencealias property Alias_Horse auto
faction property PlayerFaction auto
faction property PlayerHorseFaction auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function Fragment_0(ObjectReference akSpeakerRef)
	game.GetPlayer().RemoveItem(Gold001 as form, 3000, false, none)
	Alias_Horse.GetActorRef().SetFactionRank(PlayerHorseFaction, 1)
	Alias_Horse.GetActorRef().SetFactionOwner(PlayerFaction)
	PlayerHorse.ForceRefTo(Alias_Horse.GetActorRef())
	game.IncrementStat("Horses Owned", 1)
	Actor MountToRename = Alias_Horse.GetActorRef()
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).renameCyrodiilHorse(MountToRename)
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
endFunction
