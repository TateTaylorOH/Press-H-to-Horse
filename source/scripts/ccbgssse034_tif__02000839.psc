;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_TIF__02000839.psc
Modified : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_TIF__02000839 extends TopicInfo hidden

;-- Properties --------------------------------------
armor property HorseSaddleImperial auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function Fragment_0(ObjectReference akSpeakerRef)

	actor akSpeaker = akSpeakerRef as actor
	(self.GetOwningQuest() as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddleImperial)
endFunction
