;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_tif__02000d6c.psc
Modified : 2021-08-19 11:15:00
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_tif__02000d6c extends TopicInfo hidden

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

function Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	debug.trace("Player purchased map", 0)
	self.GetOwningQuest().SetStage(10)
endFunction

; Skipped compiler generated GotoState
