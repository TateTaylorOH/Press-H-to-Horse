Scriptname DES_FollowerMountScript extends Quest  

Actor Property PlayerRef auto
ReferenceAlias Property DialogueFollower_Follower auto
ReferenceAlias Property Follower auto
ReferenceAlias Property FollowerHorse auto
Formlist Property DES_OwnedHorses auto
Quest Property DES_HorseMCMQuest auto

EVENT OnAnimationEVENT(ObjectReference akSource, string AsEventName)
	IF (akSource == PlayerRef) && (AsEventName == "tailHorseMount") && (DES_HorseMCMQuest as DES_HorseMCMScriptOnInt).bFollowerHorse == true && DES_OwnedHorses.GetSize() > 1 && DialogueFollower_Follower
		int i = 0
		int n = DES_OwnedHorses.getSize()
		actor playershorse = Game.GetPlayersLastRiddenHorse()
		actor closestHorse
		float minDistance
		if(PlayersHorse == DES_OwnedHorses.getAt(0))
			i = 1
		endIf
		closestHorse = DES_OwnedHorses.getAt(i) as actor
		minDistance = closestHorse.getDistance(playerref)
		while i < n
			actor horse = DES_OwnedHorses.getAt(i) as actor
			float dist = horse.getDistance(playerref)
			if(dist < minDistance && horse != playershorse)
				closestHorse = horse
				minDistance = dist
			endIf
			i += 1
		endWhile
		IF closestHorse.getDistance(DialogueFollower_Follower.GetActorRef()) < 3072
			FollowerHorse.ForceRefTo(closestHorse)		
			Follower.ForceRefTo(DialogueFollower_Follower.GetActorRef())
			FollowerHorse.tryToEvaluatePackage()
			Follower.tryToEvaluatePackage()
			RegisterForAnimationEvent(Follower.GetActorRef(), "tailHorseMount") 
			RegisterForAnimationEvent(PlayerRef, "tailHorseDismount")
		ENDIF
	ELSEIF (akSource == Follower.GetActorRef()) && (AsEventName == "tailHorseMount") && Follower
		Follower.tryToEvaluatePackage()
		UnregisterForAnimationEvent(Follower.GetActorRef(), "tailHorseMount") 
	ELSEIF (akSource == PlayerRef) && (AsEventName == "tailHorseDismount") && Follower		
		UnregisterForAnimationEvent(PlayerRef, "tailHorseDismount")
		Follower.GetActorRef().Activate(FollowerHorse.GetActorRef())
		Follower.tryToEvaluatePackage()
		Follower.trytoClear()
		FollowerHorse.trytoClear()
	ENDIF
ENDEVENT