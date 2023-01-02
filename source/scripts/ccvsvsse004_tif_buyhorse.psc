;/ Decompiled by Champollion V1.0.1
Source   : ccVSVSSE004_TIF_BuyHorse.psc
Modified : 2023-01-02 16:47:40
Compiled : 2023-01-02 17:26:52
User     : thest
Computer : TATEPC
/;
scriptName ccvsvsse004_tif_buyhorse extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

function Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccvsvsse004_farmmodmanagerscript).BuyHorse()
	(Quest.GetQuest("DES_RenameHorseQuest") as DES_RenameHorseQuestScript).renameFarmHorse()
endFunction

; Skipped compiler generated GotoState
