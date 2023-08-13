Scriptname DES_EquipHorseCloakScript extends ActiveMagicEffect  
{This script will dynamically add the relevant miscitem to horses who are equipped. This allows the player to loot their saddles if the horse is killed.}

Quest Property DES_HorseHandler auto

EVENT OnEffectStart(Actor Target, Actor Caster)
	DES_HorseInventoryScript Inventory = DES_HorseHandler as DES_HorseInventoryScript
	Int i = Inventory.HorseArmorList.Find(Target.GetEquippedArmorInSlot(45))
	Target.AddItem(Inventory.MiscItemList[i], 1)
ENDEVENT
