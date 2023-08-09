Scriptname DES_RenameHorseQuestScript extends Quest  

;INVENTORY OBJECTS
MiscObject Property CCHorseArmorMiscArmorSteel auto
MiscObject Property CCHorseArmorMiscArmorElven auto
MiscObject Property DES_Saddle auto
MiscObject Property DES_WhiteSaddle auto
MiscObject Property DES_ImperialSaddle auto
MiscObject Property DES_StormcloakSaddle auto
MiscObject Property DES_DarkBrotherhoodSaddle auto

;ARMOR TO EQUIP
Armor Property CCHorseArmorElven auto
Armor Property CCHorseArmorSteel auto
Armor Property HorseSaddle auto
Armor Property ccBGSSSE034_HorseSaddleLight auto
Armor Property HorseSaddleImperial auto
Armor Property ccBGSSSE034_HorseSaddleStormcloak auto
Armor Property HorseSaddleShadowmere auto

ReferenceAlias Property Alias_PlayersHorse auto
ReferenceAlias Property Alias_BYOHDawnstarHorse auto
ReferenceAlias Property Alias_BYOHFalkreathHorse auto
ReferenceAlias Property Alias_BYOHMorthalHorse auto
ReferenceAlias Property PlayersHorseEquipAlias auto
String[] Property HorseNamesList auto
String[] Property HorseFemaleNamesList auto
GlobalVariable Property DES_PlayerOwnsHorse auto
Quest Property ccBGSSSE034_HorseSaddleQuest auto
Quest Property CCHorseArmorDialogueQuest auto
Formlist Property DES_OwnedHorses auto
Spell Property DES_TrampleCloak auto
Spell Property DES_HorseFear auto
Spell Property DES_HorseRally auto
Faction Property PlayerHorseFaction auto
Outfit Property DES_NakedHorseOutfit auto
Formlist Property DES_HorseArmors auto
ReferenceAlias Property DES_RenameHorseQuestAlias auto

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto

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

function renameFarmHorse()
	ReferenceAlias FarmHorse = (Quest.GetQuest("ccVSVSSE004_ModManagerQuest")).getAliasByName("Horse") as ReferenceAlias
	Actor PlayersHorse = FarmHorse.getActorReference()
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameCyrodiilHorse()
	Actor PlayersHorse = Game.GetFormFromFile(0x65108, "BSHeartland.esm") as Actor
	String defaultName = getRandomName(HorseFemaleNamesList)
	renameHorse(PlayersHorse, defaultName)
endFunction

function renameReindeer()
	Actor PlayersHorse = Game.GetFormFromFile(0x80E, "ccvsvsse001-winter.esl") as Actor
	String defaultName = "Cloudberry"
	renameHorse(PlayersHorse, defaultName)
endFunction

string function getRandomName(string[] names = None)
	if(names == None)
		names = HorseNamesList
	endIf
	int i = Utility.randomInt(0, names.length - 1)
	return names[i]
endFunction

bool function renameHorse(Actor PlayersHorse, string defaultName = "Honse")
	Actor Reindeer = Game.GetFormFromFile(0x80E, "ccvsvsse001-winter.esl") as Actor
	EquipHorse(PlayersHorse)
	IF PlayersHorse == Reindeer
		string newName = ((self as Form) as UILIB_1).showTextInput("Name Your Reindeer", DefaultName)
		if newName != ""
			PlayersHorse.setDisplayName(newName, true)
			return true
		endIf
		return false
	ELSE
		string newName = ((self as Form) as UILIB_1).showTextInput("Name Your Horse", DefaultName)
		if newName != ""
			PlayersHorse.setDisplayName(newName, true)
			return true
		endIf
		return false	
	ENDIF
endFunction

Function EquipHorse(Actor PlayersHorse)
	Armor ReindeerSaddle = game.GetFormFromFile(0x804, "ccvsvsse001-winter.esl") as Armor
	IF !PlayersHorse.IsInFaction(PlayerHorseFaction)
		PlayersHorse.SetFactionRank(PlayerHorseFaction, 1)
	ENDIF
	IF !DES_OwnedHorses.HasForm(PlayersHorse)
		DES_OwnedHorses.AddForm(PlayersHorse)
	ENDIF
	DES_PlayerOwnsHorse.SetValue(1)
	IF PlayersHorse.IsEquipped(CCHorseArmorElven) && PlayersHorse.GetItemCount(CCHorseArmorMiscArmorElven) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(0)	
		PlayersHorse.AddItem(CCHorseArmorMiscArmorElven, 1)
		EquipArmor(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(CCHorseArmorSteel) && PlayersHorse.GetItemCount(CCHorseArmorMiscArmorSteel) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(CCHorseArmorDialogueQuest as CCHorseArmorChangeScript).ChangeHorseArmor(1)
		PlayersHorse.AddItem(CCHorseArmorMiscArmorSteel, 1)
		EquipArmor(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(HorseSaddle) && PlayersHorse.GetItemCount(DES_Saddle) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddle)
		PlayersHorse.AddItem(DES_Saddle, 1)
		EquipSaddle(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(ccBGSSSE034_HorseSaddleLight) && PlayersHorse.GetItemCount(DES_WhiteSaddle) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(ccBGSSSE034_HorseSaddleLight)
		PlayersHorse.AddItem(DES_WhiteSaddle, 1)
		EquipSaddle(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(HorseSaddleImperial) && PlayersHorse.GetItemCount(DES_ImperialSaddle) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddleImperial)
		PlayersHorse.AddItem(DES_ImperialSaddle, 1)
		EquipSaddle(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(ccBGSSSE034_HorseSaddleStormcloak) && PlayersHorse.GetItemCount(DES_StormcloakSaddle) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(ccBGSSSE034_HorseSaddleStormcloak)
		PlayersHorse.AddItem(DES_StormcloakSaddle, 1) 
		EquipSaddle(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(HorseSaddleShadowmere) && PlayersHorse.GetItemCount(DES_DarkBrotherhoodSaddle) == 0
		PlayersHorse.RemoveItem(DES_HorseArmors)
		(ccBGSSSE034_HorseSaddleQuest as ccbgssse034_saddlequestscript).ChangeHorseSaddle(HorseSaddleShadowmere)
		PlayersHorse.AddItem(DES_DarkBrotherhoodSaddle, 1) 
		EquipSaddle(PlayersHorse)
	ELSEIF PlayersHorse.IsEquipped(ReindeerSaddle)
		EquipSaddle(PlayersHorse)
	ENDIF
EndFunction

Function EquipArmor(Actor PlayersHorse)
	PlayersHorse.SetAV("CarryWeight", 0.0)
	PlayersHorse.AddSpell(DES_TrampleCloak)
	PlayersHorse.AddSpell(DES_HorseRally)
	DES_RenameHorseQuestAlias.GoToState("Armored")
EndFunction

Function EquipSaddle(Actor PlayersHorse)
	PlayersHorse.SetAV("CarryWeight", 100.0)
	PlayersHorse.AddSpell(DES_HorseFear)
	DES_RenameHorseQuestAlias.GoToState("Saddled")
EndFunction