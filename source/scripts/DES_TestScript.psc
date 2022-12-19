Scriptname DES_TestScript extends Quest  

Formlist Property DES_HorseMiscItems auto

EVENT OnInit()
	RegisterForKey(34)
ENDEVENT

Event OnKeyDown(Int KeyCode)
    IF (KeyCode == 34 && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()) && !Game.GetCurrentCrosshairRef() ; this is a valid keypress
		Formlist sOptions = DES_HorseMiscItems 
		UILIB_1.ListMenu_Open(Self)
	endif
ENDEVENT