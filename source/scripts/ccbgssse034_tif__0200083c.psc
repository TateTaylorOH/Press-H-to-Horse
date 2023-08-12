;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_TIF__0200083C.psc
ModIFied : 2021-08-19 11:15:00
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_TIF__0200083C extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GoToState

; Skipped compiler generated GetState

FUNCTION Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccbgssse034_saddlequestscript).ChangeHorseSaddle(none)
ENDFUNCTION
