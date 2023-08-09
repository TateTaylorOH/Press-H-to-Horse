Scriptname DES_HorseInventoryScript extends Quest  

Quest Property DES_RenameHorseQuest auto
Faction Property PlayerHorseFaction auto
ReferenceAlias Property Alias_PlayersHorse auto
Actor Property DES_HorseStomachRef auto
Formlist Property DES_HorseFood auto
Formlist Property DES_CarFood auto
bool Property Saddlebags auto
Keyword Property DES_SaddleKeyword auto

Event OnKeyUp(Int KeyCode, Float HoldTime)
	If KeyCode == (DES_RenameHorseQuest as DES_HorseCallScript).horsekey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled() && Game.GetCurrentCrosshairRef()
	Actor DwarvenHorse = Game.GetFormFromFile(0x38D5, "cctwbsse001-puzzledungeon.esm") As Actor
	Actor Reindeer = Game.GetFormFromFile(0x80E, "ccvsvsse001-winter.esl") as Actor
		IF HoldTime < papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "HoldTime", 0.9000)
			Alias_PlayersHorse.ForceRefTo(Game.GetCurrentCrosshairRef())
			Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
			If Game.GetCurrentCrosshairRef() == PlayersHorse && PlayersHorse && PlayersHorse.IsInFaction(PlayerHorseFaction) && !PlayersHorse.IsDead() && Game.GetCurrentCrosshairRef()!= DwarvenHorse
				IF 	(Alias_PlayersHorse.GetState() == "Saddled")
					;Debug.Notification("Saddled")
					PlayersHorse.SetAV("CarryWeight", (papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "CarryWeight", 105.0)))
				ELSEIF 	(Alias_PlayersHorse.GetState() == "Armored")
					;Debug.Notification("Armored")
					PlayersHorse.SetAV("CarryWeight", 0.0)
				ELSEIF 	(Alias_PlayersHorse.GetState() == "Unequipped")
					;Debug.Notification("Unequipped")
					PlayersHorse.SetAV("CarryWeight", 999.0)
				ENDIF
				IF PlayersHorse.GetItemCount(DES_SaddleKeyword) > 0 || PlayersHorse == Reindeer
					SaddleBags = true
				Else
					SaddleBags = false
				ENDIF
				RegisterForMenu("ContainerMenu")
				PlayersHorse.OpenInventory(true)
				;Debug.Notification("Opened Inventory")
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
		while (Alias_PlayersHorse as DES_HorseEquipScript).UnequipRunning == true
			utility.wait(0.1)
		endwhile
		Alias_PlayersHorse.Clear()
	ELSEIF MenuName == "GiftMenu"
		UnregisterForMenu("GiftMenu")
		Alias_PlayersHorse.Clear()
	EndIf
EndEvent