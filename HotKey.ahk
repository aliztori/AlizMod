;No dependencies

class HotKey {
	
	static First(HotKey) 	=> RegExReplace(HotKey, "( &.*$)")
	static Second(HotKey) 	=> RegExReplace(HotKey, "(^.*& )")
	static Both(HotKey) 	=> [this.First(Hotkey), this.Second(Hotkey)]
	
	static Raw(HotKey := A_ThisHotkey, Which?) {

		HotKey := RegExReplace(Hotkey, "[#!^+<>~*$]|(?i:[\t ]+up)")
		
		if InStr(Hotkey, " & ")
		{
			switch (Which ?? 2) {
				
				case 0:
					return Hotkey
					
				case 1: 
					Hotkey := this.First(Hotkey)
	
				case 2:
					Hotkey := this.Second(Hotkey)
					
				case 3: 
					Hotkey := this.Both(Hotkey)
			}
		}

		return Hotkey
	}
}




; Older Function i Used:
; But in general, what was above is better

/**
 * This function takes a hotkey and returns its original key
 *
 * Example Hotkey:
 * 
 * `^g` => g
 * 
 * `!#h` => h
 * 
 * `+s Up`  => s
 * 
 * `!s & f` => s or f

 * @param {String} Hotkey is the Any HotKey or Built-in Variable Like A_ThisHotkey
 * @param {"first" Or "second"} Which is for Combination Key You Might Choose Which Key You Want
 * @returns {String} Key the raw hotkey pressed. equivalent to A_ThisHotkey without modifiers.
 */
Raw(Hotkey := A_ThisHotkey, Which?)
{
	Hotkey := RegExReplace(Hotkey, "[#!^+<>~*$]|(?i:[\t ]+up)")

	if InStr(Hotkey, " & ")
	{
		switch Which ?? 2 {

			case 0:
				return Hotkey
				
			case 1: 
				Hotkey := RegExReplace(Hotkey, "( &.*$)")

			case 2:
				Hotkey := RegExReplace(Hotkey, "(^.*& )")
				
			case 3: 
				Hotkey := [RegExReplace(Hotkey, "( &.*$)"), RegExReplace(Hotkey, "(^.*& )")]
		}
	}

	return Hotkey
}



