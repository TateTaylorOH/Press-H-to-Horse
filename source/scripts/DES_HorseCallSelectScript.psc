Scriptname DES_HorseCallSelectScript extends Quest  

String[] Property OwnedHorses auto
float Property longPress auto

Event OnInit()
	RegisterForKey(34)
	Debug.Notification("Key registered")
EndEvent

Event OnKeyDown(Int KeyCode)
    IF (KeyCode == 34 && !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()) && !Game.GetCurrentCrosshairRef() ; this is a valid keypress
		Debug.Notification("Key pressed")
		utility.wait(0.1)
		int index = 0
		;if(longPress)
			Form f = Game.GetFormFromFile(0xE05, "UIExtensions.esp")
			if(f && f as UIListMenu)
				Debug.Notification("f && f")
				UIListMenu list = f as UIListMenu
				list.resetMenu()
				int i = 0
			;while (i < 9 && OwnedHorses[i])
				string text = OwnedHorses[i]
				list.addEntryItem(text)
				i += 1
			;endWhile
				if(i > 0)
				Debug.Notification("If 1 > 0")
					int j = list.openMenu()
					index = list.getResultInt()
				endIf
				endIf
		;endIf
		;if(index >= 0 && recentBlessings[index])
		;	bless(PlayerRef, recentBlessings[index], recentMessages[index], godNames[index])
		;endIf
	ENDIF
ENDEVENT