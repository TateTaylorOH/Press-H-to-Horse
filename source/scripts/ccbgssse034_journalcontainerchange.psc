;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_JournalContainerChange.psc
Modified : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_JournalContainerChange extends ReferenceAlias
{Handles picking up and reading}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

;-- State -------------------------------------------
auto state Waiting

	function OnRead()

		if self.GetOwningQuest().GetStage() == 0
			self.GetOwningQuest().SetStage(10)
			self.GotoState("Complete")
		endIf
	endFunction
endState

;-- State -------------------------------------------
state Complete

	function OnRead()

		; Empty function
	endFunction
endState
