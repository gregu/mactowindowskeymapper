; ==============================================================================
; MAC OS ULTIMATE V33 (USER MODE + INTELLIJ FOCUS)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

; --- GRUPS ---
GroupAdd "Editors", "ahk_exe idea64.exe"      ; IntelliJ
GroupAdd "Editors", "ahk_exe Code.exe"        ; VS Code
GroupAdd "Explorer", "ahk_class CabinetWClass"
GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"

; ==============================================================================
; 1. SYSTEM KILLERS (Specific for IntelliJ without Admin)
; ==============================================================================
; Używamy scancode (SC) zamiast nazw klawiszy, to czasem omija blokady.

#HotIf WinActive("ahk_group Editors")
    ; ZMUSZAMY Windowsa do oddania Win+F w IntelliJ
    $#f::Send "^f"
    $#+f::Send "^+f"
    $#c::Send "^c"
    $#v::Send "^v"
    
    ; Jeśli powyższe nie działa, odkomentuj poniższe linie (PLAN B)
    ; I w IntelliJ ustaw "Find" na Ctrl+Alt+F
    ; $#f::Send "^!f" 
#HotIf

; Globalne zabijanie Feedback Hub (Dla reszty systemu)
$#f::Send "^f"
$#+f::Send "^+f"

; ==============================================================================
; 2. CORE REMAP
; ==============================================================================
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

*LCtrl::
{
    if WinActive("ahk_group Terminals")
        Send "{Blind}{LCtrl DownR}"
    else
        Send "{Blind}{LWin DownR}"
}
*LCtrl Up::
{
    if WinActive("ahk_group Terminals")
        Send "{Blind}{LCtrl Up}"
    else {
        Send "{Blind}{LWin Up}"
        if (A_PriorKey = "LCtrl")
            Send "{Blind}{vkE8}"
    }
}

; ==============================================================================
; 3. LOGIC DISPATCHER
; ==============================================================================

; --- ARROWS & SELECTION ---
*^Up::
{
    if GetKeyState("Shift", "P")
        Send "+^{Home}"
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}"
    else
        Send "^{Home}"
}

*^Down::
{
    if GetKeyState("Shift", "P")
        Send "+^{End}"
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}"
    else
        Send "^{End}"
}

*^Left::
{
    if GetKeyState("Shift", "P")
        Send "+{Home}"
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}"
    else
        Send "{Home}"
}

*^Right::
{
    if GetKeyState("Shift", "P")
        Send "+{End}"
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}"
    else
        Send "{End}"
}

; --- EDITING ---
*^Backspace::
{
    if GetKeyState("Shift", "P") {
        if WinActive("ahk_group Explorer")
            Send "+{Delete}"
        else
            Send "^+{Backspace}"
    } else {
        if WinActive("ahk_group Explorer")
            Send "{Delete}"
        else
            Send "+{Home}{Delete}"
    }
}

Enter::
{
    if WinActive("ahk_group Explorer")
        Send "{F2}"
    else
        Send "{Enter}"
}

; --- SHORTCUTS ---
^c:: Send WinActive("ahk_group Terminals") ? "^+c" : "^c"
^v:: Send WinActive("ahk_group Terminals") ? "^+v" : "^v"
^n:: Send "^n"
^+n:: Send "^+n"

; Cmd+F Logic
^f::
{
    if WinActive("ahk_group Terminals")
        Send "^+f"
    else if WinActive("ahk_group Explorer")
        Send "^e"
    else
        Send "^f"
}

; Cmd+Space (Start)
^Space::Send "^{Esc}"

; Tab
LCtrl & Tab::AltTab

; --- F-KEYS ---
F3::Send "#{Tab}"
F4::Send "^{Esc}"
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; Misc
^q::Send "!{F4}"
SC029::Send "{Text}§"
+SC029::Send "{Text}±"
LCtrl & LButton::Click "Right"
RAlt::RAlt