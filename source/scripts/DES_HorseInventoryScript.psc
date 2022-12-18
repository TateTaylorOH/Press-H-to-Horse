Scriptname DES_HorseInventoryScript extends Quest  

Quest Property DES_RenameHorseQuest auto
Faction Property PlayerHorseFaction auto
ReferenceAlias Property Alias_PlayersHorse auto

Event OnKeyDown(Int KeyCode)
	If KeyCode == (DES_RenameHorseQuest as DES_HorseCallScript).horsekey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()
		Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
		Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
		If Game.GetCurrentCrosshairRef() == PlayersHorse.IsInFaction(PlayerHorseFaction)
			RegisterForMenu("ContainerMenu")
			PlayersHorse.OpenInventory(true)
		Else
			Alias_PlayersHorse.Clear()
		EndIf	
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "ContainerMenu"
		Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
		UnregisterForMenu("InventoryMenu")
		Alias_PlayersHorse.Clear()
	EndIf
EndEvent