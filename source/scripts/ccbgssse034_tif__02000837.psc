;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_TIF__02000837.psc
ModIFied : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_TIF__02000837 extends TopicInfo hidden

;-- Properties --------------------------------------
armor property SaddleLight auto

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

FUNCTION Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccbgssse034_saddlequestscript).ChangeHorseSaddle(SaddleLight)
ENDFUNCTION

; Skipped compiler generated GoToState

; Skipped compiler generated GetState
