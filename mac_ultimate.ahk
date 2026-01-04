; ==============================================================================
; MAC OS ULTIMATE V23 (LOGIC DISPATCH ARCHITECTURE)
; ==============================================================================
; This version solves "Duplicate Hotkey" errors by defining hotkeys ONCE
; and using internal logic (if/else) to decide what they do based on the active window.
; ==============================================================================

#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

; MASK KEY
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
; SECTION 1: SYSTEM SHORTCUT KILLERS (GLOBAL)
; ==============================================================================
; These run everywhere to block Windows native behaviors.

$#c::Send "^c"          ; Copilot Block
$#f::Send "^f"          ; Feedback Hub Block
$#+f::Send "^+f"        ; Web Search Block
$#r::Send "^r"          ; Run Block
$#e::Send "^e"          ; Explorer Block
$#a::Send "^a"          ; Action Center Block
$#s::Send "^s"          ; Search Block
$#v::Send "^v"          ; Clipboard Block
$#x::Send "^x"          ; Win+X Block
$#z::Send "^z"
$#+z::Send "^+z"

; ==============================================================================
; SECTION 2: CORE REMAPPING (CMD <-> CTRL)
; ==============================================================================

; --- COMMAND (LWin) -> CONTROL ---
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; --- CONTROL (LCtrl) -> WIN (Smart Logic) ---
; In Terminals: Acts as normal Ctrl (for SIGINT).
; Elsewhere: Acts as Win Key (but blocks Start Menu on tap).

*LCtrl::
{
    if WinActive("ahk_group Terminals") {
        Send "{Blind}{LCtrl DownR}"
    } else {
        Send "{Blind}{LWin DownR}"
    }
}

*LCtrl Up::
{
    if WinActive("ahk_group Terminals") {
        Send "{Blind}{LCtrl Up}"
    } else {
        Send "{Blind}{LWin Up}"
        if (A_PriorKey = "LCtrl")
            Send "{Blind}{vkE8}"
    }
}

; ==============================================================================
; SECTION 3: UNIFIED NAVIGATION & ACTIONS (NO DUPLICATES)
; ==============================================================================

; --- BACKSPACE ---
; Explorer: Delete File
; Global: Delete Line
^Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "{Delete}"
    else
        Send "+{Home}{Delete}"
}

; --- ARROWS (Cmd + Arrows) ---
; Explorer: Navigation / Parent
; Global: Start/End of Line/File

^Up::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}" ; Parent Folder
    else
        Send "^{Home}"              ; Top of File
}

^Down::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}" ; Open Folder
    else
        Send "^{End}"                 ; End of File
}

^Left::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}" ; Back
    else
        Send "{Home}"                 ; Start of Line
}

^Right::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}" ; Forward
    else
        Send "{End}"                   ; End of Line
}

; --- BRACKETS (Cmd + [ / ]) ---
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

; --- ENTER ---
; Only remap in Explorer
Enter::
{
    if WinActive("ahk_group Explorer")
        Send "{F2}"
    else
        Send "{Enter}"
}

; ==============================================================================
; SECTION 4: SPECIFIC APP OVERRIDES
; ==============================================================================

; --- BROWSER SPECIFICS ---
#HotIf WinActive("ahk_group Browsers")
    ^!i::Send "{F12}"
    ^+j::Send "^j"
    ^y::Send "^h"
    ^l::Send "^l"
    ^t::Send "^t"
    ^+t::Send "^+t"
#HotIf

; --- EXPLORER SPECIFICS ---
#HotIf WinActive("ahk_group Explorer")
    ^+Backspace::Send "+{Delete}"
    ^n::Send "^n"
    ^+n::Send "^+n"
    ^i::Send "!{Enter}"
    ^+f::Send "^e"
#HotIf

; --- TERMINAL SPECIFICS ---
#HotIf WinActive("ahk_group Terminals")
    ^c::Send "^+c"
    ^v::Send "^+v"
    ^f::Send "^+f"
#HotIf

; --- EDITOR SPECIFICS (INTELLIJ) ---
#HotIf WinActive("ahk_group Editors")
    $#1::Send "!1"
    $#7::Send "!7"
    $#9::Send "!9"
    $#`::Send "!{F12}"
    $#/::Send "^/"
    $#d::Send "^d"
#HotIf

; ==============================================================================
; SECTION 5: GLOBAL UTILS & F-KEYS
; ==============================================================================
#HotIf ; GLOBAL

; F-Keys (Standard Mode Fix)
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

; Text Selection (Global)
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Word Navigation
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Mouse
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend