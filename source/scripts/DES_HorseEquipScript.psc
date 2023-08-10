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
Bool Property UnequipRunning auto
Bool Property EquipRunning auto
Actor Property PlayerRef auto
Spell Property DES_TrampleCloak auto
Spell Property DES_HorseFear auto
Spell Property DES_HorseRally auto
Quest Property CCHorseArmorDialogueQuest auto
Quest Property ccBGSSSE034_HorseSaddleQuest auto
Keyword Property DES_ArmorKeyword auto
Keyword Property DES_SaddleKeyword auto
Quest Property DES_RenameHorseQuest auto
Outfit Property DES_NakedHorseOutfit auto
Bool Property Debugging auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	if !DES_HorseAllForms.HasForm(akBaseItem) && (DES_RenameHorseQuest as DES_HorseInventoryScript).SaddleBags == False
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " isn't wearing a saddle.")
	elseif DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.IsEquipped(DES_HorseArmors)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " is already equipped.")
		return
	elseif akBaseItem == CCHorseArmorMiscArmorElven
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(0)
		EquipHorseArmor(PlayersHorse)
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(1)
		EquipHorseArmor(PlayersHorse)
	elseif akBaseItem == DES_Saddle
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddle)
		EquipHorseSaddle(PlayersHorse)
	elseif akBaseItem == DES_WhiteSaddle
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(ccBGSSSE034_HorseSaddleLight)
		EquipHorseSaddle(PlayersHorse)
	elseif akBaseItem == DES_ImperialSaddle
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddleImperial)
		EquipHorseSaddle(PlayersHorse)		
	elseif akBaseItem == DES_StormcloakSaddle
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(ccBGSSSE034_HorseSaddleStormcloak)
		EquipHorseSaddle(PlayersHorse)
	elseif akBaseItem == DES_DarkBrotherhoodSaddle
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddleShadowmere)
		EquipHorseSaddle(PlayersHorse)
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	if DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.GetItemCount(DES_HorseMiscItems) >= 1
		return
	elseif akBaseItem.HasKeyword(DES_ArmorKeyword) || akBaseItem.HasKeyword(DES_SaddleKeyword)
		UnequipRunning = true
		UI.InvokeString("HUD Menu", "_global.skse.CloseMenu", "ContainerMenu")
		PlayersHorse.RemoveItem(DES_HorseAllForms)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).RemoveHorseArmor()
		IF PlayersHorse.GetNumItems() > 0 && akBaseItem.HasKeyword(DES_SaddleKeyword)
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s saddle has been emptied into your inventory.")
			PlayersHorse.RemoveAllItems(akTransferTo = PlayerRef)
		ENDIF
		UnequipHorse(PlayersHorse)
	endif
EndEvent

Function UnequipHorse(Actor PlayersHorse)
	GoToState("ChangingHorse")
	self.ForceRefTo(PlayersHorse)
	GoToState("Unequipped")
EndFunction

Function EquipHorseArmor(Actor PlayersHorse)
	GoToState("ChangingHorse")
	self.ForceRefTo(PlayersHorse)
	GoToState("Armored")
EndFunction

Function EquipHorseSaddle(Actor PlayersHorse)
	GoToState("ChangingHorse")
	self.ForceRefTo(PlayersHorse)
	GoToState("Saddled")
EndFunction

Function RemoveHorseAbilities(Actor PlayersHorse)
	PlayersHorse.RemoveSpell(DES_TrampleCloak)
	PlayersHorse.RemoveSpell(DES_HorseRally)
	PlayersHorse.RemoveSpell(DES_HorseFear)
EndFunction

State Unequipped
	Event OnBeginState()
		Actor PlayersHorse = GetActorReference()
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Unequipped")
		ENDIF
		RemoveHorseAbilities(PlayersHorse)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(none)
		PlayersHorse.SetOutfit(DES_NakedHorseOutfit)
		PlayersHorse.SetAV("CarryWeight", ((DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight))
		(DES_RenameHorseQuest as DES_HorseInventoryScript).SaddleBags = false			
		UnequipRunning = False
	EndEvent
EndState

State Armored
	Event OnBeginState()
		Actor PlayersHorse = GetActorReference()
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Armored")
		ENDIF
		PlayersHorse.SetAV("CarryWeight", 0.0)
		PlayersHorse.AddSpell(DES_TrampleCloak)
		PlayersHorse.AddSpell(DES_HorseRally)
		(DES_RenameHorseQuest as DES_HorseInventoryScript).SaddleBags = false
	EndEvent
	
	Event OnEndState()
		Actor PlayersHorse = GetActorReference()
		PlayersHorse.RemoveSpell(DES_TrampleCloak)
		PlayersHorse.RemoveSpell(DES_HorseRally)
	EndEvent
EndState

State Saddled
	Event OnBeginState()
		Actor PlayersHorse = GetActorReference()
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Saddled")
		ENDIF
		PlayersHorse.SetAV("CarryWeight", (papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "CarryWeight", 105.0)))
		PlayersHorse.AddSpell(DES_HorseFear)
		(DES_RenameHorseQuest as DES_HorseInventoryScript).SaddleBags = true
	EndEvent
	
	Event OnEndState()
		Actor PlayersHorse = GetActorReference()
		PlayersHorse.RemoveSpell(DES_HorseFear)
	EndEvent
EndState

State ChangingHorse

EndState
