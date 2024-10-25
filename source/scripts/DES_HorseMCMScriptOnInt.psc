Scriptname DES_HorseMCMScriptOnInt extends MCM_ConfigBase

ReferenceAlias Property Player auto

int property iHorseKey auto
float property fHoldTime auto
int property iCarryWeight auto
bool property bFollowerHorse auto
bool property bShowTutorials auto
bool property bDebugging auto

MiscObject[] Property Saddles auto

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
		UpdateSaddleDescriptions()
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

Function UpdateSaddleDescriptions()
	int L = Saddles.Length
	int i = 0
	IF iCarryWeight == 105
		while i < L
			DescriptionFramework.ResetDescription(Saddles[i])
			i +=1 
		endWhile
	ELSE
		while i < L
			DescriptionFramework.SetDescription(Saddles[i], "Increases a horse's carrying capacity by <font color='#FFFFFF'>" + (iCarryWeight - 5) + "</font> points while equipped and it will flee from combat.")
			i +=1 
		endWhile
	ENDIF
endFunction