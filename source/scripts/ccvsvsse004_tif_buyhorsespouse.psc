scriptName ccvsvsse004_tIF_buyhorsespouse extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

FUNCTION Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccvsvsse004_farmmodmanagerscript).BuyHorse()
	Actor MountToRename = (GetOwningQuest().getAliasByName("Horse") as ReferenceAlias).GetActorRef()
	(Quest.GetQuest("DES_HorseHandler") as DES_RenameHorseQuestScript).renameAnyHorse(MountToRename)
	(Quest.GetQuest("DES_HorseHandler") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
ENDFUNCTION

; Skipped compiler generated GoToState

; Skipped compiler generated GetState
