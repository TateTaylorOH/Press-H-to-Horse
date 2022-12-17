Scriptname DES_HorseInventoryScript extends Quest  

Quest Property DES_RenameHorseQuest auto
Faction Property PlayerHorseFaction auto
Formlist Property DES_HorseItems auto
Armor Property CCHorseArmorSteel auto
ReferenceAlias Property Alias_PlayersHorse auto

Event OnKeyDown(Int KeyCode)
	If KeyCode == (DES_RenameHorseQuest as DES_HorseCallScript).horsekey
	Actor LastRiddenHorse = Game.GetPlayersLastRiddenHorse()
		If (LastRiddenHorse && (Game.GetCurrentCrosshairRef() == LastRiddenHorse) && (LastRiddenHorse.IsInFaction(PlayerHorseFaction)))
			Alias_PlayersHorse.ForceRefTo(LastRiddenHorse)
			LastRiddenHorse.AddInventoryEventFilter(DES_HorseItems)
			LastRiddenHorse.RemoveInventoryEventFilter(DES_HorseItems)
			RegisterForMenu("ContainerMenu")
			LastRiddenHorse.OpenInventory(true)
		EndIf	
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "ContainerMenu"
		Game.GetPlayersLastRiddenHorse().RemoveInventoryEventFilter(DES_HorseItems)
		UnregisterForMenu("InventoryMenu")
		Alias_PlayersHorse.Clear()
	EndIf
EndEvent