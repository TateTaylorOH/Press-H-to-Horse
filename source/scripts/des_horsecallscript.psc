Scriptname DES_HorseCallScript extends Quest

float property messageDuration = 3.0 auto
float property messageInterval = 1.0 auto
Message[] Property HelpMessages Auto
ReferenceAlias Property Alias_PlayersHorse auto
Actor Property PlayerRef Auto
Faction Property PlayerHorseFaction Auto
bool Property HorseSelectTutorial  auto
int property horseKey auto
Formlist Property DES_ValidWorldspaces auto
Sound Property DES_HorseStayMarker auto
Sound Property DES_HorseCallMarker auto
Formlist Property DES_OwnedHorses auto
ReferenceAlias Property StablesHorse auto

float horseAngle = 180.0 ; where the horse should appear relative to the player, clockwise from north.
float horseDistance = 512.0

Event OnKeyUp(Int KeyCode, Float HoldTime)
	Actor LastRiddenHorse = StablesHorse
	IF (KeyCode == horseKey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()) && !Game.GetCurrentCrosshairRef() && !PlayerRef.IsOnMount(); this is a valid keypress
		IF (!PlayerRef.IsInInterior() && DES_ValidWorldspaces.HasForm(PlayerRef.getWorldSpace())) ; this is a valid place to summon the horse
			IF HoldTime < papyrusinimanipulator.PullFloatFromIni("Data/H2Horse.ini", "General", "HoldTime", 0.9000) 
				IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)) && !LastRiddenHorse.IsDead(); there is a last horse, it's the players, and it's not dead
					CallLastHorse()
				ENDIF
			ELSE
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
						Actor SelectedHorse = menu.GetResultForm() as Actor
						StablesHorse.ForceRefTo(SelectedHorse)
						RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
						Debug.Notification("You call for " + SelectedHorse.GetDisplayName() + ".")
						IF !PlayerRef.IsWeaponDrawn() && PlayerRef.GetSitState() == 0
							Debug.SendAnimationEvent(PlayerRef, "Whistling")
							MfgConsoleFunc.SetPhoneMe(PlayerRef, 6, 30)
							DES_HorseCallMarker.Play(PlayerRef)
							Utility.Wait(1.0)
							MfgConsoleFunc.ResetPhonemeModifier(PlayerRef)
							Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
						ELSE
							DES_HorseCallMarker.Play(PlayerRef)
						ENDIF
						Alias_PlayersHorse.Clear()
						Alias_PlayersHorse.ForceRefTo(SelectedHorse)
						SelectedHorse.EvaluatePackage()
						IF !PlayerRef.HasLOS(SelectedHorse)
							float az = addAngles(PlayerRef.getAngleZ(), horseAngle)
							SelectedHorse.moveTo(PlayerRef, horseDistance * math.sin(az), horseDistance * Math.cos(az), 0.0, true)
						ENDIF
						GoToState("UncalledHorse")
					ENDIF
				ELSE
					CallLastHorse()
				ENDIF
			ENDIF
		ELSE
			IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)) ; there is a last horse, and it's the players
				Debug.Notification(LastRiddenHorse.GetDisplayName() + " cannot be called here.")
			ENDIF
		ENDIF
	ENDIF
endEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    if (akSource == PlayerRef) && (asEventName == "tailHorseMount")
        GoToState("UncalledHorse")
        UnregisterForAnimationEvent(PlayerRef, "tailHorseMount")
        Alias_PlayersHorse.Clear()
    endif
EndEvent

Function CallLastHorse()

	IF (GetState() == "UncalledHorse")
		GoToState("CalledHorse")
	ELSE
		GoToState("UncalledHorse")
	ENDIF

endFunction

State CalledHorse

	EVENT OnStateBegin()

		Actor LastRiddenHorse = StablesHorse
		RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
		Debug.Notification("You call for " + LastRiddenHorse.GetDisplayName() + ".")
		IF !PlayerRef.IsWeaponDrawn() && PlayerRef.GetSitState() == 0
			Debug.SendAnimationEvent(PlayerRef, "Whistling")
			MfgConsoleFunc.SetPhoneMe(PlayerRef, 6, 30)
			DES_HorseCallMarker.Play(PlayerRef)
			Utility.Wait(1.0)
			MfgConsoleFunc.ResetPhonemeModifier(PlayerRef)
			Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
		ELSE
			DES_HorseCallMarker.Play(PlayerRef)
		ENDIF
		Alias_PlayersHorse.Clear()
		Alias_PlayersHorse.ForceRefTo(LastRiddenHorse)
		LastRiddenHorse.EvaluatePackage()
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

	ENDEVENT

	EVENT OnStateEnd()

		Actor LastRiddenHorse = StablesHorse
		UnregisterForAnimationEvent(PlayerRef, "tailHorseMount")
		Debug.Notification("You tell "+ LastRiddenHorse.GetDisplayName() + " to wait.")
		IF !PlayerRef.IsWeaponDrawn() && PlayerRef.GetSitState() == 0
			Debug.SendAnimationEvent(PlayerRef, "Whistling")
			MfgConsoleFunc.SetPhoneMe(PlayerRef, 6, 30)
			DES_HorseStayMarker.Play(PlayerRef)
			Utility.Wait(1.0)
			MfgConsoleFunc.ResetPhonemeModifier(PlayerRef)
			Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
		ELSE
			DES_HorseStayMarker.Play(PlayerRef)
		ENDIF
		Alias_PlayersHorse.Clear()
		LastRiddenHorse.EvaluatePackage()
	ENDEVENT

EndState

State UncalledHorse

EndState

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
