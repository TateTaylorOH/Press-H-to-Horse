Scriptname DBShadowmereTriggerScript extends ObjectReference  

EVENT OnTriggerEnter(ObjectReference AkActivator)

IF(game.getPlayer()==AkActivator)
	IF pDB07.GetStage() >= (20)
		ShadowmereEffect.Activate(Self) 
             ShadowmereSound.Play(ShadowmereEffect)
		Utility.Wait(12)
		ShadowmereAlias.GetActorReference().PlayIdle(HorseRearUp)
		pDB07.SetObjectiveCompleted (666)
		pDB07.SetObjectiveDisplayed(20, 1)
		Actor Shadowmere = ShadowmereAlias.getactorreference()
		(Quest.GetQuest("DES_HorseHandler") as DES_HorseInventoryScript).FirstTimeEquipHorse(Shadowmere)
		Disable()
	ENDIF
ENDIF


ENDEVENT

Quest Property pDB07  Auto  

ObjectReference Property ShadowmereEffect  Auto  
Sound Property ShadowmereSound  Auto  

Idle Property HorseRearUp  Auto  

ReferenceAlias Property ShadowmereAlias  Auto  