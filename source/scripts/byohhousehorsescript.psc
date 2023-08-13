;/ Decompiled by Champollion V1.0.1
Source   : BYOHHouseHorseScript.psc
Modified : 2022-12-11 15:35:16
Compiled : 2023-08-10 20:46:37
User     : thest
Computer : TATEPC
/;
scriptName byohhousehorsescript extends ObjectReference
{enable horse on load after buying}

;-- Properties --------------------------------------
referencealias property PlayersHorse auto
byohhousescript property BYOHHouseQuest auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnCellDetach()

	if ((self as ObjectReference) as actor).IsDead()
		BYOHHouseQuest.HouseAnimalDied(self as ObjectReference)
	endIf
endFunction

; Skipped compiler generated GotoState

; Skipped compiler generated GetState

function OnCellAttach()

	if BYOHHouseQuest.bBoughtHorse && self.IsEnabled() == false
		self.Enable(false)
		PlayersHorse.ForceRefTo(self as ObjectReference)
		game.IncrementStat("Horses Owned", 1)
	endIf
endFunction
