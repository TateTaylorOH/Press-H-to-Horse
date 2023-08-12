Scriptname DES_TrampleScript extends ActiveMagicEffect  

Int Property force  Auto  

EVENT OnEffectStart(Actor Target, Actor Caster)
	IF Target != game.GetPlayersLastRiddenHorse()
		Caster.PushActorAway(Target, Force)
	ENDIF
ENDEVENT

