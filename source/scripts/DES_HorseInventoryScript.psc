Scriptname DES_HorseInventoryScript extends Quest  

Quest Property DES_RenameHorseQuest auto
Faction Property PlayerHorseFaction auto
ReferenceAlias Property Alias_PlayersHorse auto
Actor Property DES_HorseStomachRef auto
Formlist Property DES_HorseFood auto

Event OnKeyUp(Int KeyCode, Float HoldTime)
	If KeyCode == (DES_RenameHorseQuest as DES_HorseCallScript).horsekey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled() && Game.GetCurrentCrosshairRef() 
		IF HoldTime < papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "HoldTime", 0.9000) 
			Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
			Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
			If Game.GetCurrentCrosshairRef() == PlayersHorse.IsInFaction(PlayerHorseFaction)
				RegisterForMenu("ContainerMenu")
				PlayersHorse.OpenInventory(true)
			Else
				Alias_PlayersHorse.Clear()
			EndIf
		Else
			Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
			Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
			If Game.GetCurrentCrosshairRef() == PlayersHorse.IsInFaction(PlayerHorseFaction)
				RegisterForMenu("GiftMenu")
				DES_HorseStomachRef.ShowGiftMenu(true, DES_HorseFood)
			Else
				Alias_PlayersHorse.Clear()
			EndIf
		ENDIF
	EndIf
EndEvent

Event OnMenuClose(String MenuName)
	If MenuName == "ContainerMenu"
		UnregisterForMenu("InventoryMenu")
		while (Alias_PlayersHorse as DES_HorseEquipScript).UnequipRunning == true
			utility.wait(0.1)
		endwhile
		Alias_PlayersHorse.Clear()
	ELSEIF MenuName == "GiftMenu"
		UnregisterForMenu("GiftMenu")
		Alias_PlayersHorse.Clear()
	EndIf
EndEvent