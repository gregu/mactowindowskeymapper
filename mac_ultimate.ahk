; ==============================================================================
; MAC OS ULTIMATE V29 (COLLAPSED LOGIC - NO DUPLICATES POSSIBLE)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

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
; 1. SYSTEM KILLERS (WIN KEYS)
; ==============================================================================
$#c::Send "^c"
$#f::Send "^f"
$#+f::Send "^+f"
$#r::Send "^r"
$#e::Send "^e"
$#a::Send "^a"
$#s::Send "^s"
$#t::Send "^t"
$#v::Send "^v"
$#x::Send "^x"
$#z::Send "^z"
$#+z::Send "^+z"
$#l::Send "^l"

; IntelliJ / Editor Overrides for Win-Keys
$#1::Send WinActive("ahk_group Editors") ? "!1" : "#1"
$#7::Send WinActive("ahk_group Editors") ? "!7" : "#7"
$#9::Send WinActive("ahk_group Editors") ? "!9" : "#9"
$#`::Send WinActive("ahk_group Editors") ? "!{F12}" : "#{`}"
$#/::Send WinActive("ahk_group Editors") ? "^/" : "#/"
$#b::Send WinActive("ahk_group Editors") ? "^b" : "#b"
$#d::Send WinActive("ahk_group Editors") ? "^d" : "#d"

; ==============================================================================
; 2. MODIFIERS
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
; 3. UNIFIED DISPATCHER (Merged Hotkeys)
; ==============================================================================

; --- ARROWS (HANDLES BOTH NORMAL AND SHIFT+ARROW) ---
; Zamiast definiować ^Up i +^Up osobno, robimy to raz.

*^Up::
{
    if GetKeyState("Shift", "P") {
        ; SHIFT + CMD + UP
        Send "+^{Home}" ; Select to top
    } else {
        ; CMD + UP
        if WinActive("ahk_group Explorer")
            SendInput "{LCtrl Up}!{Up}"   ; Parent Folder
        else
            Send "^{Home}"                ; Go to top
    }
}

*^Down::
{
    if GetKeyState("Shift", "P") {
        ; SHIFT + CMD + DOWN
        Send "+^{End}" ; Select to bottom
    } else {
        ; CMD + DOWN
        if WinActive("ahk_group Explorer")
            SendInput "{LCtrl Up}{Enter}" ; Open
        else
            Send "^{End}"                 ; Go to bottom
    }
}

*^Left::
{
    if GetKeyState("Shift", "P") {
        ; SHIFT + CMD + LEFT
        Send "+{Home}" ; Select to start
    } else {
        ; CMD + LEFT
        if WinActive("ahk_group Explorer")
            SendInput "{LCtrl Up}!{Left}" ; Back
        else
            Send "{Home}"                 ; Go to start
    }
}

*^Right::
{
    if GetKeyState("Shift", "P") {
        ; SHIFT + CMD + RIGHT
        Send "+{End}" ; Select to end
    } else {
        ; CMD + RIGHT
        if WinActive("ahk_group Explorer")
            SendInput "{LCtrl Up}!{Right}" ; Forward
        else
            Send "{End}"                   ; Go to end
    }
}

; --- BACKSPACE ---
*^Backspace::
{
    if GetKeyState("Shift", "P") {
        ; CMD + SHIFT + BACKSPACE
        if WinActive("ahk_group Explorer")
            Send "+{Delete}"
        else
            Send "^+{Backspace}"
    } else {
        ; CMD + BACKSPACE
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

^i:: Send WinActive("ahk_group Explorer") ? "!{Enter}" : "^i"
^!i:: Send WinActive("ahk_group Browsers") ? "{F12}" : "^!i"
^+j:: Send WinActive("ahk_group Browsers") ? "^j" : "^+j"
^y:: Send WinActive("ahk_group Browsers") ? "^h" : "^y"

; --- SYSTEM & MISC ---
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

; Alt Navigation
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; F-Keys
F3::Send "#{Tab}"
F4::Send "^{Esc}"
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"
Enter:: Send WinActive("ahk_group Explorer") ? "{F2}" : "{Enter}"

; Mouse / Hardware
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend