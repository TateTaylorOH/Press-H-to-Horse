Scriptname DES_HorseCallSelectScript extends Quest  

bool initialized
bool working
FormList Property DES_OwnedHorses Auto
ObjectReference[] refs
string[] names
int index
int refsLength
float longPressTime
bool property longPress auto

Actor property PlayerRef auto

;form types
bool[] namedType
int kScrollItem       = 23
int kActivator        = 24
int kTalkingActivator = 25
int kArmor            = 26
int kBook             = 27
int kContainer        = 28
int kDoor             = 29
int kIngredient       = 30
int kMisc             = 32
int kTree             = 38
int kFlora            = 39
int kWeapon           = 41
int kAmmo             = 42
int kNPC              = 43
int kKey              = 45
int kPotion           = 46
int kSoulGem          = 52

Event OnInit()
	initialized = false
	working = false
	registerForSingleUpdate(1.0)
	registerForControl(35)
	longPressTime = Game.getGameSettingFloat("fShoutTime2")
endEvent

Event OnUpdate()
	if(!initialized && !working)
		initialize()
	endIf
endEvent

Event OnKeyDown(Int KeyCode)
	If KeyCode == 35
		longPress = false
	EndIf
EndEvent

Event OnKeyUp(Int KeyCode, float HoldTime)
	If KeyCode == 35
		longPress = HoldTime >= longPressTime
		if longPress
			selectHorse()
		endif
	EndIf
EndEvent

function initialize()
	working = true
	;form types
	namedType = new bool[53]
	namedType[kActivator] = true
	namedType[kAmmo] = true
	namedType[kArmor] = true
	namedType[kBook] = true
	namedType[kContainer] = true
	namedType[kDoor] = true
	namedType[kFlora] = true
	namedType[kIngredient] = true
	namedType[kKey] = true
	namedType[kMisc] = true
	namedType[kNPC] = true
	namedType[kPotion] = true
	namedType[kScrollItem] = true
	namedType[kSoulGem] = true
	namedType[kTalkingActivator] = true
	namedType[kTree] = true
	namedType[kWeapon] = true
	;copy refs to array
	int i = 0
	int n = DES_OwnedHorses.getSize()
	refs = new ObjectReference[128]
	names = new string[128]
	index = 0
	while i < n && index < 128
		ObjectReference ref = DES_OwnedHorses.getAt(i) as ObjectReference
		if(ref)
			refs[index] = ref
			names[index] = formatName(ref)
			index += 1
		endIf
		i += 1
	endWhile
	refsLength = index
	index = 0
	initialized = true
	working = false
endFunction

function callSelectedHorse(int i = -1)
	if(refsLength == 0 || !initialized || working)
		return
	endIf
	working = true
	if(i >= 0)
		index = i
	endIf
	index %= refsLength
	ObjectReference ref = refs[index]
	index += 1
	PlayerRef.moveTo(ref)
	working = false
endFunction

function selectHorse()
	working = true
	Form f = Game.GetFormFromFile(0xE05, "UIExtensions.esp")
	if(f && f as UIListMenu)
		UIListMenu list = f as UIListMenu
		list.resetMenu()
		int i = 0
		while i < refsLength
			list.AddEntryItem(names[i])
			i += 1
		endWhile
		int j = list.openMenu()
		int selection = list.getResultInt()
		working = false
		callSelectedHorse(selection)
	else
		debug.notification("UIExtensions missing.")
		utility.wait(1.0)
		working = false
		callSelectedHorse()
	endIf
endFunction

string function formatName(ObjectReference ref)
	Form base = ref.getBaseObject()
	int type = base.getType()
	bool named = type < namedType.length && namedType[type]
	string formName = ""
	string locName = ""
	string name = ""
	if(named && ref.getDisplayName() != "")
		formName = ref.getDisplayName()
	endIf
	return name
endFunction