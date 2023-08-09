Scriptname DES_RegisterKeyOnLoad extends ReferenceAlias

GlobalVariable Property DES_PlayerOwnsHorse auto
Quest Property DES_RenameHorseQuest Auto
Formlist Property DES_ValidWorldspaces auto
ReferenceAlias Property Alias_PlayersHore auto

EVENT OnPlayerLoadGame()
	Actor PlayersHorse = Alias_PlayersHore.GetActorReference()
	(DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight = PlayersHorse.GetBaseAV("CarryWeight") as int
	;Debug.Notification("PlayersHorse CarryWeight = " + PlayersHorse.GetBaseAV("CarryWeight") as int)
	;Debug.Notification("BaseCarryWeight = " + (DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight)
	RegisterKey()
	InjectModdedWorldspaces()
ENDEVENT

Function RegisterKey()
	IF DES_PlayerOwnsHorse.getvalue() == 1
		UnregisterForKey((DES_RenameHorseQuest as DES_HorseCallScript).horsekey)
		RegisterForKey((DES_RenameHorseQuest as DES_HorseCallScript).horsekey)
	ENDIF
EndFunction

Function InjectModdedWorldspaces()
	Form BSHeartland = Game.GetFormFromFile(0xA764B, "BSHeartland.esm") as Worldspace
	IF !DES_ValidWorldspaces.HasForm(BSHeartland)
		DES_ValidWorldspaces.AddForm(BSHeartland)
	ENDIF
EndFunction