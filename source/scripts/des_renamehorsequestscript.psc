Scriptname DES_RenameHorseQuestScript extends Quest  
{Controls renaming horses and importing them onto the H2Horse framework.}

;Below are inventory objects that are checked to see what visual armor to equip to the horse.}
MiscObject Property CCHorseArmorMiscArmorElven auto
MiscObject Property CCHorseArmorMiscArmorSteel auto
MiscObject Property DES_DarkBrotherhoodSaddle auto
MiscObject Property DES_ImperialSaddle auto
MiscObject Property DES_Saddle auto
MiscObject Property DES_StormcloakSaddle auto
MiscObject Property DES_WhiteSaddle auto

;Below are visual armors that will be equipped to the horse based on what misc item is placed in the inventory.}
Armor Property ccBGSSSE034_HorseSaddleLight auto
Armor Property ccBGSSSE034_HorseSaddleStormcloak auto
Armor Property CCHorseArmorElven auto
Armor Property CCHorseArmorSteel auto
Armor Property HorseSaddle auto
Armor Property HorseSaddleImperial auto
Armor Property HorseSaddleShadowmere auto

;Bellow are all the miscellaneous properties.
Faction Property PlayerHorseFaction auto
Formlist Property DES_HorseArmors auto ;A formlist of all the armor records related to horses (i.e. HorseSaddle)
Formlist Property DES_OwnedHorses auto ;A list of horses the Player owns.
GlobalVariable Property DES_PlayerOwnsHorse auto ;Checks is the Player has bought a horse or not.
Quest Property ccBGSSSE034_HorseSaddleQuest auto
Quest Property CCHorseArmorDialogueQuest auto
Quest Property DES_RenameHorseQuest auto
ReferenceAlias Property Alias_PlayersHorse auto ;Refers to the "PlayersHorse" alias from the "DES_RenameHorseQuest" quest.
String[] Property HorseFemaleImperialNamesList auto ;A list of female horse names to prefill the name box. For use with Beyond Skyrim: Cyrodiil.
String[] Property HorseFemaleNamesList auto ;A list of just female horse names taken from Wild Horses to prefill into the name box.
String[] Property HorseNamesList auto ;A list of male and female horse names taken from Wild Horses to prefill into the name box.

Armor[] Property HorseArmorList auto
MiscObject[] Property MiscItemList auto
Keyword Property CCHorseArmorKeyword auto

;These functions define what the default prefilled horse name will be. They inheirt Actor from the script that calls them (usually a TIF).
function renameAnyHorse(Actor PlayersHorse) 
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameFemaleHorse(Actor PlayersHorse)
	String defaultName = getRandomName(HorseFemaleNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameCyrodiilHorse(Actor PlayersHorse)
	String defaultName = getRandomName(HorseFemaleImperialNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameUniqueHorse(Actor PlayersHorse, string defaultName)
	renameHorse(PlayersHorse, defaultName)
endFunction

string function getRandomName(string[] names = None)
{This grabs the random name form the string arrays.}
	if(names == None)
		names = HorseNamesList
	endIf
	int i = Utility.randomInt(0, names.length - 1)
	return names[i]
endFunction

bool function renameHorse(Actor PlayersHorse, string defaultName = "Honse")
{This preforms the actual rename function. A check is in place to see if you're renaming the CC Reindeer so that the prompt will change accordingly.}
	Actor Reindeer = Game.GetFormFromFile(0x80E, "ccvsvsse001-winter.esl") as Actor
	IF PlayersHorse == Reindeer
		string newName = ((self as Form) as UILIB_1).showTextInput("Name Your Reindeer", defaultName)
		if newName != ""
			PlayersHorse.setDisplayName(newName, true)
			return true
		endIf
		return false
	ELSE
		string newName = ((self as Form) as UILIB_1).showTextInput("Name Your Horse", defaultName)
		if newName != ""
			PlayersHorse.setDisplayName(newName, true)
			return true
		endIf
		return false	
	ENDIF
endFunction


Function EquipHorse(Actor PlayersHorse)
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
	(DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight = PlayersHorse.GetBaseAV("CarryWeight") as int
	IF (DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight == 0
		(DES_RenameHorseQuest as DES_HorseInventoryScript).BaseCarryWeight = 999
	ENDIF
	Int i = HorseArmorList.Find(PlayersHorse.GetEquippedArmorInSlot(45))
	IF Debugging
		Debug.Notification(i + HorseArmorList[i].GetName() + MiscItemList[i].GetName())
	ENDIF
	IF PlayersHorse.IsEquipped(HorseArmorList) && PlayersHorse.GetItemCount(MiscItemList) == 0
		IF Debugging
			Debug.Notification(PlayersHorse.GetName() + " is being equipped for the first time.")
		ENDIF
		PlayersHorse.RemoveItem(DES_HorseArmors)
		PlayersHorse.AddItem(MiscItemList[i], 1)
		IF (PlayersHorse.GetEquippedArmorInSlot(45)).HasKeyword(CCHorseArmorKeyword)
			IF Debugging
				Debug.Notification(PlayersHorse.GetName() + " is wearing armor.")
			ENDIF
			(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(i)
			(Alias_PlayersHorse as DES_HorseEquipScript).EquipHorseArmor(PlayersHorse)
		ELSEIF PlayersHorse.IsEquipped(HorseArmorList)
			IF Debugging
				Debug.Notification(PlayersHorse.GetName() + " is wearing a saddle.")
			ENDIF
			(Alias_PlayersHorse as DES_HorseEquipScript).EquipHorseSaddle(PlayersHorse)
			(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseArmorList[i])
		ENDIF
	ENDIF
	Alias_PlayersHorse.Clear()
EndFunction
