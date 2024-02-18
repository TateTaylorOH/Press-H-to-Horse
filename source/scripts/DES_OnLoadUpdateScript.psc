Scriptname DES_OnLoadUpdateScript extends ReferenceAlias  
{Manages various aspects of the mod that may need updated when the Player reloads their game.}

Actor Property PlayerRef auto
Bool Property SaddlesAddedToCWUniforms auto
GlobalVariable Property DES_PlayerOwnsHorse auto
LeveledItem Property CWPlayerUniformImperialLight auto
LeveledItem Property CWPlayerUniformImperialMedium auto
LeveledItem Property CWPlayerUniformImperialHeavy auto
LeveledItem Property CWPlayerUniformSons auto
MiscObject Property DES_ImperialSaddle auto
MiscObject Property DES_StormcloakSaddle auto
Quest Property DES_HorseHandler Auto
Quest Property DES_HorseCallTutorialTracker Auto
Quest Property DES_HorseMCMQuest Auto
Formlist Property DES_ValidWorldspaces auto
ReferenceAlias Property Alias_PlayersHorse auto
ReferenceAlias Property Alias_LastRiddenHorse auto
ReferenceAlias Property Alias_BSBrumaHostler auto
LeveledItem Property DES_LItemMiscHostlerItems75 auto
LeveledItem Property DES_MinimumHostler auto

float fH2HorseVersion

;-- Events ---------------------------------------

EVENT OnInit()
	Maintenance()
ENDEVENT

EVENT OnPlayerLoadGame()
	RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
	GetBaseCarryWeight()
	RegisterKey()
	GetLastRiddenHorse()
	InjectCWUniforms()
	ImportCyrodiil()
	Update()
	Maintenance()
ENDEVENT

EVENT OnAnimationEVENT(ObjectReference akSource, string AsEventName)
    IF (akSource == PlayerRef) && (AsEventName == "tailHorseMount")
		Alias_LastRiddenHorse.Clear()
		Utility.Wait(0.1)
		Alias_LastRiddenHorse.ForceRefTo(Game.GetPlayersLastRiddenHorse())
	ENDIF
ENDEVENT

;-- Functions ---------------------------------------

Function Maintenance()
	If fH2HorseVersion < 2.300 ; <--- Edit this value when updating
		fH2HorseVersion = 2.300 ; and this
		Debug.Notification("Press H to Horse " + StringUtil.getNthChar(fH2HorseVersion, 0) + "." + StringUtil.getNthChar(fH2HorseVersion, 2) + "." +  StringUtil.getNthChar(fH2HorseVersion, 3) + "." + StringUtil.getNthChar(fH2HorseVersion, 4))
		; Update Code
	EndIf
	; Other maintenance code that only needs to run once per save load
EndFunction

Function Update() ; <--- Edit this function when updating
	IF fH2HorseVersion < 2.300
		(DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).NewSettings()
	ENDIF
EndFunction

FUNCTION GetBaseCarryWeight()
	Actor PlayersHorse = Game.GetPlayersLastRiddenHorse()
	(self.GetOwningQuest() as DES_HorseInventoryScript).BaseCarryWeight = PlayersHorse.GetBaseAV("CarryWeight") as int
	IF (self.GetOwningQuest() as DES_HorseInventoryScript).BaseCarryWeight == 0
		(self.GetOwningQuest() as DES_HorseInventoryScript).BaseCarryWeight = 999
	ENDIF
ENDFUNCTION

FUNCTION RegisterKey()
	(self.GetOwningQuest() as DES_HorseCallScript).horsekey = (DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).iHorseKey
	DES_HorseHandler.UnregisterForKey((self.GetOwningQuest() as DES_HorseCallScript).horsekey)
	Utility.Wait(0.1)
	DES_HorseHandler.RegisterForKey((self.GetOwningQuest() as DES_HorseCallScript).horsekey)
ENDFUNCTION

FUNCTION GetLastRiddenHorse()
	Alias_LastRiddenHorse.Clear()
	Utility.Wait(0.1)
	Alias_LastRiddenHorse.ForceRefTo(Game.GetPlayersLastRiddenHorse())
ENDFUNCTION

FUNCTION InjectCWUniforms()
	IF !SaddlesAddedToCWUniforms == true
		CWPlayerUniformImperialLight.AddForm(DES_ImperialSaddle, 1, 1)
		CWPlayerUniformImperialMedium.AddForm(DES_ImperialSaddle, 1, 1)
		CWPlayerUniformImperialHeavy.AddForm(DES_ImperialSaddle, 1, 1)
		CWPlayerUniformSons.AddForm(DES_StormcloakSaddle, 1, 1)
		SaddlesAddedToCWUniforms = true
	ENDIF
ENDFUNCTION

FUNCTION ImportModdedWorldspace(Worldspace WorldToImport)
	IF !DES_ValidWorldspaces.HasForm(WorldToImport)
		DES_ValidWorldspaces.AddForm(WorldToImport)
	ENDIF
ENDFUNCTION

FUNCTION ImportModdedHostler(Actor HostlerToImport, ReferenceAlias HostlerToImportAlais, Faction ModdedMerchantFaction)
	HostlerToImport.AddToFaction(ModdedMerchantFaction)
	HostlerToImportAlais.ForceRefTo(HostlerToImport)
ENDFUNCTION

FUNCTION ImportCyrodiil()
	IF Game.GetFormFromFile(0xA764B, "BSHeartland.esm")
		Actor BSBrumaHostler = Game.GetFormFromFile(0x65115, "BSHeartland.esm") As Actor
		Faction CYRJobMerchantFaction = Game.GetFormFromFile(0x5BBDE, "BSHeartland.esm") As Faction
		Form BSHeartland = Game.GetFormFromFile(0xA764B, "BSHeartland.esm") as Worldspace
		MiscObject BSHorseshoe = Game.GetFormFromFile(0x723B8, "BSHeartland.esm") As MiscObject
		ImportModdedWorldspace(BSHeartland as Worldspace)
		IF BSBrumaHostler != Alias_BSBrumaHostler.getactorRef()
			ImportModdedHostler(BSBrumaHostler, Alias_BSBrumaHostler, CYRJobMerchantFaction)
		ENDIF
		IF !(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).BSHorseshoeAdded == true
			(DES_HorseCallTutorialTracker as DES_HorseCallTutorialTrackerScript).BSHorseshoeAdded = true
			DES_MinimumHostler.Revert()
			DES_LItemMiscHostlerItems75.Revert()
			DES_MinimumHostler.AddForm(BSHorseshoe as form, 1, 4)
			DES_LItemMiscHostlerItems75.AddForm(BSHorseshoe as form, 1, 4)
		ENDIF
	ENDIF
ENDFUNCTION
