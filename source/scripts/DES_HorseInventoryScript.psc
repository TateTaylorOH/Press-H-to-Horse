Scriptname DES_HorseInventoryScript extends Quest  

Actor Property DES_HorseStomachRef auto
Actor Property HorseToEquip auto
Actor Property PlayerRef auto
Armor[] Property HorseArmorList auto
Bool Property Debugging auto
Bool Property EquipRunning auto
Bool Property UnequipRunning auto
Faction Property PlayerHorseFaction auto
Formlist Property DES_CarFood auto
Formlist Property DES_HorseAllForms auto
Formlist Property DES_HorseArmors auto
Formlist Property DES_HorseFood auto
Formlist Property DES_HorseMiscItems auto
Formlist Property DES_OwnedHorses auto
GlobalVariable Property DES_PlayerOwnsHorse auto
int Property BaseCarryWeight auto
Keyword Property CCHorseArmorKeyword auto
Keyword Property DES_ArmorKeyword auto
Keyword Property DES_SaddleKeyword auto
MiscObject[] Property MiscItemList auto
Outfit Property DES_NakedHorseOutfit auto
Quest Property ccBGSSSE034_HorseSaddleQuest auto
Quest Property CCHorseArmorDialogueQuest auto
Quest Property DES_RenameHorseQuest auto
ReferenceAlias Property Alias_PlayersHorse auto
Spell Property DES_HorseFear auto
Spell Property DES_HorseRally auto
Spell Property DES_TrampleCloak auto

Event OnKeyUp(Int KeyCode, Float HoldTime)
	If KeyCode == (DES_RenameHorseQuest as DES_HorseCallScript).horsekey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled() && Game.GetCurrentCrosshairRef()
	Actor DwarvenHorse = Game.GetFormFromFile(0x38D5, "cctwbsse001-puzzledungeon.esm") As Actor
	Actor Reindeer = Game.GetFormFromFile(0x80E, "ccvsvsse001-winter.esl") as Actor
	Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF HoldTime < papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "HoldTime", 0.9000)
			Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
			Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
			If Game.GetCurrentCrosshairRef() == PlayersHorse && PlayersHorse && PlayersHorse.IsInFaction(PlayerHorseFaction) && !PlayersHorse.IsDead() && Game.GetCurrentCrosshairRef()!= DwarvenHorse
				RegisterForMenu("ContainerMenu")
				IF (GetState() == "Saddled")
					IF Debugging
						Debug.Notification(PlayersHorse.GetDisplayName() + "'s current state: Saddled")
					ENDIF
					PlayersHorse.SetAV("CarryWeight", (papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "CarryWeight", 105.0)))
				ELSEIF (GetState() == "Armored")
					IF Debugging
						Debug.Notification(PlayersHorse.GetDisplayName() + "'s current state: Armored")
					ENDIF
					PlayersHorse.SetAV("CarryWeight", 0.0)
				ELSEIF (GetState() == "Unequipped")
					IF Debugging
						Debug.Notification(PlayersHorse.GetDisplayName() + "'s current state: Unequipped")
					ENDIF
					PlayersHorse.SetAV("CarryWeight", BaseCarryWeight)
				ENDIF
				PlayersHorse.OpenInventory(true)
			Else
				Alias_PlayersHorse.Clear()
			EndIf
		Else
			Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
			Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
			If Game.GetCurrentCrosshairRef() == PlayersHorse && PlayersHorse.IsInFaction(PlayerHorseFaction) && !PlayersHorse.IsDead()
				RegisterForMenu("GiftMenu")
				IF PlayersHorse != DwarvenHorse
					DES_HorseStomachRef.ShowGiftMenu(true, DES_HorseFood)
				ELSE
					DES_HorseStomachRef.ShowGiftMenu(true, DES_CarFood)
				ENDIF
			Else
				Alias_PlayersHorse.Clear()
			EndIf
		ENDIF
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "ContainerMenu"
		UnregisterForMenu("InventoryMenu")
		while UnequipRunning == true
			utility.wait(0.1)
		endwhile
		Alias_PlayersHorse.Clear()
	ELSEIF MenuName == "GiftMenu"
		UnregisterForMenu("GiftMenu")
		Alias_PlayersHorse.Clear()
	EndIf
EndEvent

Function FirstTimeEquipHorse(Actor PlayersHorse)
{This will prepare the horse for use within the H2Horse framework. It will set the horse's outfit to be blank, then check what armor the horse was wearing, give that horse the matching miscitem and reequip their inital gear. It is then handed of to the equip script to set carry weight and AI.}
	Armor ReindeerSaddle = game.GetFormFromFile(0x804, "ccvsvsse001-winter.esl") as Armor
	DES_HorseInventoryScript Inventory = (DES_RenameHorseQuest as DES_HorseInventoryScript)
	Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
	IF !PlayersHorse.IsInFaction(PlayerHorseFaction)
		PlayersHorse.SetFactionRank(PlayerHorseFaction, 1)
	ENDIF
	IF !DES_OwnedHorses.HasForm(PlayersHorse)
		DES_OwnedHorses.AddForm(PlayersHorse)
	ENDIF
	DES_PlayerOwnsHorse.SetValue(1)
	Inventory.BaseCarryWeight = PlayersHorse.GetBaseAV("CarryWeight") as int
	IF Inventory.BaseCarryWeight == 0
		Inventory.BaseCarryWeight = 999
	ENDIF
	Int i = HorseArmorList.Find(PlayersHorse.GetEquippedArmorInSlot(45))
	IF Debugging
		Debug.Notification(i + " " + HorseArmorList[i].GetName() + " " + MiscItemList[i].GetName())
	ENDIF
	IF PlayersHorse.IsEquipped(DES_HorseArmors) && PlayersHorse.GetItemCount(MiscItemList) == 0
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + " is being equipped for the first time.")
		ENDIF
		PlayersHorse.RemoveItem(DES_HorseArmors)
		PlayersHorse.AddItem(MiscItemList[i], 1)
		IF (PlayersHorse.GetEquippedArmorInSlot(45)).HasKeyword(CCHorseArmorKeyword)
			IF Debugging
				Debug.Notification(PlayersHorse.GetDisplayName() + " is wearing armor.")
			ENDIF
			(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(i)
			Inventory.EquipHorseArmor(PlayersHorse)
		ELSEIF PlayersHorse.IsEquipped(DES_HorseArmors)
			IF Debugging
				Debug.Notification(PlayersHorse.GetDisplayName() + " is wearing a saddle.")
			ENDIF
			Inventory.EquipHorseSaddle(PlayersHorse)
			(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseArmorList[i])
		ENDIF
	ENDIF
	Alias_PlayersHorse.Clear()
EndFunction

Function EquipItem(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Actor PlayersHorse)
	IF !DES_HorseAllForms.HasForm(akBaseItem)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " isn't wearing a saddle.")
	ELSEIF DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.IsEquipped(DES_HorseArmors)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " is already equipped.")
		return
	ELSEIF akBaseItem.HasKeyword(DES_ArmorKeyword)
		Int i = MiscItemList.Find(akBaseItem as MiscObject)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(i)
		EquipHorseArmor(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(DES_HorseArmors)
		Int i = MiscItemList.Find(akBaseItem as MiscObject)
		EquipHorseSaddle(PlayersHorse)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseArmorList[i])
	ENDIF
endFunction

Function UnequipItem(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Actor PlayersHorse)
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
endFunction

Function UnequipHorse(Actor PlayersHorse)
	GoToState("ChangingHorse")
	HorseToEquip = PlayersHorse
	GoToState("Unequipped")
EndFunction

Function EquipHorseArmor(Actor PlayersHorse)
	GoToState("ChangingHorse")
	HorseToEquip = PlayersHorse
	GoToState("Armored")
EndFunction

Function EquipHorseSaddle(Actor PlayersHorse)
	GoToState("ChangingHorse")
	HorseToEquip = PlayersHorse
	GoToState("Saddled")
EndFunction

State Unequipped
	Event OnBeginState()
		Actor PlayersHorse = HorseToEquip
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Unequipped")
		ENDIF
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(none)
		PlayersHorse.SetOutfit(DES_NakedHorseOutfit)
		PlayersHorse.SetAV("CarryWeight", ((DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight))		
		UnequipRunning = False
	EndEvent
EndState

State Armored
	Event OnBeginState()
		Actor PlayersHorse = HorseToEquip
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Armored")
		ENDIF
		PlayersHorse.SetAV("CarryWeight", 0.0)
		PlayersHorse.AddSpell(DES_TrampleCloak)
		PlayersHorse.AddSpell(DES_HorseRally)
	EndEvent
	
	Event OnEndState()
		Actor PlayersHorse = HorseToEquip
		PlayersHorse.RemoveSpell(DES_TrampleCloak)
		PlayersHorse.RemoveSpell(DES_HorseRally)
	EndEvent
EndState

State Saddled
	Event OnBeginState()
		Actor PlayersHorse = HorseToEquip
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Saddled")
		ENDIF
		PlayersHorse.SetAV("CarryWeight", (papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "CarryWeight", 105.0)))
		PlayersHorse.AddSpell(DES_HorseFear)
	EndEvent
	
	Event OnEndState()
		Actor PlayersHorse = HorseToEquip
		PlayersHorse.RemoveSpell(DES_HorseFear)
	EndEvent
EndState

State ChangingHorse

EndState