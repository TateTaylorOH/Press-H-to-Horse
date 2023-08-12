;/ Decompiled by Champollion V1.0.1
Source   : ccVSVSSE004_TIF_BuyHorse.psc
ModIFied : 2023-01-02 16:47:40
Compiled : 2023-01-02 17:26:52
User     : thest
Computer : TATEPC
/;
scriptName ccvsvsse004_tIF_buyhorse extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GetState

FUNCTION Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccvsvsse004_farmmodmanagerscript).BuyHorse()
	Actor MountToRename = (GetOwningQuest().getAliasByName("Horse") as ReferenceAlias).GetActorRef()
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).renameAnyHorse(MountToRename)
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_HorseInventoryScript).FirstTimeEquipHorse(MountToRename)
ENDFUNCTION

; Skipped compiler generated GoToState
