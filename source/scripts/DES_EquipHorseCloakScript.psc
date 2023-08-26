Scriptname DES_EquipHorseCloakScript extends ActiveMagicEffect  
{This script will dynamically add the relevant miscitem to horses who are equipped. This allows the player to loot their saddles if the horse is killed.}

Formlist Property DES_HorseArmors auto
Formlist Property DES_HorseMiscItems auto

EVENT OnEffectStart(Actor Target, Actor Caster)
	Int i = DES_HorseArmors.Find(Target.GetEquippedArmorInSlot(45))
	Target.AddItem(DES_HorseMiscItems.GetAt(i) as MiscObject, 1)
ENDEVENT
