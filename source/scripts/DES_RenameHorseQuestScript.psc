Scriptname DES_RenameHorseQuestScript extends Quest  
{Controls renaming horses and importing them onto the H2Horse framework.}

String[] Property HorseNamesList auto ;A list of male and female horse names taken from Wild Horses to prefill into the name box.
String[] Property HorseFemaleNamesList auto ;A list of just female horse names taken from Wild Horses to prefill into the name box.
String[] Property HorseFemaleImperialNamesList auto ;A list of female horse names to prefill the name box. For use with Beyond Skyrim: Cyrodiil.
Actor Property PlayersHorseProperty auto
String Property defaultNameProperty auto

;These FUNCTIONs define what the default prefilled horse name will be. They inheirt Actor from the script that calls them (usually a TIF).
FUNCTION renameAnyHorse(Actor PlayersHorse) 
	String defaultName = getRandomName(HorseNamesList)
	renameHorse(PlayersHorse, defaultName)
ENDFUNCTION

FUNCTION renameFemaleHorse(Actor PlayersHorse)
	String defaultName = getRandomName(HorseFemaleNamesList)
	renameHorse(PlayersHorse, defaultName)
ENDFUNCTION

FUNCTION renameCyrodiilHorse(Actor PlayersHorse)
	String defaultName = getRandomName(HorseFemaleImperialNamesList)
	renameHorse(PlayersHorse, defaultName)
ENDFUNCTION

FUNCTION renameUniqueHorse(Actor PlayersHorse, string defaultName)
	renameHorse(PlayersHorse, defaultName)
ENDFUNCTION

string FUNCTION getRandomName(string[] names = None)
{This grabs the random name form the string arrays.}
	IF(names == None)
		names = HorseNamesList
	ENDIF
	int i = Utility.randomInt(0, names.length - 1)
	return names[i]
ENDFUNCTION

bool FUNCTION renameHorse(Actor PlayersHorse, string defaultName = "Honse")
{This preforms the actual rename function. A check is in place to see if you're renaming the CC Reindeer so that the prompt will change accordingly.}
    PlayersHorseProperty = PlayersHorse
	defaultNameProperty = defaultName
	Race horseRace = PlayersHorse.GetRace()
    string raceName = "Horse"
    IF horseRace && horseRace == Game.GetFormFromFile(0xD61, "ccvsvsse001-winter.esl") as Race
        raceName = "Reindeer"
    ENDIF
    string newName = ((self as Form) as UILIB_1).showTextInput("Name Your " + raceName, defaultName)
    IF newName != ""
        PlayersHorse.setDisplayName(newName, true)
        return true
    ENDIF
    return false
ENDFUNCTION

Event OnTextInputClose(String asEventName, String asText, Float afCancelled, Form akSender)
	If(afCancelled as Bool)
		PlayersHorseProperty.setDisplayName(defaultNameProperty, true)
	EndIf
EndEvent