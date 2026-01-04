; ==============================================================================
; MAC OS ULTIMATE V32 (USER MODE - NO ADMIN REQUIRED)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

; MASK KEY (Zapobiega otwieraniu Startu przy kliknięciu Ctrl)
A_MenuMaskKey := "vkE8"

; --- GROUPS ---
GroupAdd "Explorer", "ahk_class CabinetWClass"
GroupAdd "Explorer", "ahk_class ExploreWClass"

GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Browsers", "ahk_exe firefox.exe"
GroupAdd "Browsers", "ahk_exe brave.exe"
GroupAdd "Browsers", "ahk_exe opera.exe"

GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"
GroupAdd "Terminals", "ahk_exe powershell.exe"
GroupAdd "Terminals", "ahk_exe cmd.exe"
GroupAdd "Terminals", "ahk_exe mintty.exe"
GroupAdd "Terminals", "ahk_class ConsoleWindowClass"

GroupAdd "Editors", "ahk_exe idea64.exe"      
GroupAdd "Editors", "ahk_exe Code.exe"        
GroupAdd "Editors", "ahk_exe studio64.exe"    
GroupAdd "Editors", "ahk_exe pycharm64.exe"
GroupAdd "Editors", "ahk_exe webstorm64.exe"

; ==============================================================================
; 1. SYSTEM INTERCEPTORS (Próba zablokowania Windowsa bez Admina)
; ==============================================================================
; Znak $ jest kluczowy - wymusza użycie hooka systemowego.

$#c::Send "^c"          ; Blokuje Copilot
$#f::Send "^f"          ; Blokuje Feedback Hub
$#+f::Send "^+f"        ; Blokuje Web Search
$#r::Send "^r"          ; Blokuje Run
$#e::Send "^e"          ; Blokuje Explorer
$#a::Send "^a"          ; Blokuje Action Center
$#s::Send "^s"          ; Blokuje Search
$#v::Send "^v"          ; Blokuje Schowek
$#x::Send "^x"          ; Blokuje Menu Start Prawy
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo

; IntelliJ Specifics (Dla edytorów, podmieniamy skróty Win+...)
$#1::Send WinActive("ahk_group Editors") ? "!1" : "#1"
$#7::Send WinActive("ahk_group Editors") ? "!7" : "#7"
$#9::Send WinActive("ahk_group Editors") ? "!9" : "#9"
$#`::Send WinActive("ahk_group Editors") ? "!{F12}" : "#{`}"
$#/::Send WinActive("ahk_group Editors") ? "^/" : "#/"
$#b::Send WinActive("ahk_group Editors") ? "^b" : "#b"
$#d::Send WinActive("ahk_group Editors") ? "^d" : "#d"

; ==============================================================================
; 2. CORE REMAPPING (Zamiana fizyczna klawiszy)
; ==============================================================================

; Cmd (LWin) -> Ctrl
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; Ctrl (LCtrl) -> Win
*LCtrl::
{
    if WinActive("ahk_group Terminals")
        Send "{Blind}{LCtrl DownR}" ; W terminalu zostaw Ctrl
    else
        Send "{Blind}{LWin DownR}"
}

*LCtrl Up::
{
    if WinActive("ahk_group Terminals")
        Send "{Blind}{LCtrl Up}"
    else {
        Send "{Blind}{LWin Up}"
        ; Blokada Menu Start przy pojedynczym kliknięciu
        if (A_PriorKey = "LCtrl")
            Send "{Blind}{vkE8}"
    }
}

; ==============================================================================
; 3. LOGIC DISPATCHER (Obsługa nawigacji i akcji)
; ==============================================================================

; --- ARROWS (Zintegrowana obsługa Shift) ---
; Gwiazdka * oznacza "z dowolnym modyfikatorem" (np. Shift)
*^Up::
{
    if GetKeyState("Shift", "P")
        Send "+^{Home}"               ; Zaznacz do góry
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}"   ; Folder w górę
    else
        Send "^{Home}"                ; Idź na górę
}

*^Down::
{
    if GetKeyState("Shift", "P")
        Send "+^{End}"                ; Zaznacz w dół
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}" ; Otwórz folder
    else
        Send "^{End}"                 ; Idź na dół
}

*^Left::
{
    if GetKeyState("Shift", "P")
        Send "+{Home}"                ; Zaznacz do początku
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}" ; Wstecz
    else
        Send "{Home}"                 ; Poczatek linii
}

*^Right::
{
    if GetKeyState("Shift", "P")
        Send "+{End}"                 ; Zaznacz do końca
    else if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}" ; Dalej
    else
        Send "{End}"                   ; Koniec linii
}

; --- BACKSPACE ---
*^Backspace::
{
    if GetKeyState("Shift", "P") {
        ; Cmd+Shift+Backspace
        if WinActive("ahk_group Explorer")
            Send "+{Delete}"
        else
            Send "^+{Backspace}"
    } else {
        ; Cmd+Backspace
        if WinActive("ahk_group Explorer")
            Send "{Delete}"
        else
            Send "+{Home}{Delete}"
    }
}

; --- BRACKETS ---
*^[::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}"
    else if WinActive("ahk_group Editors")
        Send "^!{Left}"
    else
        Send "^["
}

*^]::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}"
    else if WinActive("ahk_group Editors")
        Send "^!{Right}"
    else
        Send "^]"
}

; --- ACTIONS ---
^c:: Send WinActive("ahk_group Terminals") ? "^+c" : "^c"
^v:: Send WinActive("ahk_group Terminals") ? "^+v" : "^v"

^f::
{
    if WinActive("ahk_group Terminals")
        Send "^+f"
    else if WinActive("ahk_group Explorer")
        Send "^e"
    else
        Send "^f"
}

^+n::
{
    if WinActive("ahk_group Explorer")
        Send "^+n"
    else if WinActive("ahk_group Editors")
        Send "^+n"
    else
        Send "^+n"
}

; --- BROWSER FIXES ---
^i:: Send WinActive("ahk_group Explorer") ? "!{Enter}" : "^i"
^!i:: Send WinActive("ahk_group Browsers") ? "{F12}" : "^!i"
^+j:: Send WinActive("ahk_group Browsers") ? "^j" : "^+j"
^y:: Send WinActive("ahk_group Browsers") ? "^h" : "^y"

; --- SYSTEM ---
^q::Send "!{F4}"
^m::WinMinimize "A"
^,::Send "^!s"
^Space::Send "^{Esc}"
LCtrl & Tab::AltTab
^!Esc::Send "^+{Esc}"

; Screenshots
^+3::Send "{PrintScreen}"
^+4::
{
    SendInput "{LCtrl Up}"
    SendInput "#+s"
    return
}

; --- ALT NAVIGATION ---
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; --- F-KEYS & MISC ---
F3::Send "#{Tab}"
F4::Send "^{Esc}"
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"
Enter:: Send WinActive("ahk_group Explorer") ? "{F2}" : "{Enter}"

; Hardware
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"