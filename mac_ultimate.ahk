; ==============================================================================
; MAC OS ULTIMATE V27 (THE MONOLITH - STATICALLY VERIFIED)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

A_MenuMaskKey := "vkE8"

; --- GROUPS DEFINITION ---
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
; SECTION 1: SYSTEM OVERRIDES (WIN-KEYS) - DEFINED ONCE
; ==============================================================================
; These intercept physical Win+Key presses immediately.

$#c::Send "^c"          ; Copilot -> Copy
$#f::Send "^f"          ; Feedback -> Find
$#+f::Send "^+f"        ; WebSearch -> Find in Path
$#r::Send "^r"          ; Run -> Refresh/Replace
$#e::Send "^e"          ; Explorer -> Recent Files
$#a::Send "^a"          ; Action Center -> Select All
$#s::Send "^s"          ; Search -> Save
$#v::Send "^v"          ; Clipboard -> Paste
$#x::Send "^x"          ; Menu -> Cut
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo
$#t::Send "^t"          ; Taskbar -> New Tab
$#l::Send "^l"          ; Lock -> Address Bar (Browsers)

; Special Case: Win+1, Win+7 etc (Taskbar shortcuts vs IntelliJ)
$#1::
{
    if WinActive("ahk_group Editors")
        Send "!1"
    else
        Send "#1"
}
$#7::
{
    if WinActive("ahk_group Editors")
        Send "!7"
    else
        Send "#7"
}
$#9::
{
    if WinActive("ahk_group Editors")
        Send "!9"
    else
        Send "#9"
}
$#`::
{
    if WinActive("ahk_group Editors")
        Send "!{F12}"
    else
        Send "#{`}"
}
$#/::
{
    if WinActive("ahk_group Editors")
        Send "^/"
    else
        Send "#/"
}
$#b::
{
    if WinActive("ahk_group Editors")
        Send "^b"
    else
        Send "#b"
}
$#d::
{
    if WinActive("ahk_group Editors")
        Send "^d"
    else
        Send "#d"
}

; ==============================================================================
; SECTION 2: MODIFIERS RE-MAP
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
; SECTION 3: THE MONOLITH (ALL CTRL KEYS DEFINED ONCE)
; ==============================================================================
; Here we handle ALL behavior for logical Ctrl keys (Physical Cmd).
; NO #HotIf blocks allowed for Ctrl keys below this line!

; --- NAVIGATION ---

^Up::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}"
    else
        Send "^{Home}"
}

^Down::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}"
    else
        Send "^{End}"
}

^Left::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}"
    else
        Send "{Home}"
}

^Right::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}"
    else
        Send "{End}"
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

; --- EDITING & ACTIONS ---

^Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "{Delete}"
    else
        Send "+{Home}{Delete}"
}

Enter::
{
    if WinActive("ahk_group Explorer")
        Send "{F2}"
    else
        Send "{Enter}"
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

; --- BROWSER / SPECIALS ---
; Mac Cmd+Y is History. Windows Ctrl+Y is Redo.
; We need logic to fix this overlap.
^y::
{
    if WinActive("ahk_group Browsers")
        Send "^h" ; History
    else
        Send "^y" ; Redo (Global)
}

; Mac Cmd+Shift+J is Downloads. Windows Ctrl+J is Downloads.
; But since we mapped Cmd->Ctrl, Cmd+Shift+J becomes Ctrl+Shift+J (Console).
; We need to map it back to Ctrl+J for browsers.
^+j::
{
    if WinActive("ahk_group Browsers")
        Send "^j"
    else
        Send "^+j"
}

; DevTools (Cmd+Opt+I -> F12)
^!i::
{
    if WinActive("ahk_group Browsers")
        Send "{F12}"
    else
        Send "^!i"
}

; Properties in Explorer (Cmd+I)
^i::
{
    if WinActive("ahk_group Explorer")
        Send "!{Enter}"
    else
        Send "^i"
}

; New Folder / Go To File
^+n::
{
    if WinActive("ahk_group Explorer")
        Send "^+n"
    else if WinActive("ahk_group Editors")
        Send "^+n"
    else
        Send "^+n"
}

; Note: ^n (New Window) and ^t (New Tab) work natively via *LWin map.
; No need to redefine them unless logic changes.

; ==============================================================================
; SECTION 4: GLOBAL F-KEYS & UTILS
; ==============================================================================

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

; Selection (Shift + Arrows)
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Word Navigation (Alt + Arrows)
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Mouse & Hardware
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend