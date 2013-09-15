#include "SDL.h"
module Graphics.UI.SDL.Enums where

import Control.Arrow

scancodeNames :: [(String, Integer)]
scancodeNames = map (first ("Scancode" ++)) $ [
      ("Unknown", 0)
    , ("A", 4)
    , ("B", 5)
    , ("C", 6)
    , ("D", 7)
    , ("E", 8)
    , ("F", 9)
    , ("G", 10)
    , ("H", 11)
    , ("I", 12)
    , ("J", 13)
    , ("K", 14)
    , ("L", 15)
    , ("M", 16)
    , ("N", 17)
    , ("O", 18)
    , ("P", 19)
    , ("Q", 20)
    , ("R", 21)
    , ("S", 22)
    , ("T", 23)
    , ("U", 24)
    , ("V", 25)
    , ("W", 26)
    , ("X", 27)
    , ("Y", 28)
    , ("Z", 29)

    , ("1", 30)
    , ("2", 31)
    , ("3", 32)
    , ("4", 33)
    , ("5", 34)
    , ("6", 35)
    , ("7", 36)
    , ("8", 37)
    , ("9", 38)
    , ("0", 39)

    , ("Return", 40)
    , ("Escape", 41)
    , ("Backspace", 42)
    , ("Tab", 43)
    , ("Space", 44)

    , ("Minus", 45)
    , ("Equals", 46)
    , ("Leftbracket", 47)
    , ("Rightbracket", 48)
    , ("Backslash", 49)
    , ("Nonushash", 50)
    , ("Semicolon", 51)
    , ("Apostrophe", 52)
    , ("Grave", 53)

    , ("Comma", 54)
    , ("Period", 55)
    , ("Slash", 56)

    , ("Capslock", 57)

    , ("F1", 58)
    , ("F2", 59)
    , ("F3", 60)
    , ("F4", 61)
    , ("F5", 62)
    , ("F6", 63)
    , ("F7", 64)
    , ("F8", 65)
    , ("F9", 66)
    , ("F10", 67)
    , ("F11", 68)
    , ("F12", 69)

    , ("Printscreen", 70)
    , ("Scrolllock", 71)
    , ("Pause", 72)
    , ("Insert", 73)
    , ("Home", 74)
    , ("Pageup", 75)
    , ("Delete", 76)
    , ("End", 77)
    , ("Pagedown", 78)
    , ("Right", 79)
    , ("Left", 80)
    , ("Down", 81)
    , ("Up", 82)

    , ("Numlockclear", 83)

    , ("KP_DIVIDE", 84)
    , ("KP_MULTIPLY", 85)
    , ("KP_MINUS", 86)
    , ("KP_PLUS", 87)
    , ("KP_ENTER", 88)
    , ("KP_1", 89)
    , ("KP_2", 90)
    , ("KP_3", 91)
    , ("KP_4", 92)
    , ("KP_5", 93)
    , ("KP_6", 94)
    , ("KP_7", 95)
    , ("KP_8", 96)
    , ("KP_9", 97)
    , ("KP_0", 98)
    , ("KP_PERIOD", 99)
    , ("Nonusbackslash", 100)
    , ("Application", 101)
    , ("Power", 102)
    , ("KP_EQUALS", 103)
    , ("F13", 104)
    , ("F14", 105)
    , ("F15", 106)
    , ("F16", 107)
    , ("F17", 108)
    , ("F18", 109)
    , ("F19", 110)
    , ("F20", 111)
    , ("F21", 112)
    , ("F22", 113)
    , ("F23", 114)
    , ("F24", 115)
    , ("EXECUTE", 116)
    , ("HELP", 117)
    , ("MENU", 118)
    , ("SELECT", 119)
    , ("STOP", 120)
    , ("AGAIN", 121)
    , ("UNDO", 122)
    , ("CUT", 123)
    , ("COPY", 124)
    , ("PASTE", 125)
    , ("FIND", 126)
    , ("MUTE", 127)
    , ("VOLUMEUP", 128)
    , ("VOLUMEDOWN", 129)
    , ("KP_COMMA", 133)
    , ("KP_EQUALSAS400", 134)

    , ("International1", 135)
    , ("International2", 136)
    , ("International3", 137)
    , ("International4", 138)
    , ("International5", 139)
    , ("International6", 140)
    , ("International7", 141)
    , ("International8", 142)
    , ("International9", 143)
    , ("Lang1", 144)
    , ("Lang2", 145)
    , ("Lang3", 146)
    , ("Lang4", 147)
    , ("Lang5", 148)
    , ("Lang6", 149)
    , ("Lang7", 150)
    , ("Lang8", 151)
    , ("Lang9", 152)

    , ("Alterase", 153)
    , ("Sysreq", 154)
    , ("Cancel", 155)
    , ("Clear", 156)
    , ("Prior", 157)
    , ("Return2", 158)
    , ("Separator", 159)
    , ("Out", 160)
    , ("Oper", 161)
    , ("Clearagain", 162)
    , ("Crsel", 163)
    , ("Exsel", 164)

    , ("KP_00", 176)
    , ("KP_000", 177)
    , ("Thousandsseparator", 178)
    , ("Decimalseparator", 179)
    , ("Currencyunit", 180)
    , ("Currencysubunit", 181)
    , ("KP_LEFTPAREN", 182)
    , ("KP_RIGHTPAREN", 183)
    , ("KP_LEFTBRACE", 184)
    , ("KP_RIGHTBRACE", 185)
    , ("KP_TAB", 186)
    , ("KP_BACKSPACE", 187)
    , ("KP_A", 188)
    , ("KP_B", 189)
    , ("KP_C", 190)
    , ("KP_D", 191)
    , ("KP_E", 192)
    , ("KP_F", 193)
    , ("KP_XOR", 194)
    , ("KP_POWER", 195)
    , ("KP_PERCENT", 196)
    , ("KP_LESS", 197)
    , ("KP_GREATER", 198)
    , ("KP_AMPERSAND", 199)
    , ("KP_DBLAMPERSAND", 200)
    , ("KP_VERTICALBAR", 201)
    , ("KP_DBLVERTICALBAR", 202)
    , ("KP_COLON", 203)
    , ("KP_HASH", 204)
    , ("KP_SPACE", 205)
    , ("KP_AT", 206)
    , ("KP_EXCLAM", 207)
    , ("KP_MEMSTORE", 208)
    , ("KP_MEMRECALL", 209)
    , ("KP_MEMCLEAR", 210)
    , ("KP_MEMADD", 211)
    , ("KP_MEMSUBTRACT", 212)
    , ("KP_MEMMULTIPLY", 213)
    , ("KP_MEMDIVIDE", 214)
    , ("KP_PLUSMINUS", 215)
    , ("KP_CLEAR", 216)
    , ("KP_CLEARENTRY", 217)
    , ("KP_BINARY", 218)
    , ("KP_OCTAL", 219)
    , ("KP_DECIMAL", 220)
    , ("KP_HEXADECIMAL", 221)

    , ("LCTRL", 224)
    , ("LSHIFT", 225)
    , ("LALT", 226)
    , ("LGUI", 227)
    , ("RCTRL", 228)
    , ("RSHIFT", 229)
    , ("RALT", 230)
    , ("RGUI", 231)

    , ("MODE", 257)

    , ("AUDIONEXT", 258)
    , ("AUDIOPREV", 259)
    , ("AUDIOSTOP", 260)
    , ("AUDIOPLAY", 261)
    , ("AUDIOMUTE", 262)
    , ("MEDIASELECT", 263)
    , ("WWW", 264)
    , ("MAIL", 265)
    , ("CALCULATOR", 266)
    , ("COMPUTER", 267)
    , ("AC_SEARCH", 268)
    , ("AC_HOME", 269)
    , ("AC_BACK", 270)
    , ("AC_FORWARD", 271)
    , ("AC_STOP", 272)
    , ("AC_REFRESH", 273)
    , ("AC_BOOKMARKS", 274)

    , ("BRIGHTNESSDOWN", 275)
    , ("BRIGHTNESSUP", 276)
    , ("DISPLAYSWITCH", 277)
    , ("KBDILLUMTOGGLE", 278)
    , ("KBDILLUMDOWN", 279)
    , ("KBDILLUMUP", 280)
    , ("EJECT", 281)
    , ("SLEEP", 282)

    , ("SCANCODE_APP1", 283)
    , ("SCANCODE_APP2", 284)
    ]


keycodeNames :: [(String, Integer)]
keycodeNames =
  [ ("A", #{const SDLK_a})
  , ("B", #{const SDLK_b})
  , ("C", #{const SDLK_c})
  , ("D", #{const SDLK_d})
  , ("E", #{const SDLK_e})
  , ("F", #{const SDLK_f})
  , ("G", #{const SDLK_g})
  , ("H", #{const SDLK_h})
  , ("I", #{const SDLK_i})
  , ("J", #{const SDLK_j})
  , ("K", #{const SDLK_k})
  , ("L", #{const SDLK_l})
  , ("M", #{const SDLK_m})
  , ("N", #{const SDLK_n})
  , ("O", #{const SDLK_o})
  , ("P", #{const SDLK_p})
  , ("Q", #{const SDLK_q})
  , ("R", #{const SDLK_r})
  , ("S", #{const SDLK_s})
  , ("T", #{const SDLK_t})
  , ("U", #{const SDLK_u})
  , ("V", #{const SDLK_v})
  , ("W", #{const SDLK_w})
  , ("X", #{const SDLK_x})
  , ("Y", #{const SDLK_y})
  , ("Z", #{const SDLK_z})
  , ("Number1", #{const SDLK_1})
  , ("Number2", #{const SDLK_2})
  , ("Number3", #{const SDLK_3})
  , ("Number4", #{const SDLK_4})
  , ("Number5", #{const SDLK_5})
  , ("Number6", #{const SDLK_6})
  , ("Number7", #{const SDLK_7})
  , ("Number8", #{const SDLK_8})
  , ("Number9", #{const SDLK_9})
  , ("Number0", #{const SDLK_0})
  , ("Return", #{const SDLK_RETURN})
  , ("Escape", #{const SDLK_ESCAPE})
  , ("Backspace", #{const SDLK_BACKSPACE} )
  , ("Tab", #{const SDLK_TAB} )
  , ("Space",        #{const SDLK_SPACE})
  , ("Minus",        #{const SDLK_MINUS})
  , ("Equals",       #{const SDLK_EQUALS})
  , ("LeftBracket",  #{const SDLK_LEFTBRACKET})
  , ("RightBracket", #{const SDLK_RIGHTBRACKET})
  , ("Backslash",    #{const SDLK_BACKSLASH})
  , ("Semicolon",    #{const SDLK_SEMICOLON})
  , ("Comma",        #{const SDLK_COMMA})
  , ("Period",       #{const SDLK_PERIOD})
  , ("Slash",        #{const SDLK_SLASH})
  , ("Capslock",     #{const SDLK_CAPSLOCK})
  , ("F1",           #{const SDLK_F1} )
  , ("F2",           #{const SDLK_F2} )
  , ("F3",           #{const SDLK_F3} )
  , ("F4",           #{const SDLK_F4} )
  , ("F5",           #{const SDLK_F5} )
  , ("F6",           #{const SDLK_F6} )
  , ("F7",           #{const SDLK_F7} )
  , ("F8",           #{const SDLK_F8} )
  , ("F9",           #{const SDLK_F9} )
  , ("F10",          #{const SDLK_F10})
  , ("F11",          #{const SDLK_F11})
  , ("F12",          #{const SDLK_F12})
  , ("PrintScreen",    #{const SDLK_PRINTSCREEN} )
  , ("ScrollLock",     #{const SDLK_SCROLLLOCK}  )
  , ("Pause",          #{const SDLK_PAUSE})
  , ("Insert",         #{const SDLK_INSERT})
  , ("Home",           #{const SDLK_HOME})
  , ("PageUp",         #{const SDLK_PAGEUP})
  , ("Delete",         #{const SDLK_DELETE})
  , ("End",            #{const SDLK_END})
  , ("PageDown",       #{const SDLK_PAGEDOWN})
  , ("Right",          #{const SDLK_RIGHT})
  , ("Left",           #{const SDLK_LEFT})
  , ("Down",           #{const SDLK_DOWN})
  , ("Up",             #{const SDLK_UP})
  , ("NumLockClear",   #{const SDLK_NUMLOCKCLEAR})
  , ("KeypadDivide",   #{const SDLK_KP_DIVIDE})
  , ("KeypadMultiply", #{const SDLK_KP_MULTIPLY})
  , ("KeypadMinus",    #{const SDLK_KP_MINUS})
  , ("KeypadPlus",     #{const SDLK_KP_PLUS})
  , ("KeypadEnter",    #{const SDLK_KP_ENTER})
  , ("Keypad1",        #{const SDLK_KP_1})
  , ("Keypad2",        #{const SDLK_KP_2})
  , ("Keypad3",        #{const SDLK_KP_3})
  , ("Keypad4",        #{const SDLK_KP_4})
  , ("Keypad5",        #{const SDLK_KP_5})
  , ("Keypad6",        #{const SDLK_KP_6})
  , ("Keypad7",        #{const SDLK_KP_7})
  , ("Keypad8",        #{const SDLK_KP_8})
  , ("Keypad9",        #{const SDLK_KP_9})
  , ("Keypad0",        #{const SDLK_KP_0})
  , ("KeypadPeriod", #{const SDLK_KP_PERIOD})
  , ("Application",  #{const SDLK_APPLICATION})
  , ("Power",        #{const SDLK_POWER})
  , ("KeypadEquals", #{const SDLK_KP_EQUALS})
  , ("F13",          #{const SDLK_F13})
  , ("F14",          #{const SDLK_F14})
  , ("F15",          #{const SDLK_F15})
  , ("F16",          #{const SDLK_F16})
  , ("F17",          #{const SDLK_F17})
  , ("F18",          #{const SDLK_F18})
  , ("F19",          #{const SDLK_F19})
  , ("F20",          #{const SDLK_F20})
  , ("F21",          #{const SDLK_F21})
  , ("F22",          #{const SDLK_F22})
  , ("F23",          #{const SDLK_F23})
  , ("F24",          #{const SDLK_F24})
  , ("Execute",      #{const SDLK_EXECUTE})
  , ("Help",         #{const SDLK_HELP})
  , ("Menu",         #{const SDLK_MENU})
  , ("Select",       #{const SDLK_SELECT})
  , ("Stop",         #{const SDLK_STOP})
  , ("Again",        #{const SDLK_AGAIN})
  , ("Undo",         #{const SDLK_UNDO})
  , ("Cut",          #{const SDLK_CUT})
  , ("Copy",         #{const SDLK_COPY})
  , ("Paste",        #{const SDLK_PASTE})
  , ("Find",         #{const SDLK_FIND})
  , ("Mute",         #{const SDLK_MUTE})
  , ("VolumeUp",     #{const SDLK_VOLUMEUP})
  , ("VolumeDown",   #{const SDLK_VOLUMEDOWN})
  , ("KeypadComma",  #{const SDLK_KP_COMMA})
  , ("KeyPadEqualsAs400 ", #{const SDLK_KP_EQUALSAS400})
  , ("AltErase",          #{const SDLK_ALTERASE})
  , ("SysReq",            #{const SDLK_SYSREQ})
  , ("Cancel",            #{const SDLK_CANCEL})
  , ("Clear",             #{const SDLK_CLEAR})
  , ("Prior",             #{const SDLK_PRIOR})
  , ("Return2",           #{const SDLK_RETURN2})
  , ("Separator",         #{const SDLK_SEPARATOR})
  , ("Out",               #{const SDLK_OUT})
  , ("Oper",              #{const SDLK_OPER})
  , ("ClearAgain",        #{const SDLK_CLEARAGAIN})
  , ("CrSel",             #{const SDLK_CRSEL})
  , ("ExSel",             #{const SDLK_EXSEL})
  , ("Keypad00",          #{const SDLK_KP_00})
  , ("Keypad000",         #{const SDLK_KP_000})
  , ("ThousandSeparator", #{const SDLK_THOUSANDSSEPARATOR})
  , ("DecimalSeparator",  #{const SDLK_DECIMALSEPARATOR})
  , ("CurrencyUnit",      #{const SDLK_CURRENCYUNIT})
  , ("CurrencySubunit",   #{const SDLK_CURRENCYSUBUNIT})
  , ("KeypadLeftParen",   #{const SDLK_KP_LEFTPAREN})
  , ("KeypadRightParen",  #{const SDLK_KP_RIGHTPAREN})
  , ("KeypadLeftBrace",   #{const SDLK_KP_LEFTBRACE})
  , ("KeypadRightBrace",  #{const SDLK_KP_RIGHTBRACE})
  , ("KeypadTab",         #{const SDLK_KP_TAB})
  , ("KeypadBackspace",   #{const SDLK_KP_BACKSPACE})
  , ("KeypadA",           #{const SDLK_KP_A})
  , ("KeypadB",           #{const SDLK_KP_B})
  , ("KeypadC",           #{const SDLK_KP_C})
  , ("KeypadD",           #{const SDLK_KP_D})
  , ("KeypadE",           #{const SDLK_KP_E})
  , ("KeypadF",           #{const SDLK_KP_F})
  , ("KeypadXOR",         #{const SDLK_KP_XOR})
  , ("KeypadPower",       #{const SDLK_KP_POWER})
  , ("KeypadPercent",     #{const SDLK_KP_PERCENT})
  , ("KeypadLess",        #{const SDLK_KP_LESS})
  , ("KeypadGreater",     #{const SDLK_KP_GREATER})
  , ("KeypadAmpersand",   #{const SDLK_KP_AMPERSAND})
  , ("KeypadDoubleAmpersand",   #{const SDLK_KP_DBLAMPERSAND})
  , ("KeypadVerticalBar",       #{const SDLK_KP_VERTICALBAR})
  , ("KeypadDoubleVerticalBar", #{const SDLK_KP_DBLVERTICALBAR})
  , ("KeypadColon",             #{const SDLK_KP_COLON})
  , ("KeypadHash",              #{const SDLK_KP_HASH})
  , ("KeypadSpace",             #{const SDLK_KP_SPACE})
  , ("KeypadAt",                #{const SDLK_KP_AT})
  , ("KeypadExclamation",  #{const SDLK_KP_EXCLAM})
  , ("KeypadMemStore",     #{const SDLK_KP_MEMSTORE})
  , ("KeypadMemRecall",    #{const SDLK_KP_MEMRECALL})
  , ("KeypadMemClear",     #{const SDLK_KP_MEMCLEAR})
  , ("KeypadMemAdd",       #{const SDLK_KP_MEMADD})
  , ("KeypadMemSubstract", #{const SDLK_KP_MEMSUBTRACT})
  , ("KeypadMemMultiply",  #{const SDLK_KP_MEMMULTIPLY})
  , ("KeypadMemDivide",    #{const SDLK_KP_MEMDIVIDE})
  , ("KeypadPlusMinus",    #{const SDLK_KP_PLUSMINUS})
  , ("KeypadClear",        #{const SDLK_KP_CLEAR})
  , ("KeypadClearEntry",   #{const SDLK_KP_CLEARENTRY})
  , ("KeypadBinary",       #{const SDLK_KP_BINARY})
  , ("KeypadOctal",        #{const SDLK_KP_OCTAL})
  , ("KeypadDecimal",      #{const SDLK_KP_DECIMAL})
  , ("KeypadHexadecimal",  #{const SDLK_KP_HEXADECIMAL})
  , ("LeftControl",        #{const SDLK_LCTRL})
  , ("LeftShift",          #{const SDLK_LSHIFT})
  , ("LeftAlt",            #{const SDLK_LALT})
  , ("LeftGUI",            #{const SDLK_LGUI})
  , ("RightControl",       #{const SDLK_RCTRL})
  , ("RightShift",         #{const SDLK_RSHIFT})
  , ("RightAlt",           #{const SDLK_RALT})
  , ("RightGUI",           #{const SDLK_RGUI})
  , ("Mode",               #{const SDLK_MODE})
  , ("AudioNext",          #{const SDLK_AUDIONEXT})
  , ("AudioPrevious",      #{const SDLK_AUDIOPREV})
  , ("AudioStop",          #{const SDLK_AUDIOSTOP})
  , ("AudioPlay",          #{const SDLK_AUDIOPLAY})
  , ("AudioMute",          #{const SDLK_AUDIOMUTE})
  , ("MediaSelect",        #{const SDLK_MEDIASELECT})
  , ("WWW",                #{const SDLK_WWW})
  , ("Mail",               #{const SDLK_MAIL})
  , ("Calculator",         #{const SDLK_CALCULATOR})
  , ("Computer",           #{const SDLK_COMPUTER})
  , ("ACSearch",           #{const SDLK_AC_SEARCH})
  , ("ACHome",             #{const SDLK_AC_HOME})
  , ("ACBack",             #{const SDLK_AC_BACK})
  , ("ACForward",          #{const SDLK_AC_FORWARD})
  , ("ACStop",             #{const SDLK_AC_STOP})
  , ("ACRefresh",          #{const SDLK_AC_REFRESH})
  , ("ACBookmarks",        #{const SDLK_AC_BOOKMARKS})
  , ("BrightnessDown", #{const SDLK_BRIGHTNESSDOWN})
  , ("BrightnessUp",   #{const SDLK_BRIGHTNESSUP})
  , ("DisplaySwitch",  #{const SDLK_DISPLAYSWITCH})
  , ("KBIllumToggle",  #{const SDLK_KBDILLUMTOGGLE})
  , ("KBIllumDown",    #{const SDLK_KBDILLUMDOWN})
  , ("KBIllumUp",      #{const SDLK_KBDILLUMUP})
  , ("Eject",          #{const SDLK_EJECT})
  , ("Sleep",          #{const SDLK_SLEEP})
  , ("Ampersand",      #{const SDLK_AMPERSAND})
  , ("Asterisk",       #{const SDLK_ASTERISK})
  , ("At",             #{const SDLK_AT})
  , ("Caret",          #{const SDLK_CARET})
  , ("Colon",          #{const SDLK_COLON})
  , ("Dollar",         #{const SDLK_DOLLAR})
  , ("Exclaim",        #{const SDLK_EXCLAIM})
  , ("Greater",        #{const SDLK_GREATER})
  , ("Hash",           #{const SDLK_HASH})
  , ("LeftParen",      #{const SDLK_LEFTPAREN})
  , ("Less",           #{const SDLK_LESS})
  , ("Percent",        #{const SDLK_PERCENT})
  , ("Plus",           #{const SDLK_PLUS})
  , ("Question",       #{const SDLK_QUESTION})
  , ("DoubleQuote",    #{const SDLK_QUOTEDBL})
  , ("RightParen",     #{const SDLK_RIGHTPAREN})
  , ("Underscore",     #{const SDLK_UNDERSCORE})
  ]

modifierNames :: [(String, Integer)]
modifierNames =
    [ ("KeyModNone",       #{const KMOD_NONE})
    , ("KeyModLeftShift",  #{const KMOD_LSHIFT})
    , ("KeyModRightShift", #{const KMOD_RSHIFT})
    , ("KeyModLeftCtrl",   #{const KMOD_LCTRL})
    , ("KeyModRightCtrl",  #{const KMOD_RCTRL})
    , ("KeyModLeftAlt",    #{const KMOD_LALT})
    , ("KeyModRightAlt",   #{const KMOD_RALT})
    , ("KeyModLeftMeta",   #{const KMOD_LGUI})
    , ("KeyModRightMeta",  #{const KMOD_RGUI})
    , ("KeyModNum",        #{const KMOD_NUM})
    , ("KeyModCaps",       #{const KMOD_CAPS})
    , ("KeyModMode",       #{const KMOD_MODE})
    , ("KeyModCtrl",       #{const KMOD_LCTRL} + #{const KMOD_RCTRL})
    , ("KeyModShift",      #{const KMOD_LSHIFT} + #{const KMOD_RSHIFT})
    , ("KeyModAlt",        #{const KMOD_LALT} + #{const KMOD_RALT})
    , ("KeyModMeta",       #{const KMOD_LGUI} + #{const KMOD_RGUI})
    ]