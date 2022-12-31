;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_tif__02000d6d.psc
Modified : 2021-08-19 11:15:00
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_tif__02000d6d extends TopicInfo hidden

;-- Properties --------------------------------------
message property MessageNotEnoughGold auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	debug.trace("Player doesn't have enough gold", 0)
	MessageNotEnoughGold.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState
