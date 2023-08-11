;/ Decompiled by Champollion V1.0.1
Source   : ccVSVSSE004_TIF_BuyHorseSpouse.psc
Modified : 2023-01-02 16:47:40
Compiled : 2023-01-02 16:51:51
User     : thest
Computer : TATEPC
/;
scriptName ccvsvsse004_tif_buyhorsespouse extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccvsvsse004_farmmodmanagerscript).BuyHorse()
	Actor MountToRename = (GetOwningQuest().getAliasByName("Horse") as ReferenceAlias).GetActorRef()
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).renameAnyHorse(MountToRename)
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).equipHorse(MountToRename)
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState
