Scriptname DES_HorseEquipScript extends ReferenceAlias  

;INVENTORY OBJECTS
MiscObject Property CCHorseArmorMiscArmorSteel auto
MiscObject Property CCHorseArmorMiscArmorElven auto
MiscObject Property DES_Saddle auto
MiscObject Property DES_WhiteSaddle auto
MiscObject Property DES_ImperialSaddle auto
MiscObject Property DES_StormcloakSaddle auto
MiscObject Property DES_DarkBrotherhoodSaddle auto

;ARMOR TO EQUIP
Armor Property CCHorseArmorElven auto
Armor Property CCHorseArmorSteel auto
Armor Property HorseSaddle auto
Armor Property ccBGSSSE034_HorseSaddleLight auto
Armor Property HorseSaddleImperial auto
Armor Property ccBGSSSE034_HorseSaddleStormcloak auto
Armor Property HorseSaddleShadowmere auto

Formlist Property DES_HorseMiscItems auto
Formlist Property DES_HorseArmors auto
Formlist Property DES_HorseAllForms auto
Bool Property SaddleBags auto
Actor Property PlayerRef auto
Spell Property DES_TrampleCloak auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	if !DES_HorseAllForms.HasForm(akBaseItem) && (SaddleBags == False)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " isn't wearing a saddle.")
	elseif DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.IsEquipped(DES_HorseArmors)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " is already equipped.")
		return
	elseif akBaseItem == CCHorseArmorMiscArmorElven
		PlayersHorse.EquipItem(CCHorseArmorElven, true)
		EquipHorseArmor()
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		PlayersHorse.EquipItem(CCHorseArmorSteel, true)
		EquipHorseArmor()
	elseif akBaseItem == DES_Saddle
		PlayersHorse.EquipItem(HorseSaddle, true)
		EquipHorseSaddle()
	elseif akBaseItem == DES_WhiteSaddle
		PlayersHorse.EquipItem(ccBGSSSE034_HorseSaddleLight, true)
		EquipHorseSaddle()
	elseif akBaseItem == DES_ImperialSaddle
		PlayersHorse.EquipItem(HorseSaddleImperial, true)
		EquipHorseSaddle()		
	elseif akBaseItem == DES_StormcloakSaddle
		PlayersHorse.EquipItem(ccBGSSSE034_HorseSaddleStormcloak, true)
		EquipHorseSaddle()
	elseif akBaseItem == DES_DarkBrotherhoodSaddle
		PlayersHorse.EquipItem(HorseSaddleShadowmere, true)
		EquipHorseSaddle()
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	if DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.GetItemCount(DES_HorseMiscItems) >= 1
		return
	elseif akBaseItem == CCHorseArmorMiscArmorElven
		PlayersHorse.UnequipItem(CCHorseArmorElven)
		PlayersHorse.RemoveItem(CCHorseArmorElven)
		UnequipHorse()
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		PlayersHorse.UnequipItem(CCHorseArmorSteel)
		PlayersHorse.RemoveItem(CCHorseArmorSteel)
		UnequipHorse()
	elseif akBaseItem == DES_Saddle
		PlayersHorse.UnequipItem(HorseSaddle)
		PlayersHorse.RemoveItem(HorseSaddle)
		UnequipHorse()
	elseif akBaseItem == DES_WhiteSaddle
		PlayersHorse.UnequipItem(ccBGSSSE034_HorseSaddleLight)
		PlayersHorse.RemoveItem(ccBGSSSE034_HorseSaddleLight)
		UnequipHorse()
	elseif akBaseItem == DES_ImperialSaddle
		PlayersHorse.UnequipItem(HorseSaddleImperial)
		PlayersHorse.RemoveItem(HorseSaddleImperial)
		UnequipHorse()
	elseif akBaseItem == DES_StormcloakSaddle
		PlayersHorse.UnequipItem(ccBGSSSE034_HorseSaddleStormcloak)
		PlayersHorse.RemoveItem(ccBGSSSE034_HorseSaddleStormcloak)
		UnequipHorse()		
	elseif akBaseItem == DES_DarkBrotherhoodSaddle
		PlayersHorse.UnequipItem(HorseSaddleShadowmere)
		PlayersHorse.RemoveItem(HorseSaddleShadowmere)
		UnequipHorse()
	endif
EndEvent

Function UnequipHorse()
	Actor PlayersHorse = self.GetActorReference()
	IF PlayersHorse.GetNumItems() > 0
		Debug.Notification(PlayersHorse.GetDisplayName() + "'s saddle has been emptied to your inventory.")
		UI.InvokeString("HUD Menu", "_global.skse.CloseMenu", "ContainerMenu")
	ENDIF
	PlayersHorse.RemoveAllItems(akTransferTo = PlayerRef)
	PlayersHorse.RemoveSpell(DES_TrampleCloak)
	PlayersHorse.SetAV("SpeedMult", 125.0)
	PlayersHorse.SetAV("CarryWeight", 999.0)
	SaddleBags = False
EndFunction

Function EquipHorseArmor()
	Actor PlayersHorse = self.GetActorReference()
	PlayersHorse.SetAV("Aggression", 2)
	PlayersHorse.SetAV("Confidence", 3)
	PlayersHorse.SetAV("CarryWeight", 0.0)
	PlayersHorse.AddSpell(DES_TrampleCloak)
	SaddleBags = False
EndFunction

Function EquipHorseSaddle()
	Actor PlayersHorse = self.GetActorReference()
	PlayersHorse.SetAV("Aggression", 0)
	PlayersHorse.SetAV("Confidence", 0)
	PlayersHorse.SetAV("CarryWeight", 100.0)
	SaddleBags = True
EndFunction