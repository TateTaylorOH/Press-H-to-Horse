Scriptname DES_HorseCallScript extends Quest
{Controls the horse call mechanic.}

Actor Property PlayerRef Auto
Actor Property SelectedHorse Auto
bool Property Debugging  auto
bool Property HorseSelectTutorial  auto
Faction Property PlayerHorseFaction Auto
Formlist Property DES_OwnedHorses auto
Formlist Property DES_ValidWorldspaces auto
int property horseKey auto
ReferenceAlias Property Alias_PlayersHorse auto
ReferenceAlias Property Alias_LastRiddenHorse auto
Sound Property DES_HorseCallMarker auto
Sound Property DES_HorseStayMarker auto
Quest Property DES_HorseMCMQuest auto

Message[] Property HelpMessages Auto
float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
float horseAngle = 180.0 ; where the horse should appear relative to the player, clockwise from north.
float horseDistance = 512.0

EVENT OnKeyUp(Int KeyCode, Float HoldTime)
{Sends an event when HorseKey is raised up. The actor called will be the last owned horse the player rode. There are checks to prevent the horse getting called into interiors as well as a mechanic to select a specIFic horse from a SkyUILib list menu.}
	Actor LastRiddenHorse = Game.GetPlayersLastRiddenHorse()
	Debugging = (DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).bDebugging
	IF SelectedHorse && SelectedHorse == Alias_PlayersHorse.getActorReference()
		LastRiddenHorse = SelectedHorse
	ENDIF
	IF Debugging
		Debug.Notification("LastRiddenHorse is " + LastRiddenHorse.getDisplayName())
	ENDIF
	IF (KeyCode == horseKey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()) && !Game.GetCurrentCrosshairRef() && !PlayerRef.IsOnMount()
		IF (!PlayerRef.IsInInterior() && DES_ValidWorldspaces.HasForm(PlayerRef.getWorldSpace()))
			IF HoldTime < (DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).fHoldTime
				IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)) && !LastRiddenHorse.IsDead()
					IF (LastRiddenHorse.GetParentCell() != PlayerRef.GetParentCell())
						GoToState("Waiting")
					ENDIF
					HorseCall(LastRiddenHorse)
				ENDIF
			ELSE
				SelectHorse()
			ENDIF
		ELSE
			IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)) ; there is a last horse, and it's the players
				Debug.Notification(LastRiddenHorse.GetDisplayName() + " cannot be called here.")
			ENDIF
		ENDIF
	ENDIF
ENDEVENT

EVENT OnAnimationEVENT(ObjectReference akSource, string AsEventName)
{This EVENT clears the H2Horse alias and reverts control of the horse's AI to the "stables" quest.}
    IF (akSource == PlayerRef) && (AsEventName == "tailHorseMount")
		Alias_LastRiddenHorse.ForceRefTo(Game.GetPlayersLastRiddenHorse())
		Alias_PlayersHorse.Clear()
		GoToState("Waiting")
    ENDIF
ENDEVENT

FUNCTION SelectHorse()
{IF the Player has UI Extensions installed, This function will allowed them to pick from a list of their owned horses to call to them.}
	 Actor LastRiddenHorse = Game.GetPlayersLastRiddenHorse()
	IF Game.GetFormFromFile(0xE05, "UIExtensions.esp")
		int n = DES_OwnedHorses.getSize()
		while n > 0
			Actor OwnedHorse = DES_OwnedHorses.GetAt(n) as actor
			IF OwnedHorse && OwnedHorse.IsDead()
				DES_OwnedHorses.RemoveAddedForm(OwnedHorse)
			ENDIF
			n -= 1
		endwhile
		int nHorses = DES_OwnedHorses.getSize()
		IF nHorses > 1
			UISelectionMenu menu = UIExtensions.GetMenu("UISelectionMenu") as UISelectionMenu	
			menu.OpenMenu(aForm=DES_OwnedHorses)
			SelectedHorse = menu.GetResultForm() as Actor
			IF SelectedHorse
				RegisterForAnimationEVENT(PlayerRef, "tailHorseMount")
				Debug.Notification("You call for " + SelectedHorse.GetDisplayName() + ".")
				IF (LastRiddenHorse.GetParentCell() != PlayerRef.GetParentCell())
					GoToState("Waiting")
				ENDIF
				HorseCall(SelectedHorse)
			ENDIF
		ENDIF
	ELSE
		IF (LastRiddenHorse.GetParentCell() != PlayerRef.GetParentCell())
			GoToState("Waiting")
		ENDIF
		HorseCall(LastRiddenHorse)
	ENDIF
ENDFUNCTION

FUNCTION HorseWhistle(Actor LastRiddenHorse)
{This function plays the whistling sound when the Player calls for their horse, then forces the horse to H2Horse's alias so that follow AI can take over. Code is present here for patchless compatibility with Animated Whistling.}
    bool doingExtraBullshit = !PlayerRef.IsWeaponDrawn() && PlayerRef.GetSitSTATE() == 0
    Alias_PlayersHorse.Clear()
    IF doingExtraBullshit
        Debug.SendAnimationEVENT(PlayerRef, "Whistling")
        MfgConsoleFunc.SetPhoneMe(PlayerRef, 6, 30)
    ENDIF
    IF !(GetState() == "CalledHorse")
		Alias_PlayersHorse.ForceRefTo(LastRiddenHorse)
		GoToState("CalledHorse")
		DES_HorseCallMarker.Play(PlayerRef)
    ELSE
        Alias_PlayersHorse.Clear()
		DES_HorseStayMarker.Play(PlayerRef)
    ENDIF
    LastRiddenHorse.EvaluatePackage()
    IF doingExtraBullshit
        Utility.Wait(1.0)
        MfgConsoleFunc.ResetPhonemeModIFier(PlayerRef)
        Debug.SendAnimationEVENT(PlayerRef, "OffsetStop")
    ENDIF
ENDFUNCTION

float FUNCTION addAngles(float angle, float turn)
{This function controls the angles at which the horse is spawned IF the Player doesn't currently have LOS on it.}
    angle += turn
    while(angle >= 360.0)
        angle -= 360.0
    endWhile
    while(angle < 0.0)
        angle += 360.0
    endWhile
    return angle
ENDFUNCTION

;This function is intentionally empty and is overridden by the two call states.
FUNCTION HorseCall(Actor LastRiddenHorse)
{This function controls switching between calling the horse and telling the horse to stay.}
GoToState("Waiting")
ENDFUNCTION

auto STATE Waiting
	FUNCTION HorseCall(Actor LastRiddenHorse)
		RegisterForAnimationEVENT(PlayerRef, "tailHorseMount") ;Registered to track mount, which will remove the Horse from the H2Horse alias.
		Debug.Notification("You call for " + LastRiddenHorse.GetDisplayName() + ".")
		HorseWhistle(LastRiddenHorse)
		IF !PlayerRef.HasLOS(LastRiddenHorse)
			float az = addAngles(PlayerRef.getAngleZ(), horseAngle)
			LastRiddenHorse.moveTo(PlayerRef, horseDistance * math.sin(az), horseDistance * Math.cos(az), 0.0, true)
		ENDIF
		IF !DES_OwnedHorses.HasForm(LastRiddenHorse)
			DES_OwnedHorses.addForm(LastRiddenHorse)
		ENDIF
		IF DES_OwnedHorses.GetSize() > 1 && !HorseSelectTutorial ;A tutorial regarding the horse selection list will play IF the Player has UI Extentions installed. It will only play IF HorseKey is H since the tutorial specIFically refers to the key.
			IF Game.GetFormFromFile(0xE05, "UIExtensions.esp") && HorseKey == 35 && (DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).bShowTutorials
				Utility.Wait(1)
				HelpMessages[0].ShowAsHelpMessage("HorseSelectTutorial", messageDuration, 1.0, 1)
				Utility.wait(messageDuration + messageInterval + 0.1)
				HelpMessages[1].ShowAsHelpMessage("HorseFollowerTutorial", messageDuration, 1.0, 1)
				HorseSelectTutorial = True
			ELSEIF !(DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).bShowTutorials
				HorseSelectTutorial = True
			ENDIF
		ENDIF
	ENDFUNCTION
ENDSTATE

STATE CalledHorse
	FUNCTION HorseCall(Actor LastRiddenHorse)
		Debug.Notification("You tell "+ LastRiddenHorse.GetDisplayName() + " to wait.")
		HorseWhistle(LastRiddenHorse)
		GoToState("Waiting")
	ENDFUNCTION
ENDSTATE