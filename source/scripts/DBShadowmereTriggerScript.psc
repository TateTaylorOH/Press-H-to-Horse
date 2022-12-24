Scriptname DBShadowmereTriggerScript extends ObjectReference  

Event OnTriggerEnter(ObjectReference AkActivator)

If(game.getPlayer()==AkActivator)
	if pDB07.GetStage() >= (20)
		Actor Shadowmere = ShadowmereAlias.getactorreference()
		Shadowmere.AddToFaction(PlayerHorseFaction)
		Shadowmere.SetAV("CarryWeight", 100.0)
		Shadowmere.AddSpell(DES_HorseFear)
		(PlayersHorseEquipAlias as DES_HorseEquipScript).SaddleBags = True
		Shadowmere.AddItem(DES_DarkBrotherhoodSaddle, 1)
		ShadowmereEffect.Activate(Self) 
             ShadowmereSound.Play(ShadowmereEffect)
		Utility.Wait(12)
		ShadowmereAlias.GetActorReference().PlayIdle(HorseRearUp)
		pDB07.SetObjectiveCompleted (666)
		pDB07.SetObjectiveDisplayed(20, 1)
		Disable()
	Endif
Endif


EndEvent

Quest Property pDB07  Auto  

ObjectReference Property ShadowmereEffect  Auto  
Sound Property ShadowmereSound  Auto  

Idle Property HorseRearUp  Auto  

ReferenceAlias Property ShadowmereAlias  Auto  

MiscObject Property DES_DarkBrotherhoodSaddle auto

ReferenceAlias Property PlayersHorseEquipAlias auto

Spell Property DES_HorseFear auto

Faction Property PlayerHorseFaction auto