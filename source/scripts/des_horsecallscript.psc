Scriptname DES_HorseCallScript extends Quest

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto
ReferenceAlias Property Alias_PlayersHorse auto
Actor Property PlayerRef Auto
Faction Property PlayerHorseFaction Auto
bool property CalledHorse auto
bool Property HorseSelectTutorial  auto
int property horseKey auto
Formlist Property DES_ValidWorldspaces auto
Sound Property DES_HorseStayMarker auto
Sound Property DES_HorseCallMarker auto
Formlist Property DES_OwnedHorses auto

float horseAngle = 180.0 ; where the horse should appear relative to the player, clockwise from north.
float horseDistance = 512.0

Event OnKeyUp(Int KeyCode, Float HoldTime)
	Actor LastRiddenHorse = Game.GetPlayersLastRiddenHorse()
	IF (KeyCode == horseKey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()) && !Game.GetCurrentCrosshairRef() && !PlayerRef.IsOnMount(); this is a valid keypress
		IF (!PlayerRef.IsInInterior() && DES_ValidWorldspaces.HasForm(PlayerRef.getWorldSpace())) ; this is a valid place to summon the horse
			IF HoldTime < papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "HoldTime", 0.9000) 
				IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)); there is a last horse, and it's the players
					CallLastHorse()
				ENDIF
			ELSE
				IF Game.GetFormFromFile(0xE05, "UIExtensions.esp")
					IF DES_OwnedHorses.GetSize() > 1
						UISelectionMenu menu = UIExtensions.GetMenu("UISelectionMenu") as UISelectionMenu	
						menu.OpenMenu(aForm=DES_OwnedHorses)
						Actor SelectedHorse = menu.GetResultForm() as Actor
						RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
						Debug.Notification("You call for " + SelectedHorse.GetDisplayName() + ".")
						Alias_PlayersHorse.Clear()
						Alias_PlayersHorse.ForceRefTo(SelectedHorse)
						SelectedHorse.EvaluatePackage()
						DES_HorseCallMarker.Play(PlayerRef)
						IF !PlayerRef.HasLOS(SelectedHorse)
							float az = addAngles(PlayerRef.getAngleZ(), horseAngle)
							SelectedHorse.moveTo(PlayerRef, horseDistance * math.sin(az), horseDistance * Math.cos(az), 0.0, true)
						ENDIF
						CalledHorse = False
					ENDIF
				ELSE
					CallLastHorse()
				ENDIF
			ENDIF
		ELSE
			IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)) ; there is a last horse, and it's the players
				Debug.Notification(LastRiddenHorse.GetDisplayName() + " cannot be called here.")
			ENDIF
			Debug.Notification("Your horse cannot be called here.")
		ENDIF
	ENDIF
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    if (akSource == PlayerRef) && (asEventName == "tailHorseMount")
        CalledHorse = false
        UnregisterForAnimationEvent(PlayerRef, "tailHorseMount")
        Alias_PlayersHorse.Clear()
    endif
EndEvent

Function CallLastHorse()
	Actor LastRiddenHorse = Game.GetPlayersLastRiddenHorse()
	IF CalledHorse
		CalledHorse = false
		UnregisterForAnimationEvent(PlayerRef, "tailHorseMount")
		Debug.Notification("You tell "+ LastRiddenHorse.GetDisplayName() + " to wait.")
		Alias_PlayersHorse.Clear()
		DES_HorseStayMarker.Play(PlayerRef)
		LastRiddenHorse.EvaluatePackage()
	ELSE
		CalledHorse = true
		RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
		Debug.Notification("You call for " + LastRiddenHorse.GetDisplayName() + ".")
		Alias_PlayersHorse.Clear()
		Alias_PlayersHorse.ForceRefTo(LastRiddenHorse)
		LastRiddenHorse.EvaluatePackage()
		DES_HorseCallMarker.Play(PlayerRef)
		IF !PlayerRef.HasLOS(LastRiddenHorse)
			float az = addAngles(PlayerRef.getAngleZ(), horseAngle)
			LastRiddenHorse.moveTo(PlayerRef, horseDistance * math.sin(az), horseDistance * Math.cos(az), 0.0, true)
		ENDIF
		IF !DES_OwnedHorses.HasForm(LastRiddenHorse)
			DES_OwnedHorses.addForm(LastRiddenHorse)
		ENDIF
		IF DES_OwnedHorses.GetSize() > 1 && !HorseSelectTutorial
			IF HorseKey == 35
				Utility.Wait(1)
				HelpMessages[0].ShowAsHelpMessage("HorseSelectTutorial", messageDuration, 1.0, 1)
				HorseSelectTutorial = True
			ENDIF
		ENDIF
	ENDIF
endFunction

float function addAngles(float angle, float turn)
    angle += turn
    while(angle >= 360.0)
        angle -= 360.0
    endWhile
    while(angle < 0.0)
        angle += 360.0
    endWhile
    return angle
endFunction