scriptName byohhousescript extends Quest conditional
{script for individual house quests}

;-- Properties --------------------------------------
objectreference[] property Room12EnableList auto
globalvariable property BYOHHPCostGarden auto
objectreference[] property Room09EnableList auto
keyword property BYOHHouseLocation auto
Int property numCows auto conditional
{number of cows at house}
objectreference[] property Room04EnableList auto
objectreference[] property Room6RailRight auto
globalvariable property numCowsMax auto
{maximum number of cows (increased by building fenced pastures)}
globalvariable property BYOHHPCostChicken auto
objectreference[] property DisableList auto
locationalias property houseLocation auto
Bool property ShowEnableList = false auto
Bool property bBoughtCarriage auto conditional
objectreference[] property EnableList4 auto
{4th ref to enable}
objectreference[] property Room6BridgeLeft auto
Int property AdditionLayoutIndexMin auto
miscobject property Gold001 auto
objectreference[] property RoomHoldingChests auto
{array of room holding chests, indexed by roomID
(room 1 = 0, room 1B = 1, room 2 = 2, etc.)}
Bool property bRoom1Remodeled auto conditional
{set to true when entryway remodeled}
objectreference[] property Room3Rail auto
objectreference[] property RoomStartDisableList auto
{list of refs to disable when each room is STARTED}
objectreference property ChildChestRoom2 auto
{child chest - loc ref type version
this is disabled when room 3 becomes "child ready"}
objectreference property HoldingChestRoom1 auto
{holding chest for Room1 interior parts (prior to revision into entry hall)}
Int property Room1MaxIndex auto
{the final index for the room 1 exterior - 
used to determine which exterior pieces to disable
when remodeling the starting house into the style
that matches the main hall}
objectreference property SiteEnableMarker auto
{enable marker for building site - turn on when property is bought, turn off when all construction finished}
objectreference[] property Room01RemodelEnableList auto
{matches Room01RemodelDisableList - list of matching refs in Room 2 to enable when disabling furniture in Room 1}
objectreference[] property Room01AEnableList auto
{enable list for Room 1 - starting house furniture}
objectreference[] property Room06EnableList auto
Bool property bBoughtBard auto conditional
objectreference[] property Room03EnableList auto
Bool property bAllowChildren auto conditional
{set to true when children are allowed to move here
(Room 2 + 2 beds & chest built, or equivalent in room 3)}
objectreference property ChildChestRoom2Replacement auto
{this is the non-child version of the chest 
that gets enabled when room 3 is child ready}
byohhousebuildingscript property BYOHHouseBuilding auto
objectreference[] property Room6BridgeRight auto
objectreference[] property InteriorSwapTriggers auto
{all interior swap triggers - disable them each time player enters house}
objectreference property Room6BridgeRightNavCut auto
formlist property RoomDoneFlags auto
{formlist of globals which are set to 1 when rooms are done, set to 2 when steward is furnishing them, 3 when completed
indexed by roomID (room1A = 0, room1B = 1, room2 = 2, etc.)}
objectreference property Room6BridgeLeftNavCut auto
objectreference[] property Room01BEnableList auto
{enable list for Room 1 - entryway furniture}
globalvariable property BYOHHPCost auto
objectreference[] property Room02EnableList auto
globalvariable property BYOHHPCostCarriage auto
objectreference[] property EnableList2 auto
{second object ref to enable, matches EnableList index}
formlist property RoomStartedFlags auto
{flags to show when each room is started
used to condition recipes to control the order that pieces are completed
due to script lag}
objectreference[] property Room10EnableList auto
Int property numChickens auto conditional
{number of chickens at house}
Bool property bHaveSkeever auto conditional
{set to true by BYOHHouseSkeeverInfestation when tame skeever is placed}
Int property Room1BWorkbenchIndex = 24 auto
{index to room1's interior workbench (version B) (EnableList)
so it can be enabled when remodeled into entryway}
Bool property bAllowSpouse auto conditional
{set to true when spouse is allowed to move in
(Room 1 + bed built)}
Bool property bHaveSteward auto conditional
formlist property BYOHHouseBuildingRoomWorkbenches auto
{form list of workbench base objects, used to add to holding chest when room is built}
byohhousecraftingtriggerscript property HouseCraftingTrigger auto
{exterior crafting trigger, to track when player is in it}
Bool property bBoughtGarden auto conditional
objectreference[] property Room08EnableList auto
objectreference property StewardChest auto
{chest where items bought by steward are placed}
Bool property bChildrenRoom3 auto conditional
{set to true when children should use room 3}
Int property iStyleIndex auto conditional
{index for house style: 0, 1, 2 (used for porch bridge arrays)}
objectreference[] property ChildBedRefsRoom2 auto
{disable these loc ref type markers when room 3 is ready for children}
objectreference[] property Room05EnableList auto
objectreference[] property ExteriorEnableList auto
{enable list which matches the BYOHHouseBuildingExteriorMasterList}
objectreference[] property Room6RailLeft auto
objectreference[] property Room11EnableList auto
objectreference[] property EnableList auto
{enable list which matches the BYOHHouseBuildingMasterList}
Int property iHouseIndex auto
{set on quest script to correct index for this quest:
0 = Falkreath
1 = Hjaalmarch
2 = The Pale}
objectreference[] property Room07EnableList auto
miscobject property BYOHMaterialLog auto
Int property numRoomsCompleted auto conditional
objectreference[] property RoomEnableList auto
{list of refs to enable whenever a room is finished
indexed by (RoomID - 1)}
Bool property bBoughtHorse auto conditional
objectreference property HouseHoldingChest auto
{holding chests for exterior workbenches}
Bool property bOwnProperty auto conditional
{set to true when player buys property in this hold}
objectreference[] property Room9Rail auto
globalvariable property HorseCost auto
globalvariable property BYOHHPCostBard auto
objectreference[] property RoomDisableList auto
{list of refs to disable when each room is completed}
Int property AdditionLayoutIndexMax auto
{The min and max of the indices on EnableList for the layout refs for the addition rooms
 Used to disable all the layout refs at once}
objectreference property HouseMapMarker auto
Int property Room1WorkbenchIndex = 20 auto
{index to room1's interior workbench (EnableList)
so it can be disabled when remodeled into entryway}
objectreference[] property EnableList3 auto
{3rd ref to enable}
objectreference[] property DisableList2 auto
{indexed array of additional refs to disable}
globalvariable property BYOHHPCostCow auto
objectreference[] property Room01RemodelDisableList auto
{disable list for Room 1 furniture when remodeling}

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function OnInit()

	; Empty function
endFunction

function HireCarriageDriver()

	bBoughtCarriage = true
	game.Getplayer().RemoveItem(Gold001 as form, BYOHHPCostCarriage.GetValueInt(), false, none)
endFunction

function BuildHousePart(Int iMasterIndex, Int iFinishRoomID, Int iStartRoomID)

	self.SetStage(120)
	if ShowEnableList
		Int iLoop = 0
		while iLoop < EnableList.length
			iLoop += 1
		endWhile
	endIf
	EnableList[iMasterIndex].EnableNoWait(false)
	if EnableList2[iMasterIndex]
		EnableList2[iMasterIndex].EnableNoWait(false)
	endIf
	if EnableList3[iMasterIndex]
		EnableList3[iMasterIndex].EnableNoWait(false)
	endIf
	if EnableList4[iMasterIndex]
		EnableList4[iMasterIndex].EnableNoWait(false)
	endIf
	if DisableList[iMasterIndex]
		DisableList[iMasterIndex].DisableNoWait(false)
	endIf
	if DisableList2[iMasterIndex]
		DisableList2[iMasterIndex].DisableNoWait(false)
	endIf
	if iStartRoomID > 0
		self.SetStage(130)
		Int roomIndex = iStartRoomID - 1
		if RoomStartDisableList[roomIndex]
			RoomStartDisableList[roomIndex].DisableNoWait(false)
		endIf
		if iStartRoomID == 1
			(RoomStartedFlags.GetAt(0) as globalvariable).SetValueInt(1)
		else
			(RoomStartedFlags.GetAt(iStartRoomID) as globalvariable).SetValueInt(1)
		endIf
	endIf
	if iFinishRoomID > 0
		numRoomsCompleted += 1
		houseLocation.GetLocation().SetKeywordData(BYOHHouseLocation, numRoomsCompleted as Float)
		Int roomindex = iFinishRoomID - 1
		if RoomEnableList[roomindex]
			RoomEnableList[roomindex].EnableNoWait(false)
		endIf
		if RoomDisableList[roomindex]
			RoomDisableList[roomindex].DisableNoWait(false)
		endIf
		if iFinishRoomID == 1
			(RoomDoneFlags.GetAt(0) as globalvariable).SetValueInt(1)
		else
			(RoomDoneFlags.GetAt(iFinishRoomID) as globalvariable).SetValueInt(1)
		endIf
		self.AddBuildingItemToPlayer(BYOHHouseBuildingRoomWorkbenches.GetAt(roomindex))
		self.SetStage(1000 + iFinishRoomID * 10)
	endIf
endFunction

function BuyCow()

	numCows += 1
	game.Getplayer().RemoveItem(Gold001 as form, BYOHHPCostCow.GetValueInt(), false, none)
endFunction

function BuyGarden()

	bBoughtGarden = true
	game.Getplayer().RemoveItem(Gold001 as form, BYOHHPCostGarden.GetValueInt(), false, none)
endFunction

function AddBuildingItemToPlayer(form itemToAdd)

	if HouseCraftingTrigger.bPlayerInTrigger
		game.Getplayer().AddItem(itemToAdd, 1, true)
	else
		HouseHoldingChest.AddItem(itemToAdd, 1, true)
	endIf
endFunction

Bool function MoveEntryRoomFurniture()

	Int currentIndex = 0
	while currentIndex < Room01RemodelDisableList.length
		objectreference currentFurniture = Room01RemodelDisableList[currentIndex]
		if currentFurniture.IsDisabled() == false
			Room01RemodelEnableList[currentIndex].EnableNoWait(false)
			RoomHoldingChests[2].AddItem(BYOHHouseBuilding.BYOHHouseBuildingRoom01RemodelList.GetAt(currentIndex), 1, false)
		endIf
		currentFurniture.DisableNoWait(false)
		currentIndex += 1
	endWhile
endFunction

function OnStart()

	; Empty function
endFunction

function HireBard()

	bBoughtBard = true
	game.Getplayer().RemoveItem(Gold001 as form, BYOHHPCostBard.GetValueInt(), false, none)
endFunction

; Skipped compiler generated GetState

function RemodelEntryRoom(Int partID)

	bRoom1Remodeled = true
	(RoomDoneFlags.GetAt(0) as globalvariable).SetValueInt(1)
	(RoomDoneFlags.GetAt(1) as globalvariable).SetValueInt(1)
	self.MoveEntryRoomFurniture()
	EnableList[Room1WorkbenchIndex].DisableNoWait(false)
	EnableList[Room1BWorkbenchIndex].EnableNoWait(false)
	self.AddBuildingItemToPlayer(BYOHHouseBuildingRoomWorkbenches.GetAt(12))
	Int currentIndex = 0
	while currentIndex <= Room1MaxIndex
		EnableList[currentIndex].DisableNoWait(false)
		currentIndex += 1
	endWhile
	if partID == 1
		
	elseIf partID == 2
		
	elseIf partID == 3
		
	endIf
endFunction

function BuyChicken()

	numChickens += 1
	game.Getplayer().RemoveItem(Gold001 as form, BYOHHPCostChicken.GetValueInt(), false, none)
endFunction

function BuyHorse()

	bBoughtHorse = true
	game.Getplayer().RemoveItem(Gold001 as form, HorseCost.GetValueInt(), false, none)
endFunction

function FinishPorchRoom()

	if self.GetStageDone(1030)
		Room3Rail[iStyleIndex].EnableNoWait(false)
	endIf
	if self.GetStageDone(1060)
		Room6RailLeft[iStyleIndex].EnableNoWait(false)
		Room6RailRight[iStyleIndex].EnableNoWait(false)
	endIf
	if self.GetStageDone(1090)
		Room9Rail[iStyleIndex].EnableNoWait(false)
	endIf
	if self.GetStageDone(1060)
		if self.GetStageDone(1030)
			Room6BridgeLeft[iStyleIndex].EnableNoWait(false)
			Room6RailLeft[iStyleIndex].DisableNoWait(false)
			Room3Rail[iStyleIndex].DisableNoWait(false)
			Room6BridgeLeftNavCut.DisableNoWait(false)
		endIf
		if self.GetStageDone(1090)
			Room6BridgeRight[iStyleIndex].EnableNoWait(false)
			Room6RailRight[iStyleIndex].DisableNoWait(false)
			Room9Rail[iStyleIndex].DisableNoWait(false)
			Room6BridgeRightNavCut.DisableNoWait(false)
		endIf
	endIf
endFunction

function BuyProperty()

	bOwnProperty = true
	game.Getplayer().RemoveItem(Gold001 as form, BYOHHPCost.GetValueInt(), false, none)
	BYOHHouseBuilding.BuyProperty(iHouseIndex)
	SiteEnableMarker.Enable(false)
	HouseMapMarker.Enable(false)
	HouseMapMarker.AddToMap(false)
	game.Getplayer().AddItem(BYOHMaterialLog as form, 20, true)
endFunction

function HouseAnimalDied(objectreference akDeadAnimal)

	akDeadAnimal.Disable(false)
	akDeadAnimal.Reset(none)
	if akDeadAnimal as byohhousehorsescript
		bBoughtHorse = false
	elseIf akDeadAnimal as byohhousecowscript
		numCows -= 1
	elseIf akDeadAnimal as byohhousechickenscript
		numChickens -= 1
	endIf
endFunction

function BuildHouseExteriorPart(Int iMasterIndex)

	ExteriorEnableList[iMasterIndex].EnableNoWait(false)
endFunction

function DisableAdditionLayout()

	Int currentIndex = AdditionLayoutIndexMin
	while currentIndex <= AdditionLayoutIndexMax
		EnableList[currentIndex].DisableNoWait(false)
		currentIndex += 1
	endWhile
endFunction

function DisableInteriorSwapTriggers()

	Int currentIndex = 0
	while currentIndex < InteriorSwapTriggers.length
		InteriorSwapTriggers[currentIndex].DisableNoWait(false)
		currentIndex += 1
	endWhile
endFunction

function BuildHouseInteriorPart(Int roomID, String variantID, Int iRoomIndex)

	objectreference[] foundEnableList
	if roomID == 1
		if variantID == "A"
			foundEnableList = Room01AEnableList
		elseIf variantID == "B"
			foundEnableList = Room01BEnableList
		endIf
	elseIf roomID == 2
		foundEnableList = Room02EnableList
	elseIf roomID == 3
		foundEnableList = Room03EnableList
	elseIf roomID == 4
		foundEnableList = Room04EnableList
	elseIf roomID == 5
		foundEnableList = Room05EnableList
	elseIf roomID == 6
		foundEnableList = Room06EnableList
	elseIf roomID == 7
		foundEnableList = Room07EnableList
	elseIf roomID == 8
		foundEnableList = Room08EnableList
	elseIf roomID == 9
		foundEnableList = Room09EnableList
	elseIf roomID == 10
		foundEnableList = Room10EnableList
	elseIf roomID == 11
		foundEnableList = Room11EnableList
	elseIf roomID == 12
		foundEnableList = Room12EnableList
	endIf
	foundEnableList[iRoomIndex].EnableNoWait(false)
endFunction

; Skipped compiler generated GotoState
