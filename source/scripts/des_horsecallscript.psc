Scriptname DES_HorseCallScript extends Quest

ReferenceAlias Property Alias_PlayersHorse auto
Actor Property PlayerRef Auto
Faction Property PlayerHorseFaction Auto
bool property CalledHorse auto
int property horseKey auto
Formlist Property DES_ValidWorldspaces auto
Sound Property DES_HorseStayMarker auto
Sound Property DES_HorseCallMarker auto
Formlist Property DES_OwnedHorses auto
Quest Property DES_RenameHorseQuestAuto auto

float horseAngle = 180.0 ; where the horse should appear relative to the player, clockwise from north.
float horseDistance = 512.0

Event OnKeyDown(Int KeyCode)
    IF (KeyCode == horseKey && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()) && !Game.GetCurrentCrosshairRef() ; this is a valid keypress
    Actor LastRiddenHorse = Game.GetPlayersLastRiddenHorse()
        IF (!PlayerRef.IsInInterior() && DES_ValidWorldspaces.HasForm(PlayerRef.getWorldSpace())) ; this is a valid place to summon the horse
            Actor CauseHorse = Game.GetFormFromFile(0xB4B, "ccbgssse067-daedinv.esm") As Actor
            IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)); there is a last horse, and it's the players
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
			;IF !DES_OwnedHorses.HasForm(DES_RenameHorseQuestAuto as DES_HorseCallSelectScript).OwnedHorses
			;	DES_OwnedHorses.addEntryItem(DES_RenameHorseQuestAuto as DES_HorseCallSelectScript).OwnedHorses
			;ENDIF
			DES_HorseCallMarker.Play(PlayerRef)
                    IF !PlayerRef.HasLOS(LastRiddenHorse)
                        float az = addAngles(PlayerRef.getAngleZ(), horseAngle)
                        LastRiddenHorse.moveTo(PlayerRef, horseDistance * math.sin(az), horseDistance * Math.cos(az), 0.0, true)
                    ENDIF
                ENDIF
            ENDIF
	ELSE
            IF (LastRiddenHorse && LastRiddenHorse.IsInFaction(PlayerHorseFaction)) ; there is a last horse, and it's the players
			Debug.Notification(LastRiddenHorse.GetDisplayName() + " cannot be called here.")
		ELSE
			Debug.Notification("Your horse cannot be called here.")
		ENDIF
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