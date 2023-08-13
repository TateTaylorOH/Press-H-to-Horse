scriptName DLCDwarvenPuzzle_RebuildHorseScript extends ObjectReference

quest property DLCDwarvenPuzzleDungeonHorseQuest auto
actor property DLCDwarvenPuzzleHorse auto
miscobject[] property AllNeededHorseParts auto
message property DLCDwarvenpuzzleDungeonHorseFailMessage auto

Bool function playerHasAllItems()
	Int iElement = AllNeededHorseParts.length
	Int iIndex = 0
	actor Player = game.GetPlayer()
	while iIndex < iElement
		if Player.GetItemCount(AllNeededHorseParts[iIndex] as form) < 1
			return false
		endIf
		iIndex += 1
	endWhile
	return true
endFunction

auto state normalState

	function OnActivate(ObjectReference akActionRef)
		GotoState("lockState")
		Int questStage = DLCDwarvenPuzzleDungeonHorseQuest.GetStage()
		if questStage == 0
			DLCDwarvenPuzzleDungeonHorseQuest.Start()
			DLCDwarvenPuzzleDungeonHorseQuest.SetStage(1)
		elseIf questStage == 2
			if playerHasAllItems() == true
				DLCDwarvenPuzzleDungeonHorseQuest.SetObjectiveCompleted(6)
				DLCDwarvenPuzzleDungeonHorseQuest.SetStage(3)
				Int iElement = AllNeededHorseParts.length
				Int iIndex = 0
				actor Player = game.GetPlayer()
				while iIndex < iElement
					Player.RemoveItem(AllNeededHorseParts[iIndex] as form, 1, false, none)
					iIndex += 1
				endWhile
				DLCDwarvenPuzzleHorse.EnableNoWait(true)
				(Quest.GetQuest("DES_RenameHorseQuest") as DES_HorseInventoryScript).FirstTimeEquipHorse(DLCDwarvenPuzzleHorse)
				DisableNoWait(true)
			else
				DLCDwarvenpuzzleDungeonHorseFailMessage.Show()
			endIf
		endIf
		GotoState("normalState")
	endFunction
endState
state lockState
	function OnActivate(ObjectReference akActionRef)
		; Empty function
	endFunction
endState