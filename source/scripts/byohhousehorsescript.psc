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
