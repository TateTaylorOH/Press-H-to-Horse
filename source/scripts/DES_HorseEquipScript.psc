Scriptname DES_HorseEquipScript extends ReferenceAlias  

MiscObject Property CCHorseArmorMiscArmorSteel auto
MiscObject Property CCHorseArmorMiscArmorElven auto
MiscObject Property DES_Saddle auto
Armor Property CCHorseArmorSteel auto
Armor Property CCHorseArmorElven auto
Armor Property HorseSaddle auto
Bool Property SaddleBags auto
Bool Property Equipped auto
Formlist Property DES_HorseItems auto
Actor Property PlayerRef auto

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	if akBaseItem == !DES_HorseItems.HasForm(akBaseItem) && (SaddleBags == False)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " isn't wearing a saddle.")
	elseif akBaseItem == DES_HorseItems.HasForm(akBaseItem) && PlayersHorse.IsEquipped(DES_HorseItems)
		PlayersHorse.RemoveItem(akBaseItem, aiItemCount, True, akSourceContainer)
		Debug.Notification(PlayersHorse.GetDisplayName() +  " is already equipped.")	
	elseif akBaseItem == CCHorseArmorMiscArmorElven
		PlayersHorse.EquipItem(CCHorseArmorElven)
		PlayersHorse.SetAV("CarryWeight", 0.0)
		SaddleBags = False
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		PlayersHorse.EquipItem(CCHorseArmorSteel)
		PlayersHorse.SetAV("CarryWeight", 0.0)
		SaddleBags = False
	elseif akBaseItem == DES_Saddle
		PlayersHorse.EquipItem(HorseSaddle)
		PlayersHorse.SetAV("CarryWeight", 75.0)
		SaddleBags = True
	endif
EndEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Actor PlayersHorse = self.GetActorReference()
	if akBaseItem == CCHorseArmorMiscArmorElven
		PlayersHorse.UnequipAll()
		PlayersHorse.RemoveItem(CCHorseArmorElven)
		PlayersHorse.RemoveAllItems(akTransferTo = PlayerRef)
		PlayersHorse.SetAV("CarryWeight", 999.0)
		SaddleBags = False
	elseif akBaseItem == CCHorseArmorMiscArmorSteel
		PlayersHorse.UnequipAll()
		PlayersHorse.RemoveItem(CCHorseArmorSteel)
		PlayersHorse.RemoveAllItems(akTransferTo = PlayerRef)
		PlayersHorse.SetAV("CarryWeight", 999.0)
		SaddleBags = False
	elseif akBaseItem == DES_Saddle
		PlayersHorse.UnequipAll()
		PlayersHorse.RemoveItem(HorseSaddle)
		PlayersHorse.RemoveAllItems(akTransferTo = PlayerRef)
		PlayersHorse.SetAV("CarryWeight", 999.0)
		SaddleBags = False
	endif
EndEvent