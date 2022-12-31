;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_MapContainerChangeAlias.psc
Modified : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_MapContainerChangeAlias extends ReferenceAlias
{Backup for the player to pickpocket or kill hostler}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

;-- State -------------------------------------------
auto state Waiting

	function OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

		if akNewContainer == game.GetPlayer() as ObjectReference && self.GetOwningQuest().GetStage() == 0
			self.GotoState("Complete")
			self.GetOwningQuest().SetStage(10)
		endIf
	endFunction
endState

;-- State -------------------------------------------
state Complete
endState
