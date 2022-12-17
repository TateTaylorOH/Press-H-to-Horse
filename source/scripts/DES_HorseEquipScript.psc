Scriptname DES_HorseEquipScript extends ReferenceAlias  

MiscObject Property CCHorseArmorMiscArmorSteel auto
MiscObject Property CCHorseArmorMiscArmorElven auto
MiscObject Property DES_Saddle auto
Armor Property CCHorseArmorSteel auto
Armor Property CCHorseArmorElven auto
Armor Property HorseSaddle auto
Bool Property NoSaddleBags auto
Formlist Property DES_HorseItems auto
Actor Property PlayerRef auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if !akBaseItem == DES_HorseItems && NoSaddleBags == True
		Game.GetPlayersLastRiddenHorse().RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(Game.GetPlayersLastRiddenHorse() +  " isn't wearing a saddle.")
	elseif akBaseItem == CCHorseArmorMiscArmorElven
		Game.GetPlayersLastRiddenHorse().EquipItem(CCHorseArmorElven)
		Game.GetPlayersLastRiddenHorse().SetAV("CarryWeight", 0.0)
		NoSaddleBags == True
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		Game.GetPlayersLastRiddenHorse().EquipItem(CCHorseArmorSteel)
		Game.GetPlayersLastRiddenHorse().SetAV("CarryWeight", 0.0)
		NoSaddleBags == True
	elseif akBaseItem == DES_Saddle
		Game.GetPlayersLastRiddenHorse().EquipItem(HorseSaddle)
		Game.GetPlayersLastRiddenHorse().SetAV("CarryWeight", 75.0)
		NoSaddleBags == False		
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == CCHorseArmorMiscArmorElven
		Game.GetPlayersLastRiddenHorse().UnequipItem(CCHorseArmorElven)
		Game.GetPlayersLastRiddenHorse().RemoveAllItems(akTransferTo = PlayerRef)
		Game.GetPlayersLastRiddenHorse().SetAV("CarryWeight", 999.0)
		NoSaddleBags == True
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		Game.GetPlayersLastRiddenHorse().UnequipItem(CCHorseArmorSteel)
		Game.GetPlayersLastRiddenHorse().RemoveAllItems(akTransferTo = PlayerRef)
		Game.GetPlayersLastRiddenHorse().SetAV("CarryWeight", 999.0)
		NoSaddleBags == True
	elseif akBaseItem == DES_Saddle
		Game.GetPlayersLastRiddenHorse().UnequipItem(HorseSaddle)
		Game.GetPlayersLastRiddenHorse().RemoveAllItems(akTransferTo = PlayerRef)
		Game.GetPlayersLastRiddenHorse().SetAV("CarryWeight", 999.0)
		NoSaddleBags == True
	endif
EndEvent