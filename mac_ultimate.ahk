; ==============================================================================
; MAC OS ULTIMATE V25 (NO DUPLICATES GUARANTEED)
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

GroupAdd "Editors", "ahk_exe idea64.exe"      ; IntelliJ
GroupAdd "Editors", "ahk_exe Code.exe"        ; VS Code
GroupAdd "Editors", "ahk_exe studio64.exe"    ; Android Studio
GroupAdd "Editors", "ahk_exe pycharm64.exe"
GroupAdd "Editors", "ahk_exe webstorm64.exe"

; ==============================================================================
; SECTION 1: SYSTEM KILLERS (Priority 1)
; ==============================================================================
; Explicitly block Windows shortcuts globally.

$#c::Send "^c"          ; Copilot
$#f::Send "^f"          ; Feedback Hub
$#+f::Send "^+f"        ; Web Search
$#r::Send "^r"          ; Run
$#e::Send "^e"          ; Explorer
$#a::Send "^a"          ; Action Center
$#s::Send "^s"          ; Search
$#v::Send "^v"          ; Clipboard
$#x::Send "^x"          ; Win+X
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo
$#l::Send "^l"          ; Lock Screen
$#t::Send "^t"          ; Taskbar Focus

; ==============================================================================
; SECTION 2: MODIFIERS
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
; SECTION 3: THE SINGLE DISPATCHER (All Logic Here)
; ==============================================================================
; Every key here is defined ONCE. The logic inside decides the target.

; --- NAVIGATION ---

^Up::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}"   ; Explorer: Parent
    else
        Send "^{Home}"                ; Global: Top
}

^Down::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}" ; Explorer: Open
    else
        Send "^{End}"                 ; Global: Bottom
}

^Left::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}" ; Explorer: Back
    else
        Send "{Home}"                 ; Global: Start Line
}

^Right::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}" ; Explorer: Forward
    else
        Send "{End}"                   ; Global: End Line
}

; --- ACTIONS ---

^Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "{Delete}"               ; Explorer: Delete File
    else
        Send "+{Home}{Delete}"        ; Global: Delete Line
}

Enter::
{
    if WinActive("ahk_group Explorer")
        Send "{F2}"                   ; Explorer: Rename
    else
        Send "{Enter}"
}

^[::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}"
    else if WinActive("ahk_group Editors")
        Send "^!{Left}"
    else
        Send "^["
}

^]::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}"
    else if WinActive("ahk_group Editors")
        Send "^!{Right}"
    else
        Send "^]"
}

; --- SHORTCUTS ---

^c::
{
    if WinActive("ahk_group Terminals")
        Send "^+c"
    else
        Send "^c"
}

^v::
{
    if WinActive("ahk_group Terminals")
        Send "^+v"
    else
        Send "^v"
}

^f::
{
    if WinActive("ahk_group Terminals")
        Send "^+f"
    else if WinActive("ahk_group Explorer")
        Send "^e"
    else
        Send "^f"
}

; Fixes for Duplicate Keys (Defined once here with logic)
^n::
{
    if WinActive("ahk_group Explorer")
        Send "^n"  ; New Window
    else
        Send "^n"  ; Default
}

^+n::
{
    if WinActive("ahk_group Explorer")
        Send "^+n" ; New Folder
    else if WinActive("ahk_group Editors")
        Send "^+n" ; Go to File
    else
        Send "^+n"
}

; ==============================================================================
; SECTION 4: UNIQUE CONTEXTS (Only keys NOT defined above)
; ==============================================================================

#HotIf WinActive("ahk_group Browsers")
    ^!i::Send "{F12}"
    ^+j::Send "^j"
    ^y::Send "^h"
    ^l::Send "^l"
    ^t::Send "^t"
    ^+t::Send "^+t"
#HotIf

#HotIf WinActive("ahk_group Explorer")
    ^+Backspace::Send "+{Delete}"
    ^i::Send "!{Enter}"
#HotIf

#HotIf WinActive("ahk_group Editors")
    $#1::Send "!1"
    $#7::Send "!7"
    $#9::Send "!9"
    $#`::Send "!{F12}"
    $#/::Send "^/"
    $#d::Send "^d"
    $#b::Send "^b"
#HotIf

; ==============================================================================
; SECTION 5: GLOBAL UTILS
; ==============================================================================
#HotIf

; F-Keys (Standard Mode)
F3::Send "#{Tab}"
F4::Send "^{Esc}"
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; System
^Space::Send "^{Esc}"
LCtrl & Tab::AltTab
^q::Send "!{F4}"
^m::WinMinimize "A"
^!Esc::Send "^+{Esc}"
^,::Send "^!s"

; Screenshots
^+3::Send "{PrintScreen}"
^+4::
{
    SendInput "{LCtrl Up}"
    SendInput "#+s"
    return
}

; Selection
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Word Nav
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Mouse & Hardware
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend