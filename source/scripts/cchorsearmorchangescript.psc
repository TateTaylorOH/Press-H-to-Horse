;/ Decompiled by Champollion V1.0.1
Source   : CCHorseArmorChangeScript.psc
ModIFied : 2020-02-19 18:48:13
Compiled : 2021-12-15 14:09:59
User     : builds
Computer : RKVBGSBUILD08
/;
scriptName CCHorseArmorChangeScript extends Quest
{Changes horse armors at hostlers and blacksmiths}

;-- Properties --------------------------------------
message property CCHorseArmorMessageNotEnoughGold auto
globalvariable property CCHorseArmorCost auto
Quest property Stables auto
faction property PlayerHorseFaction auto
message property CCHorseArmorMessageArmorChanged auto
message property CCHorseArmorMessageArmorRemoved auto
armor[] property ArrayUnicornArmors auto
message property CCHorseArmorMessageNoHorsesOwned auto
spell property CCHorseArmorAbEssentialFlag auto
actor property PlayerRef auto
message property CCHorseArmorMessageArmorAlreadyEquipped auto
actorbase[] property DisallowedHorses auto
globalvariable property CCHorseArmorCostSwapOnly auto
referencealias property StablesPlayersHorse auto
keyword property ccDisallowSaddleSwap auto
miscobject[] property ArrayHorseArmorsMisc auto
miscobject property Gold001 auto
formlist property CCHorseArmorList auto
armor[] property ArrayHorseArmors auto
message property CCHorseArmorMessageArmorCannotUse auto

;-- Variables ---------------------------------------
armor[] ArrayArmors

;-- FUNCTIONs ---------------------------------------

FUNCTION ChangeHorseArmor(Int ArmorID)

	actor PlayerHorseREF = self.GetPlayerHorse()
	IF PlayerHorseREF as Bool && !PlayerHorseREF.IsDead()
		IF self.CanChangeHorseArmor(PlayerHorseREF)
			IF self.IsUnicorn(PlayerHorseREF)
				ArrayArmors = ArrayUnicornArmors
			else
				ArrayArmors = ArrayHorseArmors
			ENDIF
			armor ArmorToEquip = ArrayArmors[ArmorID]
			IF ArmorToEquip
				IF PlayerHorseREF.IsEquipped(ArmorToEquip as form)
					CCHorseArmorMessageArmorAlreadyEquipped.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
				else
					Int costGold
					miscobject inventoryItem = self.GetMiscObjectForArmor(ArmorToEquip)
					Bool doEquipArmor = false
					Bool removeMiscItem = false
					IF PlayerRef.GetItemCount(inventoryItem as form)
						costGold = CCHorseArmorCostSwapOnly.GetValueInt()
						removeMiscItem = true
					else
						costGold = CCHorseArmorCost.GetValueInt()
					ENDIF
					;IF PlayerRef.GetItemCount(Gold001 as form) >= costGold
						doEquipArmor = true
						;PlayerRef.RemoveItem(Gold001 as form, costGold, false, none)
						;IF removeMiscItem
						;	PlayerRef.RemoveItem(inventoryItem as form, 1, false, none)
						;ENDIF
					;else
					;	CCHorseArmorMessageNotEnoughGold.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
					;	doEquipArmor = false
					;ENDIF
					IF doEquipArmor
						self.FirstTimeEquipHorseArmor(PlayerHorseREF, ArmorToEquip)
					ENDIF
				ENDIF
			ENDIF
		else
			CCHorseArmorMessageArmorCannotUse.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		ENDIF
	else
		CCHorseArmorMessageNoHorsesOwned.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	ENDIF
ENDFUNCTION

FUNCTION FirstTimeEquipHorseArmor(actor akPlayerHorseRef, armor akArmorToEquip)

	self.SwapArmorForMiscObject(akPlayerHorseRef)
	akPlayerHorseRef.UnequipItemSlot(45)
	akPlayerHorseRef.EquipItem(akArmorToEquip as form, 1 as Bool, false)
	CCHorseArmorMessageArmorChanged.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	IF !akPlayerHorseRef.IsEssential()
		akPlayerHorseRef.GetActorBase().SetEssential(true)
		akPlayerHorseRef.AddSpell(CCHorseArmorAbEssentialFlag, true)
	ENDIF
ENDFUNCTION

; Skipped compiler generated GetState

; Skipped compiler generated GoToState

armor FUNCTION GetArmorForMiscObject(miscobject HorseArmorMisc)

	Int arrayPos = ArrayHorseArmorsMisc.find(HorseArmorMisc, 0)
	return ArrayArmors[arrayPos]
ENDFUNCTION

miscobject FUNCTION GetMiscObjectForArmor(armor HorseArmor)

	Int arrayPos = ArrayArmors.find(HorseArmor, 0)
	return ArrayHorseArmorsMisc[arrayPos]
ENDFUNCTION

Bool FUNCTION SwapArmorForMiscObject(actor PlayerHorse)

	Bool RemovedArmor = false
	Int i = 0
	while i < ArrayArmors.length
		IF PlayerHorse.IsEquipped(ArrayArmors[i] as form)
			;PlayerRef.AddItem(ArrayHorseArmorsMisc[i] as form, 1, false)
			PlayerHorse.RemoveItem(ArrayArmors[i] as form, 1, false, none)
			RemovedArmor = true
		ENDIF
		i += 1
	endWhile
	return RemovedArmor
ENDFUNCTION

FUNCTION RemoveHorseArmor()

	actor PlayerHorseREF = self.GetPlayerHorse()
	IF PlayerHorseREF
		IF self.SwapArmorForMiscObject(PlayerHorseREF)
			CCHorseArmorMessageArmorRemoved.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
		ENDIF
		PlayerHorseREF.RemoveItem(CCHorseArmorList as form, 999, false, none)
		IF PlayerHorseREF.HasSpell(CCHorseArmorAbEssentialFlag as form)
			PlayerHorseREF.GetActorBase().SetEssential(false)
			PlayerHorseREF.RemoveSpell(CCHorseArmorAbEssentialFlag)
		ENDIF
	else
		CCHorseArmorMessageNoHorsesOwned.Show(0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000)
	ENDIF
ENDFUNCTION

actor FUNCTION GetPlayerHorse()

	;IF game.GetPlayersLastRiddenHorse()
	;	return game.GetPlayersLastRiddenHorse()
	IF StablesPlayersHorse.GetActorReference()
		return StablesPlayersHorse.GetActorReference()
	else
		return none
	ENDIF
ENDFUNCTION

Bool FUNCTION CanChangeHorseArmor(actor PlayerHorse)

	keyword ccBGSSSE034WildHorseKeyword = game.GetFormFromFile(2088, "ccBGSSSE034-MntUni.esl") as keyword
	IF DisallowedHorses.find(PlayerHorse.GetActorBase(), 0) != -1 || PlayerHorse.HasKeyword(ccDisallowSaddleSwap)
		return false
	ELSEIF PlayerHorse.HasKeyword(ccBGSSSE034WildHorseKeyword) && !PlayerHorse.IsInFaction(PlayerHorseFaction)
		return false
	else
		return true
	ENDIF
ENDFUNCTION

Bool FUNCTION IsUnicorn(actor akPlayerHorseRef)

	actorbase Unicorn = game.GetFormFromFile(2052, "ccBGSSSE034-MntUni.esl") as actorbase
	return Unicorn as Bool && akPlayerHorseRef.GetActorBase() == Unicorn
ENDFUNCTION
