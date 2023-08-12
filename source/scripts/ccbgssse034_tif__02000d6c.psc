;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_tIF__02000d6c.psc
ModIFied : 2021-08-19 11:15:00
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_tIF__02000d6c extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GetState

FUNCTION Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	debug.trace("Player purchased map", 0)
	self.GetOwningQuest().SetStage(10)
ENDFUNCTION

; Skipped compiler generated GoToState
