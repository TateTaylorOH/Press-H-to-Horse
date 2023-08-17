Scriptname DES_EquipHorseCloakScript extends ActiveMagicEffect  
{This script will dynamically add the relevant miscitem to horses who are equipped. This allows the player to loot their saddles if the horse is killed.}

Actor Property PlayerRef auto
Formlist Property DES_HorseArmors auto
Formlist Property DES_HorseMiscItems auto
ReferenceAlias Property Alias_LastRiddenHorse auto

EVENT OnEffectStart(Actor Target, Actor Caster)
	Actor LastRiddenHorse = Alias_LastRiddenHorse.getActorRef()
	Int i = DES_HorseArmors.Find(Target.GetEquippedArmorInSlot(45))
	IF Target.GetItemCount(DES_HorseMiscItems) < 1
		Target.AddItem(DES_HorseMiscItems.GetAt(i) as MiscObject, 1)
	ENDIF
	IF Target != LastRiddenHorse
		RegisterForAnimationEVENT(PlayerRef, "tailHorseMount")
	ENDIF
ENDEVENT

EVENT OnEffectEnd(Actor Target, Actor Caster)
	UnregisterForAnimationEVENT(PlayerRef, "tailHorseMount")
ENDEVENT