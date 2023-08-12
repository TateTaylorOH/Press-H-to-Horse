Scriptname DES_RenameHorseQuestScript extends Quest  
{Controls renaming horses and importing them onto the H2Horse framework.}

String[] Property HorseNamesList auto ;A list of male and female horse names taken from Wild Horses to prefill into the name box.
String[] Property HorseFemaleNamesList auto ;A list of just female horse names taken from Wild Horses to prefill into the name box.
String[] Property HorseFemaleImperialNamesList auto ;A list of female horse names to prefill the name box. For use with Beyond Skyrim: Cyrodiil.

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