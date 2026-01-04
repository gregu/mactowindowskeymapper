; ==============================================================================
; MAC OS ULTIMATE V28 (FINAL STABLE - STRICTLY SORTED)
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
; 1. MODIFIERS (Physical Remap)
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
; 2. WIN KEY OVERRIDES (System Killers & IntelliJ)
; ==============================================================================
; All triggers starting with $# (Physical Win Key). Sorted Alphabetically/Numerically.

$#1::Send WinActive("ahk_group Editors") ? "!1" : "#1"
$#7::Send WinActive("ahk_group Editors") ? "!7" : "#7"
$#9::Send WinActive("ahk_group Editors") ? "!9" : "#9"
$#`::Send WinActive("ahk_group Editors") ? "!{F12}" : "#{`}"
$#/::Send WinActive("ahk_group Editors") ? "^/" : "#/"

$#a::Send "^a"   ; Action Center -> Select All
$#b::Send WinActive("ahk_group Editors") ? "^b" : "#b"
$#c::Send "^c"   ; Copilot -> Copy
$#d::Send WinActive("ahk_group Editors") ? "^d" : "#d"
$#e::Send "^e"   ; Explorer -> Recent Files
$#f::Send "^f"   ; Feedback -> Find
$#+f::Send "^+f" ; WebSearch -> Find in Path
$#l::Send "^l"   ; Lock -> Address Bar
$#r::Send "^r"   ; Run -> Refresh/Replace
$#s::Send "^s"   ; Search -> Save
$#t::Send "^t"   ; Taskbar -> New Tab
$#v::Send "^v"   ; Clipboard -> Paste
$#x::Send "^x"   ; WinX -> Cut
$#z::Send "^z"   ; Undo
$#+z::Send "^+z" ; Redo

; ==============================================================================
; 3. CTRL KEY DISPATCHER (Physical Cmd)
; ==============================================================================
; All triggers starting with ^ (Logical Ctrl / Physical Cmd).

^Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "{Delete}"
    else
        Send "+{Home}{Delete}"
}

^+Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "+{Delete}"
    else
        Send "^+{Backspace}"
}

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

^i:: Send WinActive("ahk_group Explorer") ? "!{Enter}" : "^i"
^!i:: Send WinActive("ahk_group Browsers") ? "{F12}" : "^!i"

^+j:: Send WinActive("ahk_group Browsers") ? "^j" : "^+j"

^n:: Send "^n" ; Universal (Handled by LWin map, explicit here for clarity)

^+n::
{
    if WinActive("ahk_group Explorer")
        Send "^+n"
    else if WinActive("ahk_group Editors")
        Send "^+n"
    else
        Send "^+n"
}

^y:: Send WinActive("ahk_group Browsers") ? "^h" : "^y"

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

; --- Navigation (Arrows) ---

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

; --- Selection (Shift + Arrows) ---
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"
+^Left::Send "+{Home}"
+^Right::Send "+{End}"

; --- Brackets ---
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

; ==============================================================================
; 4. ALT / OPTION KEY DISPATCHER
; ==============================================================================

!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; ==============================================================================
; 5. FUNCTION KEYS & MISC
; ==============================================================================

Enter:: Send WinActive("ahk_group Explorer") ? "{F2}" : "{Enter}"

; F-Keys (For Standard Mode)
F3::Send "#{Tab}"
F4::Send "^{Esc}"
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; Hardware Fixes
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend