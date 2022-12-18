Scriptname DES_RenameHorseQuestScript extends Quest  

ReferenceAlias Property Alias_PlayersHorse auto
ReferenceAlias Property Alias_BYOHDawnstarHorse auto
ReferenceAlias Property Alias_BYOHFalkreathHorse auto
ReferenceAlias Property Alias_BYOHMorthalHorse auto
ReferenceAlias Property PlayersHorseEquipAlias auto
String[] Property HorseNamesList auto
String[] Property HorseFemaleNamesList auto
GlobalVariable Property DES_PlayerOwnsHorse auto
Armor Property HorseSaddle auto
MiscObject Property DES_Saddle auto
GlobalVariable Property CCHorseArmorIsInstalled auto
Outfit Property DES_EmptyHorseOutfit auto

bool function renameHorse(Actor horse, string defaultName = "Honse")
	Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
	DES_PlayerOwnsHorse.SetValue(1)
	if CCHorseArmorIsInstalled.GetValue() == 1 && PlayersHorse.IsEquipped(HorseSaddle)
		PlayersHorse.UnequipAll()
		PlayersHorse.RemoveAllItems()
		PlayersHorse.SetOutfit(DES_EmptyHorseOutfit)
		PlayersHorse.EquipItem(HorseSaddle)
		PlayersHorse.AddItem(DES_Saddle, 1)
		PlayersHorse.SetAV("CarryWeight", 75.0)
		(Alias_PlayersHorse as DES_HorseEquipScript).AddInventoryEventFilter(HorseSaddle)
		(Alias_PlayersHorse as DES_HorseEquipScript).Saddlebags = True
	endif
	string newName = ((self as Form) as UILIB_1).showTextInput("Name Your Horse", DefaultName)
	if newName != ""
		horse.setDisplayName(newName, true)
		return true
	endIf
	return false
endFunction

string function getRandomName(string[] names = None)
	if(names == None)
		names = HorseNamesList
	endIf
	int i = Utility.randomInt(0, names.length - 1)
	return names[i]
endFunction

function renameFemaleHorse()
	Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
	String defaultName = getRandomName(HorseFemaleNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

Function RenameWhiterunHorse()
	Actor PlayersHorse = Alias_PlayersHorse.getActorReference()
	String defaultName = "Queen Alfsigr"
	renameHorse(PlayersHorse, defaultName)
EndFunction

function renameBYOHDawnstarHorse()
	Actor PlayersHorse = Alias_BYOHDawnstarHorse.getActorReference()
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameBYOHFalkreathHorse()
	Actor PlayersHorse = Alias_BYOHFalkreathHorse.getActorReference()
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameBYOHMorthalHorse()
	Actor PlayersHorse = Alias_BYOHMorthalHorse.getActorReference()
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameWildHorse()
	Actor PlayersHorse = game.GetPlayersLastRiddenHorse()
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameCyrodiilHorse()
	Actor PlayersHorse = Game.GetFormFromFile(0x65108, "BSHeartland.esm") as Actor
	String defaultName = getRandomName(HorseFemaleNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction