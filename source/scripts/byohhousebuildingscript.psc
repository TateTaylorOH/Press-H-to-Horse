scriptName byohhousebuildingscript extends Quest conditional
{script for BYOHHouseBuilding quest}

;-- Properties --------------------------------------
keyword property BYOHHouseLocationKeyword auto
miscobject property BYOHMaterialClay auto
String property sDLC01Filename = "Dawnguard.esm" auto
{name of DLC01 esm}
location property BYOHHouse3LocationInterior auto
Int property iFriendLetterStage = 20 auto
{quest stage to set to send friend letter}
referencealias property LumbermillOperator auto
formlist property BYOHHouseBuildingRoom01RemodelList auto
Int[] property SpouseIDsRoom1Count auto
{how many of the required items have been built
NOTE: an array only so it can be passed by ref - deliberately a single element array}
Int property activeHouseLocation auto conditional
{current house location (set by scripts on workbenches)
0 = Falkreath
1 = The Pale
2 = Hjaalmarch}
furniture property ResourceObjectSawmill auto
miscobject property BYOHMaterialStraw auto
Bool property bCraftingTriggerBusy auto
{set to true when a crafting trigger is giving/removing items to avoid overlapping}
Quest property Favor258Falkreath auto
globalvariable property BYOHHPCostClay auto
location property BYOHHouse1Location auto
globalvariable property BYOHHPAmountClay auto
globalvariable property BYOHHouse3LastVisit auto
String property activeVariantID auto
{current room variant ID - used for interior workbenches
(set by script on workbenches)
format is "A", "B", etc.}
formlist property BYOHHouseBuildingAdditionLayoutTOKENList auto
{matching list of inventory tokens - these get placed in inventory by BuildHousePart function
  these are what the room addition recipes look at instead of the crafted layout objects due to threading issues}
Quest property Favor256Pale auto
referencealias property PlayerHousecarlFalkreath auto
formlist property BYOHRelationshipAdoptionPlayerGiftChildMale auto
Int[] property ChildIDsRoom3Count auto
{how many of the required items have been built
NOTE: an array only so it can be passed by ref - deliberately a single element array}
Int property iIntroLetterStage = 12 auto
{quest stage to set to send intro letter}
bardsongsscript property BardSongs auto
{BardSongs quest}
location property BYOHHouse2LocationInterior auto
Int property iSkeeverInfestPercent = 5 auto
miscobject property DeerHide02 auto
objectreference property HousecarlFalkreath auto
keyword property WIDragonsToggle auto
location[] property HouseLocations auto
Float property fNextAttackDays = 21.0000 auto
{how many days before another house attack can be triggered}
objectreference[] property LogPiles auto
{array of log piles - enable when player has logs available}
globalvariable property BYOHLastAttack auto
{timestamp for last time a house attack happened}
Int property iBanditAttackPercent = 10 auto
referencealias property JarlPale auto
formlist property CrimeFactionsList auto
miscobject property BYOHMaterialLog auto
formlist property WerewolfHateFactions auto
Int property activeRoomID auto
{current room ID - used for interior workbenches
(set by script on workbenches)}
faction property BYOHLumberVendorFaction auto
{faction to add lumber vendors to at quest startup}
formlist property BYOHRelationshipAdoption_PetAllowedRacesList auto
referencealias property JarlFalkreath auto
Int[] property iRoom2StyleID auto
{IDs of parts that starts room 2 style A - C (0-2) - used to set the style index on the house quest}
location property BYOHHouse3Location auto
Int[] property SpouseIDsRoom2 auto
{array of IDs needed to set bAllowSpouse to true on house quest}
actor property GeneralTulliusRef auto
faction property CWImperialFaction auto
Int property iLumbermillSawnLogCount = 10 auto
formlist[] property RoomMasterLists auto
{array of master lists for interior rooms, indexed by room # - except for room 1 special case}
keyword property BYOHHouseBanditAttackKeyword auto
miscobject property Gold001 auto
formlist property ExteriorMasterList auto
{master list of exterior parts}
Int[] property ChildIDsRoom3 auto
{array of IDs to trigger move to Room 3}
referencealias property JarlHjaalmarch auto
globalvariable property BYOHHPCostLogs auto
faction property CWSonsFaction auto
globalvariable property BYOHHPAmountLogs auto
objectreference[] property LumberVendors auto
{array of lumber vendor refs (actors)}
globalvariable property BYOHHouseLogCount auto
miscobject property BYOHMaterialStoneBlock auto
Int[] property ChildIDsRoom2 auto
{array of interior IDs that must be built for bAllowChildren to be set true on house quest}
referencealias property LumbermillMarker auto
Int property iHouseStyles = 1 auto conditional
{number of house styles available (determines which layouts show up for main hall)}
referencealias property PlayerHousecarlPale auto
referencealias[] property HouseStewards auto
{player stewards (index 0-2)}
formlist property BYOHHouseBuildingTrophyPlaceList auto
{list of objects to place in the world when trophies are built - order matches TrophyMasterList}
formlist property BYOHHouseBuildingTrophyMasterList auto
{master list of trophy inventory objects}
keyword property BYOHHouseSkeeverInfestationKeyword auto
objectreference property TrophyBuildMarker auto
{set by trophy base - where to place trophies when built}
globalvariable property BYOHHPAmountStone auto
globalvariable property BYOHHPCostStone auto
byohrelationshipadoptablescript property RelationshipAdoptable auto
formlist property BYOHRelationshipAdoptionPlayerGiftChildFemale auto
objectreference property HousecarlHjaalmarch auto
miscobject property DeerHide auto
locationalias property LumbermillLocation auto
Int property iMinIntroLetterLevel = 9 auto
{min level for player to be sent an "intro letter" from one of the jarls}
location property BYOHHouse1LocationInterior auto
actor property UlfricRef auto
Int[] property ChildIDsRoom2Count auto
{how many of the required items have been built
NOTE: an array only so it can be passed by ref - deliberately a single element array}
dialoguefollowerscript property DialogueFollower auto
location property BYOHHouse2Location auto
Quest property Favor255Hjaalmarch auto
Bool property bInitializedOtherDLC auto
{set to TRUE when able to initialize from other DLC}
Int[] property SpouseIDsRoom3Count auto
{how many of the required items have been built
NOTE: an array only so it can be passed by ref - deliberately a single element array}
byohrelationshipadoptionscript property RelationshipAdoption auto
formlist property BuildingMasterList auto
{master list of building parts}
Int[] property SpouseIDsRoom1 auto
{array of IDs needed to set bAllowSpouse to true on house quest}
formlist property BYOHHouseRoomCostList auto
{list of globals of cost of buying room furnishings
indexed by roomID (room1A = 0, room1B = 1, room 2 = 2, etc.)}
globalvariable property GameDaysPassed auto
Int[] property SpouseIDsRoom2Count auto
{how many of the required items have been built
NOTE: an array only so it can be passed by ref - deliberately a single element array}
faction[] property CrimeFactions auto
{array of crime factions that need to be added to 
vampire and werewolf "hate lists"}
formlist property BYOHHouseBuildingAdditionLayoutList auto
{master list of layout inventory objects}
formlist property BYOHRelationshipAdoption_PetDogsList auto
Bool property bBuildingEnabled auto conditional
{set to true when the player has bought at least one property
(for simplicity in dialogue conditions)
check houseOwned array for specific houses}
Bool[] property houseOwned auto
{array of flags
true for that index = player has bought the property}
Int[] property SpouseIDsRoom3 auto
{array of IDs needed to set bAllowSpouse to true on house quest}
objectreference property HousecarlPale auto
globalvariable property BYOHHouse1LastVisit auto
globalvariable property BYOHHouse2LastVisit auto
referencealias property PlayerHousecarlHjaalmarch auto
objectreference property TrophyBase auto
{current trophy base, set by trophy base script when activated}
objectreference[] property Lumbermills auto
{array of lumber mills - index matches with Lumber Vendors array}
quest[] property HouseQuests auto
{array of house quests}
objectreference property TrophyIdleMarker auto
{set by trophy base - idle marker to enable when trophy is built}
miscobject property BYOHMaterialGlass auto

;-- Variables ---------------------------------------
Bool bSentFriendLetter = false
Bool bSentIntroLetter = false
Bool bBuildHousePart

;-- Functions ---------------------------------------

function ClearLumbermillOperator()

	LumbermillMarker.Clear()
	LumbermillOperator.Clear()
	LumbermillLocation.Clear()
	self.UnregisterForAnimationEvent(LumbermillMarker.GetRef(), "MillLogIdleReset")
endFunction

function OnAnimationEvent(objectreference akSource, String asEventName)

	if akSource == LumbermillMarker.GetRef() && asEventName == "MillLogIdleReset"
		game.GetPlayer().additem(BYOHMaterialLog as form, iLumbermillSawnLogCount, false)
	endIf
endFunction

; Skipped compiler generated GotoState

function BardRegisterLocationOwner(actor akBard)

	if game.GetPlayer().IsInFaction(CWSonsFaction)
		BardSongs.RegisterLocationOwner(UlfricRef as objectreference)
	elseIf game.GetPlayer().IsInFaction(CWImperialFaction)
		BardSongs.RegisterLocationOwner(GeneralTulliusRef as objectreference)
	else
		BardSongs.RegisterLocationOwner(akBard as objectreference)
	endIf
endFunction

Bool function IsHouseComplete(byohhousescript myHouse)

	formlist roomFlags = myHouse.RoomDoneFlags
	Int iAdditionsCompleted = 0
	Int iCurrentRoom = 3
	while iCurrentRoom < 12
		if (roomFlags.GetAt(iCurrentRoom) as globalvariable).GetValueInt() >= 1
			iAdditionsCompleted += 1
		endIf
		iCurrentRoom += 1
	endWhile
	return iAdditionsCompleted >= 3
endFunction

function BuildTrophy(Int partID)

	Int newHousePartIndex = self.GetFormListIndex(BYOHHouseBuildingTrophyMasterList, partID, none)
	if newHousePartIndex > -1
		if TrophyBuildMarker
			TrophyBuildMarker.PlaceAtMe(BYOHHouseBuildingTrophyPlaceList.GetAt(newHousePartIndex), 1, false, false)
			TrophyBase.SetDestroyed(true)
			if TrophyIdleMarker
				TrophyIdleMarker.enableNoWait(false)
			endIf
		endIf
	endIf
	self.UpdateLogCount()
endFunction

function DismissBard(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).bBoughtBard = false
	endIf
endFunction

Int function GetFormListIndex(formlist myList, Int myID, form myForm)

	Int currentIndex = 0
	if myForm as Bool && (myForm as byohbuildingobjectscript).ID == myID
		currentIndex = myList.Find(myForm)
		if currentIndex >= 0
			return currentIndex
		endIf
	else
		while currentIndex < myList.GetSize()
			form listForm = myList.GetAt(currentIndex)
			byohbuildingobjectscript listObject = listForm as byohbuildingobjectscript
			if listObject.ID == myID
				return currentIndex
			else
				currentIndex += 1
			endIf
		endWhile
	endIf
	return -1
endFunction

function UpdateCompletionStatus(byohhousescript houseQuest, Int roomID, Int partID)

	if houseQuest.bAllowSpouse == false
		if roomID == 1
			if self.CheckCompletionStatus(SpouseIDsRoom1, SpouseIDsRoom1Count, partID)
				houseQuest.bAllowSpouse = true
				RelationshipAdoptable.UpdateHouseStatus()
			endIf
		elseIf roomID == 2
			if self.CheckCompletionStatus(SpouseIDsRoom2, SpouseIDsRoom2Count, partID)
				houseQuest.bAllowSpouse = true
				RelationshipAdoptable.UpdateHouseStatus()
			endIf
		elseIf roomID == 3
			if self.CheckCompletionStatus(SpouseIDsRoom3, SpouseIDsRoom3Count, partID)
				houseQuest.bAllowSpouse = true
				RelationshipAdoptable.UpdateHouseStatus()
			endIf
		endIf
	endIf
	if houseQuest.bAllowChildren == false
		if roomID == 2
			if self.CheckCompletionStatus(ChildIDsRoom2, ChildIDsRoom2Count, partID)
				houseQuest.bAllowChildren = true
				RelationshipAdoptable.UpdateHouseStatus()
				RelationshipAdoption.QueueMoveFamily(RelationshipAdoption.currentHome, true)
			endIf
		endIf
	endIf
	if houseQuest.bAllowChildren == false || houseQuest.bChildrenRoom3 == false
		if roomID == 3
			if self.CheckCompletionStatus(ChildIDsRoom3, ChildIDsRoom3Count, partID)
				houseQuest.bAllowChildren = true
				houseQuest.bChildrenRoom3 = true
				houseQuest.ChildBedRefsRoom2[0].DisableNoWait(false)
				houseQuest.ChildBedRefsRoom2[1].DisableNoWait(false)
				if houseQuest.ChildChestRoom2.IsDisabled() == false
					houseQuest.ChildChestRoom2.DisableNoWait(false)
					houseQuest.ChildChestRoom2Replacement.enableNoWait(false)
				endIf
				houseQuest.ChildChestRoom2.RemoveAllItems(houseQuest.ChildChestRoom2Replacement, true, false)
				RelationshipAdoptable.UpdateHouseStatus()
				RelationshipAdoption.QueueMoveFamily(RelationshipAdoption.currentHome, true)
			endIf
		endIf
	endIf
endFunction

function BardPlayInstrumental(actor akBard, String asNewInstrument)

	if asNewInstrument != ""
		(akBard as byohhousebardscript).sInstrument = asNewInstrument
	endIf
	BardSongs.PlaySong(akBard as objectreference, (akBard as byohhousebardscript).sInstrument, true, 0, true)
endFunction

function PlayerChangeLocation(location akOldLoc, location akNewLoc)

	Bool bTriggeredEvent = false
	Int iOldLoc = -1
	Int iNewLoc = -1
	Int iCurrentLoc = 0
	while iCurrentLoc < HouseLocations.length
		if akNewLoc == HouseLocations[iCurrentLoc]
			iNewLoc = iCurrentLoc
		endIf
		if akOldLoc == HouseLocations[iCurrentLoc]
			iOldLoc = iCurrentLoc
		endIf
		iCurrentLoc += 1
	endWhile
	if akNewLoc == BYOHHouse1LocationInterior
		(HouseQuests[0] as byohhousescript).DisableInteriorSwapTriggers()
	elseIf akNewLoc == BYOHHouse2LocationInterior
		(HouseQuests[1] as byohhousescript).DisableInteriorSwapTriggers()
	elseIf akNewLoc == BYOHHouse3LocationInterior
		(HouseQuests[2] as byohhousescript).DisableInteriorSwapTriggers()
	endIf
	if !bTriggeredEvent && iOldLoc == -1 && iNewLoc == -1
		if utility.RandomInt(1, 100) < iBanditAttackPercent && GameDaysPassed.GetValue() > BYOHLastAttack.GetValue() + fNextAttackDays
			BYOHHouseBanditAttackKeyword.SendStoryEvent(none, none, none, 0, 0)
			bTriggeredEvent = true
		endIf
	endIf
	if LumbermillOperator.GetRef()
		if !akNewLoc || akNewLoc != LumbermillLocation.GetLocation() && !LumbermillLocation.GetLocation().IsChild(akNewLoc)
			self.ClearLumbermillOperator()
		else
			self.RegisterForAnimationEvent(LumbermillMarker.GetRef(), "MillLogIdleReset")
		endIf
	endIf
	if akNewLoc as Bool && (!akOldLoc || !akOldLoc.HasKeyword(BYOHHouseLocationKeyword)) && iNewLoc > -1
		self.EnableRoomFurniture(iNewLoc)
		if !bTriggeredEvent && utility.RandomInt(1, 100) < iSkeeverInfestPercent
			BYOHHouseSkeeverInfestationKeyword.SendStoryEvent(none, none, none, 0, 0)
			bTriggeredEvent = true
		endIf
	endIf
	if bSentIntroLetter == false && game.GetPlayer().GetLevel() >= iMinIntroLetterLevel
		actor player = game.GetPlayer()
		if JarlFalkreath.GetActorRef().GetRelationshipRank(player) < 2 && JarlHjaalmarch.GetActorRef().GetRelationshipRank(player) < 2 && JarlPale.GetActorRef().GetRelationshipRank(player) < 2
			if JarlFalkreath.GetActorRef().GetCrimeFaction().GetCrimeGold() == 0
				bSentIntroLetter = true
				HouseQuests[0].SetStage(iIntroLetterStage)
			endIf
		endIf
	endIf
	if iNewLoc == 0 || iOldLoc == 0
		BYOHHouse1LastVisit.SetValue(GameDaysPassed.GetValue())
	elseIf iNewLoc == 1 || iOldLoc == 1
		BYOHHouse2LastVisit.SetValue(GameDaysPassed.GetValue())
	elseIf iNewLoc == 2 || iOldLoc == 2
		BYOHHouse3LastVisit.SetValue(GameDaysPassed.GetValue())
	endIf
endFunction

Bool function EnableRoomFurniture(Int iHouseIndex)

	byohhousescript myHouseQuest = HouseQuests[iHouseIndex] as byohhousescript
	formlist roomFlags = myHouseQuest.RoomDoneFlags
	Float fLastVisit = 0 as Float
	if iHouseIndex == 0
		fLastVisit = BYOHHouse1LastVisit.GetValue()
	elseIf iHouseIndex == 1
		fLastVisit = BYOHHouse2LastVisit.GetValue()
	elseIf iHouseIndex == 2
		fLastVisit = BYOHHouse3LastVisit.GetValue()
	endIf
	Float fDaysAway = GameDaysPassed.GetValue() - fLastVisit
	Int iCurrentRoom = 0
	while iCurrentRoom < roomFlags.GetSize()
		Float fEnableCount = fDaysAway
		if (roomFlags.GetAt(iCurrentRoom) as globalvariable).GetValueInt() == 2
			objectreference[] roomEnableList = self.GetRoomEnableList(myHouseQuest, iCurrentRoom)
			formlist roomMasterList = RoomMasterLists[iCurrentRoom]
			Int iCurrentArrayIndex = 0
			Bool bFound = false
			while iCurrentArrayIndex < roomEnableList.length
				if roomEnableList[iCurrentArrayIndex].IsDisabled()
					bFound = true
					roomEnableList[iCurrentArrayIndex].enableNoWait(false)
					byohbuildingobjectscript baseObject = roomMasterList.GetAt(iCurrentArrayIndex) as byohbuildingobjectscript
					myHouseQuest.RoomHoldingChests[iCurrentRoom].additem(baseObject as form, 1, false)
					if iCurrentRoom < 2
						self.UpdateCompletionStatus(myHouseQuest, 1, baseObject.ID)
					else
						self.UpdateCompletionStatus(myHouseQuest, iCurrentRoom, baseObject.ID)
					endIf
					fEnableCount -= 1 as Float
					if fEnableCount <= 0 as Float
						iCurrentArrayIndex = roomEnableList.length
					endIf
				endIf
				iCurrentArrayIndex += 1
			endWhile
			if !bFound
				(roomFlags.GetAt(iCurrentRoom) as globalvariable).SetValue(3.00000)
			endIf
		endIf
		iCurrentRoom += 1
	endWhile
endFunction

function BuyChicken(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).BuyChicken()
	endIf
endFunction

function InitializeLumberVendorFaction()

	Int currentElement = 0
	while currentElement < LumberVendors.length
		(LumberVendors[currentElement] as actor).AddToFaction(BYOHLumberVendorFaction)
		currentElement += 1
	endWhile
endFunction

function BuyGarden(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).BuyGarden()
	endIf
endFunction

function BuyCow(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).BuyCow()
	endIf
endFunction

function InitializeOtherDLC()

	formlist vampireHateList = game.GetFormFromFile(39071, sDLC01Filename) as formlist
	if vampireHateList
		bInitializedOtherDLC = true
		Int iArrayIndex = 0
		while iArrayIndex < CrimeFactions.length
			vampireHateList.AddForm(CrimeFactions[iArrayIndex] as form)
			iArrayIndex += 1
		endWhile
		form BYOHDragonboneDagger = game.GetFormFromFile(85963, sDLC01Filename)
		form BYOHPrelateDagger = game.GetFormFromFile(92191, sDLC01Filename)
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(BYOHDragonboneDagger)
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(BYOHDragonboneDagger)
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(BYOHPrelateDagger)
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(BYOHPrelateDagger)
		form BYOHHuskyBareCompanionRace = game.GetFormFromFile(74423, sDLC01Filename)
		BYOHRelationshipAdoption_PetAllowedRacesList.AddForm(BYOHHuskyBareCompanionRace)
		BYOHRelationshipAdoption_PetDogsList.AddForm(BYOHHuskyBareCompanionRace)
		form BYOHHuskyArmoredCompanionRace = game.GetFormFromFile(15617, sDLC01Filename)
		BYOHRelationshipAdoption_PetAllowedRacesList.AddForm(BYOHHuskyArmoredCompanionRace)
		BYOHRelationshipAdoption_PetDogsList.AddForm(BYOHHuskyArmoredCompanionRace)
	endIf
endFunction

function BuildHouseExteriorPart(Int partHouseLocation, Int partID, form part)

	formlist foundList
	Int newHousePartIndex = self.GetFormListIndex(ExteriorMasterList, partID, part)
	if newHousePartIndex > -1
		(HouseQuests[partHouseLocation] as byohhousescript).BuildHouseExteriorPart(newHousePartIndex)
	endIf
	self.UpdateLogCount()
endFunction

function HireCarriageDriver(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).HireCarriageDriver()
	endIf
endFunction

Int function GetStewardIndex(actor akSteward)

	Int houseIndex = 0
	while houseIndex <= HouseQuests.length
		if HouseStewards[houseIndex].GetActorRef() == akSteward
			return houseIndex
		endIf
		houseIndex += 1
	endWhile
endFunction

function BuildHousePart(Int partHouseLocation, Int newHousePartID, form newHousePart, Int finishRoomID, Int startRoomID, Bool bDisableAdditionLayouts)

	while bBuildHousePart
		utility.wait(1.00000)
	endWhile
	bBuildHousePart = true
	byohhousescript myHouse = HouseQuests[partHouseLocation] as byohhousescript
	if bDisableAdditionLayouts
		myHouse.DisableAdditionLayout()
		actor player = game.GetPlayer()
		Int iCurrentIndex = 0
		Int layoutIndex = self.GetFormListIndex(BYOHHouseBuildingAdditionLayoutList, newHousePartID, newHousePart)
		form layoutToken = BYOHHouseBuildingAdditionLayoutTOKENList.GetAt(layoutIndex)
		myHouse.HouseHoldingChest.removeItem(BYOHHouseBuildingAdditionLayoutList as form, 99, true, none)
		myHouse.HouseHoldingChest.removeItem(BYOHHouseBuildingAdditionLayoutTOKENList as form, 99, true, none)
		player.removeItem(BYOHHouseBuildingAdditionLayoutList as form, 99, true, none)
		player.removeItem(BYOHHouseBuildingAdditionLayoutTOKENList as form, 99, true, none)
		myHouse.AddBuildingItemToPlayer(layoutToken)
	endIf
	Int newHousePartIndex = self.GetFormListIndex(BuildingMasterList, newHousePartID, newHousePart)
	if newHousePartIndex > -1
		myHouse.BuildHousePart(newHousePartIndex, finishRoomID, startRoomID)
		if startRoomID == 2
			if newHousePartID == iRoom2StyleID[0]
				myHouse.iStyleIndex = 0
			elseIf newHousePartID == iRoom2StyleID[1]
				myHouse.iStyleIndex = 1
			elseIf newHousePartID == iRoom2StyleID[2]
				myHouse.iStyleIndex = 2
			endIf
		endIf
		if finishRoomID > 0
			if RelationshipAdoption.currentHome == partHouseLocation + 6
				RelationshipAdoption.QueueMoveFamily(RelationshipAdoption.currentHome, true)
			endIf
			if myHouse.numRoomsCompleted >= 5
				if self.IsHouseComplete(myHouse)
					game.AddAchievement(63)
				endIf
				Int iHouseIndex = 0
				Int iHouseCompleteCount = 0
				while iHouseIndex < HouseQuests.length
					if self.IsHouseComplete(HouseQuests[iHouseIndex] as byohhousescript)
						iHouseCompleteCount += 1
					endIf
					iHouseIndex += 1
				endWhile
				if iHouseCompleteCount >= HouseQuests.length
					game.AddAchievement(65)
				endIf
			endIf
		endIf
	endIf
	self.UpdateLogCount()
	bBuildHousePart = false
endFunction

function InitializeDLC()

	actor player = game.GetPlayer()
	Int iArrayIndex = 0
	while iArrayIndex < CrimeFactions.length
		WerewolfHateFactions.AddForm(CrimeFactions[iArrayIndex] as form)
		CrimeFactionsList.AddForm(CrimeFactions[iArrayIndex] as form)
		iArrayIndex += 1
	endWhile
	Int iCurrentLoc = 0
	while iCurrentLoc < HouseLocations.length
		HouseLocations[iCurrentLoc].SetKeywordData(WIDragonsToggle, -1.00000)
		iCurrentLoc += 1
	endWhile
	if JarlFalkreath.GetActorRef().GetRelationshipRank(player) >= 2
		bSentFriendLetter = true
		HouseQuests[0].SetStage(iFriendLetterStage)
	elseIf JarlHjaalmarch.GetActorRef().GetRelationshipRank(player) >= 2
		bSentFriendLetter = true
		HouseQuests[1].SetStage(iFriendLetterStage)
	elseIf JarlPale.GetActorRef().GetRelationshipRank(player) >= 2
		bSentFriendLetter = true
		HouseQuests[2].SetStage(iFriendLetterStage)
	elseIf player.GetLevel() >= iMinIntroLetterLevel
		bSentIntroLetter = true
		HouseQuests[0].SetStage(iIntroLetterStage)
	endIf
	if JarlFalkreath.GetActorRef().GetRelationshipRank(player) >= 3
		HousecarlFalkreath.Enable(false)
	elseIf Favor258Falkreath.IsRunning()
		PlayerHousecarlFalkreath.ForceRefTo(HousecarlFalkreath)
	endIf
	if JarlHjaalmarch.GetActorRef().GetRelationshipRank(player) >= 3
		HousecarlHjaalmarch.Enable(false)
	elseIf Favor255Hjaalmarch.IsRunning()
		PlayerHousecarlHjaalmarch.ForceRefTo(HousecarlHjaalmarch)
	endIf
	if JarlPale.GetActorRef().GetRelationshipRank(player) >= 3
		HousecarlPale.Enable(false)
	elseIf Favor256Pale.IsRunning()
		PlayerHousecarlPale.ForceRefTo(HousecarlPale)
	endIf
endFunction

; Skipped compiler generated GetState

function DismissSteward(Int houseIndex, actor akSteward)

	if HouseStewards[houseIndex].GetActorRef() == akSteward
		HouseStewards[houseIndex].Clear()
		(HouseQuests[houseIndex] as byohhousescript).bHaveSteward = false
	endIf
endFunction

objectreference[] function GetRoomEnableList(byohhousescript houseQuest, Int iRoomID)

	if iRoomID == 0
		return houseQuest.Room01AEnableList
	elseIf iRoomID == 1
		return houseQuest.Room01BEnableList
	elseIf iRoomID == 2
		return houseQuest.Room02EnableList
	elseIf iRoomID == 3
		return houseQuest.Room03EnableList
	elseIf iRoomID == 4
		return houseQuest.Room04EnableList
	elseIf iRoomID == 5
		return houseQuest.Room05EnableList
	elseIf iRoomID == 6
		return houseQuest.Room06EnableList
	elseIf iRoomID == 7
		return houseQuest.Room07EnableList
	elseIf iRoomID == 8
		return houseQuest.Room08EnableList
	elseIf iRoomID == 9
		return houseQuest.Room09EnableList
	elseIf iRoomID == 10
		return houseQuest.Room10EnableList
	elseIf iRoomID == 11
		return houseQuest.Room11EnableList
	elseIf iRoomID == 12
		return houseQuest.Room12EnableList
	endIf
endFunction

Bool function EnableAllFurniture(Int iHouseIndex)

	byohhousescript myHouseQuest = HouseQuests[iHouseIndex] as byohhousescript
	formlist roomFlags = myHouseQuest.RoomDoneFlags
	Int iCurrentRoom = 1
	while iCurrentRoom < roomFlags.GetSize()
		if (roomFlags.GetAt(iCurrentRoom) as globalvariable).GetValueInt() >= 1
			objectreference[] roomEnableList = self.GetRoomEnableList(myHouseQuest, iCurrentRoom)
			formlist roomMasterList = RoomMasterLists[iCurrentRoom]
			Int iCurrentArrayIndex = 0
			while iCurrentArrayIndex < roomEnableList.length
				if roomEnableList[iCurrentArrayIndex].IsDisabled()
					roomEnableList[iCurrentArrayIndex].enableNoWait(false)
					byohbuildingobjectscript baseObject = roomMasterList.GetAt(iCurrentArrayIndex) as byohbuildingobjectscript
					myHouseQuest.RoomHoldingChests[iCurrentRoom].additem(baseObject as form, 1, false)
					if iCurrentRoom < 2
						self.UpdateCompletionStatus(myHouseQuest, 1, baseObject.ID)
					else
						self.UpdateCompletionStatus(myHouseQuest, iCurrentRoom, baseObject.ID)
					endIf
				endIf
				iCurrentArrayIndex += 1
			endWhile
			(roomFlags.GetAt(iCurrentRoom) as globalvariable).SetValue(3.00000)
		endIf
		iCurrentRoom += 1
	endWhile
endFunction

function BuyHorse(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).BuyHorse()
	endIf
endFunction

Int function FindArrayIndex(Int[] myArray, Int searchValue)

	return myArray.find(searchValue, 0)
endFunction

function HireBard(actor akSteward)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if houseIndex > -1
		(HouseQuests[houseIndex] as byohhousescript).HireBard()
	endIf
endFunction

function UpdateLogCount()

	Int logCount = game.GetPlayer().GetItemCount(BYOHMaterialLog as form)
	BYOHHouseLogCount.SetValue(logCount as Float)
	self.UpdateCurrentInstanceGlobal(BYOHHouseLogCount)
	Int currentElement = 0
	while currentElement < LogPiles.length
		if houseOwned[currentElement]
			if logCount > 0
				if LogPiles[currentElement].IsDisabled()
					
				endIf
				LogPiles[currentElement].enableNoWait(false)
			else
				if LogPiles[currentElement].IsDisabled() == false
					
				endIf
				LogPiles[currentElement].DisableNoWait(false)
			endIf
		endIf
		currentElement += 1
	endWhile
endFunction

Bool function CheckCompletionStatus(Int[] arrayToCheck, Int[] countValue, Int partID)

	if self.FindArrayIndex(arrayToCheck, partID) > -1
		countValue[0] = countValue[0] + 1
		if countValue[0] >= arrayToCheck.length
			return true
		endIf
	endIf
	return false
endFunction

function SetActiveHouseLocation(objectreference workbench, Int newRoomID, String newVariantID)

	activeRoomID = newRoomID
	activeVariantID = newVariantID
	Int locIndex = 0
	while locIndex < HouseLocations.length
		if workbench.GetCurrentLocation().IsSameLocation(HouseLocations[locIndex], BYOHHouseLocationKeyword)
			activeHouseLocation = locIndex
			locIndex = HouseLocations.length
		endIf
		locIndex += 1
	endWhile
	actor player = game.GetPlayer()
	Int deerhide02Count = player.GetItemCount(DeerHide02 as form)
	if deerhide02Count > 0
		player.removeItem(DeerHide02 as form, deerhide02Count, true, none)
		player.additem(DeerHide as form, deerhide02Count, true)
	endIf
endFunction

function BuildHouseInteriorPart(Int partHouseLocation, Int partID, form part, Int roomID)

	formlist foundList
	String currentVariantID = activeVariantID
	if roomID == 1
		if currentVariantID == "A"
			foundList = RoomMasterLists[0]
		elseIf currentVariantID == "B"
			foundList = RoomMasterLists[1]
		endIf
	else
		foundList = RoomMasterLists[roomID]
	endIf
	if foundList == none
		return 
	endIf
	Int newHousePartIndex = self.GetFormListIndex(foundList, partID, part)
	if newHousePartIndex > -1
		(HouseQuests[partHouseLocation] as byohhousescript).BuildHouseInteriorPart(roomID, currentVariantID, newHousePartIndex)
		self.UpdateCompletionStatus(HouseQuests[partHouseLocation] as byohhousescript, roomID, partID)
	endIf
	self.UpdateLogCount()
endFunction

function SetLumbermillOperator(objectreference NPC)

	Int lumbermillIndex = LumberVendors.find(NPC, 0)
	if lumbermillIndex >= 0
		LumbermillMarker.ForceRefTo(Lumbermills[lumbermillIndex])
		LumbermillOperator.ForceRefTo(NPC)
		LumbermillLocation.ForceLocationTo(LumbermillMarker.GetRef().GetEditorLocation())
		(NPC as actor).EvaluatePackage()
		self.RegisterForAnimationEvent(Lumbermills[lumbermillIndex], "MillLogIdleReset")
	endIf
endFunction

function HireSteward(Int houseIndex, actor akNewSteward)

	HouseStewards[houseIndex].ForceRefTo(akNewSteward as objectreference)
	(HouseQuests[houseIndex] as byohhousescript).bHaveSteward = true
	DialogueFollower.DismissFollower(0, 0)
endFunction

function SetTrophyBase(objectreference newTrophyBase, objectreference newTrophyBuildMarker, objectreference newTrophyIdleMarker)

	TrophyBase = newTrophyBase
	TrophyBuildMarker = newTrophyBuildMarker
	TrophyIdleMarker = newTrophyIdleMarker
endFunction

function BuyProperty(Int newHouseLocation)

	houseOwned[newHouseLocation] = true
endFunction

function RemodelEntryRoom(Int partHouseLocation, Int partID)

	(HouseQuests[partHouseLocation] as byohhousescript).RemodelEntryRoom(partID)
endFunction

function BuyBuildingMaterial(actor akSteward, Int iMaterialType)

	Int houseIndex = self.GetStewardIndex(akSteward)
	if iMaterialType == 0
		game.GetPlayer().removeItem(Gold001 as form, BYOHHPCostLogs.GetValueInt(), false, none)
		game.GetPlayer().additem(BYOHMaterialLog as form, BYOHHPAmountLogs.GetValueInt(), true)
	elseIf iMaterialType == 1
		game.GetPlayer().removeItem(Gold001 as form, BYOHHPCostStone.GetValueInt(), false, none)
		(HouseQuests[houseIndex] as byohhousescript).StewardChest.additem(BYOHMaterialStoneBlock as form, BYOHHPAmountStone.GetValueInt(), false)
	elseIf iMaterialType == 2
		game.GetPlayer().removeItem(Gold001 as form, BYOHHPCostClay.GetValueInt(), false, none)
		(HouseQuests[houseIndex] as byohhousescript).StewardChest.additem(BYOHMaterialClay as form, BYOHHPAmountClay.GetValueInt(), false)
	endIf
endFunction

Bool function BuyRoomFurniture(actor akSteward, Int iRoomID)

	Int houseIndex = self.GetStewardIndex(akSteward)
	byohhousescript myHouseQuest = HouseQuests[houseIndex] as byohhousescript
	formlist roomFlags = myHouseQuest.RoomDoneFlags
	globalvariable roomFlag = roomFlags.GetAt(iRoomID) as globalvariable
	if roomFlag.GetValueInt() == 1
		game.GetPlayer().removeItem(Gold001 as form, (BYOHHouseRoomCostList.GetAt(iRoomID) as globalvariable).GetValueInt(), false, none)
		roomFlag.SetValue(2.00000)
	endIf
endFunction
