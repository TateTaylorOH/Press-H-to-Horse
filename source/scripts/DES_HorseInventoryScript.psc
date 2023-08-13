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

EVENT OnKeyUp(Int KeyCode, Float HoldTime)
{This event controls opening and closing the horse's inventory. It will check to see that the actor in your crosshair is a horse you own, then force it to H2Horse's alias, and then open the inventory. IF horsekey is held, it will open the gIFt menu so you can feed the horse.}
	IF KeyCode == (DES_RenameHorseQuest as DES_HorseCallScript).horsekey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled() && Game.GetCurrentCrosshairRef()
	Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
	Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
	Actor DwarvenHorse = Game.GetFormFromFile(0x38D5, "cctwbsse001-puzzledungeon.esm") As Actor
	Actor Reindeer = Game.GetFormFromFile(0x80E, "ccvsvsse001-winter.esl") as Actor
	Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF HoldTime < papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "HoldTime", 0.9000)
			IF Game.GetCurrentCrosshairRef() == PlayersHorse && PlayersHorse && PlayersHorse.IsInFaction(PlayerHorseFaction) && !PlayersHorse.IsDead() && Game.GetCurrentCrosshairRef()!= DwarvenHorse
				RegisterForMenu("ContainerMenu")
				UpdateMode(PlayersHorse)
				PlayersHorse.OpenInventory(true)
			Else
				Alias_PlayersHorse.Clear()
			ENDIF
		Else
			IF Game.GetCurrentCrosshairRef() == PlayersHorse && PlayersHorse.IsInFaction(PlayerHorseFaction) && !PlayersHorse.IsDead()
				RegisterForMenu("GIFtMenu")
				IF PlayersHorse != DwarvenHorse
					DES_HorseStomachRef.ShowGIFtMenu(true, DES_HorseFood)
				ELSE
					DES_HorseStomachRef.ShowGIFtMenu(true, DES_CarFood)
				ENDIF
			Else
				Alias_PlayersHorse.Clear()
			ENDIF
		ENDIF
	ENDIF
ENDEVENT

EVENT OnMenuClose(String MenuName)
{This event controls unregistering the relevant menu and clearing H2Horse's alias.}
	IF MenuName == "ContainerMenu"
		UnregisterForMenu("InventoryMenu")
		while UnequipRunning == true
			utility.wait(0.1)
		endwhile
		Alias_PlayersHorse.Clear()
	ELSEIF MenuName == "GIFtMenu"
		UnregisterForMenu("GIFtMenu")
		Alias_PlayersHorse.Clear()
	ENDIF
ENDEVENT

FUNCTION UpdateMode(Actor PlayersHorse)
{This function sets the current mode of the horse who's inventory the Player is accessing.}
	IF	!(PlayersHorse.GetEquippedArmorInSlot(45)).HasKeyword(CCHorseArmorKeyword) && PlayersHorse.IsEquipped(DES_HorseArmors)
		SaddleMode(PlayersHorse)	
	ELSEIF (PlayersHorse.GetEquippedArmorInSlot(45)).HasKeyword(CCHorseArmorKeyword)
		ArmorMode(PlayersHorse)
	ELSEIF !PlayersHorse.IsEquipped(DES_HorseArmors)
		UnequipMode(PlayersHorse)
	ENDIF
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
ENDFUNCTION

FUNCTION FirstTimeEquipHorse(Actor PlayersHorse)
{This will prepare the horse for use within the H2Horse framework. It will set the horse's outfit to be blank, then check what armor the horse was wearing, give that horse the matching miscitem and reequip their inital gear. It is then handed of to the equip script to set carry weight and AI.}
	Armor ReindeerSaddle = game.GetFormFromFile(0x804, "ccvsvsse001-winter.esl") as Armor
	Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
	IF !PlayersHorse.IsInFaction(PlayerHorseFaction)
		PlayersHorse.SetFactionRank(PlayerHorseFaction, 1)
	ENDIF
	IF !DES_OwnedHorses.HasForm(PlayersHorse)
		DES_OwnedHorses.AddForm(PlayersHorse)
	ENDIF
	DES_PlayerOwnsHorse.SetValue(1)
	BaseCarryWeight = PlayersHorse.GetBaseAV("CarryWeight") as int
	IF BaseCarryWeight == 0
		BaseCarryWeight = 999
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
			ArmorMode(PlayersHorse)
		ELSEIF PlayersHorse.IsEquipped(DES_HorseArmors)
			IF Debugging
				Debug.Notification(PlayersHorse.GetDisplayName() + " is wearing a saddle.")
			ENDIF
			(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseArmorList[i])
			SaddleMode(PlayersHorse)
		ENDIF
	ENDIF
	Alias_PlayersHorse.Clear()
ENDFUNCTION

FUNCTION EquipItem(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Actor PlayersHorse)
{This function prevents the Player from placing items on their horses unless they have a saddle. Placing the appropriate miscitems on the horse will cause This function to match the proper visual armor and equip it. Called in an OnItemAdded EVENT.}
	IF !DES_HorseAllForms.HasForm(akBaseItem) && !(GetState() == "Saddled")
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " isn't wearing a saddle.")
	ELSEIF DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.IsEquipped(DES_HorseArmors)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " is already equipped.")
		return
	ELSEIF akBaseItem.HasKeyword(DES_ArmorKeyword)
		Int i = MiscItemList.Find(akBaseItem as MiscObject)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(i)
		ArmorMode(PlayersHorse)
	ELSEIF akBaseItem.HasKeyword(DES_SaddleKeyword)
		Int i = MiscItemList.Find(akBaseItem as MiscObject)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseArmorList[i])
		SaddleMode(PlayersHorse)
	ENDIF
ENDFUNCTION

FUNCTION UnequipItem(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer, Actor PlayersHorse)
{This function monitors the horse for when the appropriate miscitems are removed. Upon removal it will revert the horse to a bareback STATE. Called in an OnItemRemoved EVENT.}
	IF DES_HorseMiscItems.HasForm(akBaseItem) && PlayersHorse.GetItemCount(DES_HorseMiscItems) >= 1
		return
	ELSEIF akBaseItem.HasKeyword(DES_ArmorKeyword) || akBaseItem.HasKeyword(DES_SaddleKeyword)
		UnequipRunning = true
		UI.InvokeString("HUD Menu", "_global.skse.CloseMenu", "ContainerMenu")
		PlayersHorse.RemoveItem(DES_HorseAllForms)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).RemoveHorseArmor()
		IF PlayersHorse.GetNumItems() > 0 && akBaseItem.HasKeyword(DES_SaddleKeyword)
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s saddle has been emptied into your inventory.")
			PlayersHorse.RemoveAllItems(akTransferTo = PlayerRef)
		ENDIF
		UnequipMode(PlayersHorse)
	ENDIF
ENDFUNCTION

;These functions will swap the horse between the various STATEs of saddled, armored, and unequipped. The empty "ChangingHorse" STATE simply ensures that OnBeginSTATE and OnENDSTATE triggers appropriately.
FUNCTION SaddleMode(Actor PlayersHorse)
	GoToState("ChangingHorse")
	HorseToEquip = PlayersHorse
	GoToState("Saddled")
ENDFUNCTION

FUNCTION ArmorMode(Actor PlayersHorse)
	GoToState("ChangingHorse")
	HorseToEquip = PlayersHorse
	GoToState("Armored")
ENDFUNCTION

FUNCTION UnequipMode(Actor PlayersHorse)
	GoToState("ChangingHorse")
	HorseToEquip = PlayersHorse
	GoToState("Unequipped")
ENDFUNCTION

;This state will put the horse into the "Saddled Mode". It will set the carryweight to 105 (or whatever is specIFied in the INI) and make it so the horse will flee in combat.
STATE Saddled
	EVENT OnBeginSTATE()
		Actor PlayersHorse = HorseToEquip
		IF PlayersHorse == none
			PlayersHorse = Alias_PlayersHorse.getActorReference()
		ENDIF
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Saddled")
		ENDIF
		PlayersHorse.SetAV("CarryWeight", (papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "CarryWeight", 105.0)))
		PlayersHorse.AddSpell(DES_HorseFear)
	ENDEVENT
	
	EVENT OnENDSTATE()
		Actor PlayersHorse = HorseToEquip
		IF PlayersHorse == none
			PlayersHorse = Alias_PlayersHorse.getActorReference()
		ENDIF
		PlayersHorse.RemoveSpell(DES_HorseFear)
	ENDEVENT
ENDSTATE

;This state will put the horse into the "Armored Mode". It will set the carryweight to 0, prEVENT items from being placed on it, and make it so the horse will fight alongside you. A damage buff is given to the horse as well.
STATE Armored
	EVENT OnBeginSTATE()
		Actor PlayersHorse = HorseToEquip
		IF PlayersHorse == none
			PlayersHorse = Alias_PlayersHorse.getActorReference()
		ENDIF
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Armored")
		ENDIF
		PlayersHorse.SetAV("CarryWeight", 0.0)
		PlayersHorse.AddSpell(DES_TrampleCloak)
		PlayersHorse.AddSpell(DES_HorseRally)
	ENDEVENT
	
	EVENT OnENDSTATE()
		Actor PlayersHorse = HorseToEquip
		IF PlayersHorse == none
			PlayersHorse = Alias_PlayersHorse.getActorReference()
		ENDIF
		PlayersHorse.RemoveSpell(DES_TrampleCloak)
		PlayersHorse.RemoveSpell(DES_HorseRally)
	ENDEVENT
ENDSTATE

;This state will put the horse into the "Unequipped Mode". It will remove all visual items from the horse and it will appear bareback. From there the horse is essentially reverted to vanilla behavior.
STATE Unequipped
	EVENT OnBeginSTATE()
		Actor PlayersHorse = HorseToEquip
		IF PlayersHorse == none
			PlayersHorse = Alias_PlayersHorse.getActorReference()
		ENDIF
		Debugging = papyrusinimanipulator.PullboolFromIni("Data/H2Horse.ini", "General", "Debugging", False)
		IF Debugging
			Debug.Notification(PlayersHorse.GetDisplayName() + "'s state changed: Unequipped")
		ENDIF
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(none)
		PlayersHorse.SetOutfit(DES_NakedHorseOutfit)
		PlayersHorse.SetAV("CarryWeight", BaseCarryWeight)		
		UnequipRunning = False
	ENDEVENT
ENDSTATE

;This state is intentionally empty.
STATE ChangingHorse

ENDSTATE