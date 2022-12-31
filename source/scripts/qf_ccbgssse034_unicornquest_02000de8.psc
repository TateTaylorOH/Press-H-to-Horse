;/ Decompiled by Champollion V1.0.1
Source   : QF_ccBGSSSE034_UnicornQuest_02000DE8.psc
Modified : 2021-08-19 11:15:01
Compiled : 2021-08-24 17:21:27
User     : builds
Computer : RKVBGSGPUVM04
/;
scriptName QF_ccBGSSSE034_UnicornQuest_02000DE8 extends Quest hidden

;-- Properties --------------------------------------
referencealias property Alias_UnicornREF auto
referencealias property Alias_JournalREF auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function Fragment_4()

	self.SetObjectiveCompleted(0, true)
	self.SetObjectiveCompleted(10, true)
	self.Stop()
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function Fragment_1()

	self.SetObjectiveCompleted(0, true)
	self.SetObjectiveDisplayed(10, true, false)
	Alias_UnicornREF.GetRef().Enable(false)
endFunction

function Fragment_0()

	self.SetObjectiveDisplayed(0, true, false)
endFunction
