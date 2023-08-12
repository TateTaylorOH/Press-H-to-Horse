;/ Decompiled by Champollion V1.0.1
Source   : ccBGSSSE034_JournalContainerChange.psc
ModIFied : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName ccBGSSSE034_JournalContainerChange extends ReferenceAlias
{Handles picking up and reading}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- FUNCTIONs ---------------------------------------

; Skipped compiler generated GoToState

; Skipped compiler generated GetState

;-- STATE -------------------------------------------
auto STATE Waiting

	FUNCTION OnRead()

		IF self.GetOwningQuest().GetStage() == 0
			self.GetOwningQuest().SetStage(10)
			self.GoToState("Complete")
		ENDIF
	ENDFUNCTION
ENDSTATE

;-- STATE -------------------------------------------
STATE Complete

	FUNCTION OnRead()

		; Empty FUNCTION
	ENDFUNCTION
ENDSTATE
