Scriptname DES_HorseChompScript extends Actor 

;-- Properties --------------------------------------

Sound Property DES_HorseChompMarker Auto
Spell Property DES_HorseBlessing auto
Message Property DES_HorseBlessingMessage auto
Actor property PlayerRef auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	DES_HorseChompMarker.play(PlayerRef)
	DES_HorseBlessingMessage.Show()
	PlayerRef.DispelSpell(DES_HorseBlessing)
	utility.wait(0.5)
	DES_HorseBlessing.Cast(PlayerRef)
EndEvent


