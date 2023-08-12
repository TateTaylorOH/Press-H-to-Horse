;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_MapContainerChangeAlias.psc
ModIFied : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_MapContainerChangeAlias extends ReferenceAlias
{Backup for the player to pickpocket or kill hostler}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GoToState

; Skipped compiler generated GetState

;-- STATE -------------------------------------------
auto STATE Waiting

	FUNCTION OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)

		IF akNewContainer == game.GetPlayer() as ObjectReference && self.GetOwningQuest().GetStage() == 0
			self.GoToState("Complete")
			self.GetOwningQuest().SetStage(10)
		ENDIF
	ENDFUNCTION
ENDSTATE

;-- STATE -------------------------------------------
STATE Complete
ENDSTATE
