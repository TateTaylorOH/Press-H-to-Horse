Scriptname DES_HorseMCMScriptOnInt extends MCM_ConfigBase

ReferenceAlias Property Player auto

int property iHorseKey auto
float property fHoldTime auto
int property iCarryWeight auto
bool property bFollowerHorse auto
bool property bShowTutorials auto
bool property bDebugging auto

Event OnConfigInit()
	iHorseKey = GetModSettingInt("iHorseKey:General")
	fHoldTime = GetModSettingFloat("fHoldTime:General")
	iCarryWeight = GetModSettingInt("iCarryWeight:General")
	bFollowerHorse = GetModSettingInt("bFollowerHorse:General")
	bShowTutorials = GetModSettingBool("bShowTutorials:General")
	bDebugging = GetModSettingBool("bDebugging:General")
EndEvent

Event OnSettingChange(string a_ID)	
	if a_ID == "iHorseKey:General"
		iHorseKey = GetModSettingInt("iHorseKey:General")
		(Player as DES_OnLoadUpdateScript).RegisterKey()
	elseif a_ID == "fHoldTime:General"
		fHoldTime = GetModSettingFloat("fHoldTime:General")	
	elseif a_ID == "iCarryWeight:General"
		iCarryWeight = GetModSettingInt("iCarryWeight:General")
	elseif a_ID == "bFollowerHorse:General"
		bFollowerHorse = GetModSettingBool("bFollowerHorse:General")
	elseif a_ID == "bShowTutorials:General"
		bShowTutorials = GetModSettingBool("bShowTutorials:General")
	elseif a_ID == "bDebugging:General"
		bDebugging = GetModSettingBool("bDebugging:General")
	endif
EndEvent

Function NewSettings()
	bFollowerHorse = GetModSettingInt("bFollowerHorse:General")
EndFunction