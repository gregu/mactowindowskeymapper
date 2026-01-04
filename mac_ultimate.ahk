; ==============================================================================
; MAC OS ULTIMATE V24 (LOGIC DISPATCH - 100% STABLE)
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
; SECTION 1: SYSTEM KILLERS (Global Overrides)
; ==============================================================================
; These run everywhere to block Windows native behaviors.

$#c::Send "^c"          ; Kills Copilot
$#f::Send "^f"          ; Kills Feedback Hub
$#+f::Send "^+f"        ; Kills Web Search
$#r::Send "^r"          ; Kills Run
$#e::Send "^e"          ; Kills Explorer Launch
$#a::Send "^a"          ; Kills Action Center
$#s::Send "^s"          ; Kills Search
$#v::Send "^v"          ; Kills Clipboard History
$#x::Send "^x"          ; Kills Win+X Menu
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo
$#l::Send "^l"          ; Kills Lock Screen (careful!)
$#t::Send "^t"          ; Kills Taskbar Focus

; ==============================================================================
; SECTION 2: CORE REMAPPING
; ==============================================================================

; --- CMD (LWin) -> CTRL ---
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; --- CTRL (LCtrl) -> WIN ---
*LCtrl::
{
    if WinActive("ahk_group Terminals") {
        Send "{Blind}{LCtrl DownR}" ; Keep Ctrl in Terminals
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
; SECTION 3: THE MEGA DISPATCHER (All Navigation/Action Keys)
; ==============================================================================
; This section handles context-sensitive keys to avoid duplicates.

; --- BACKSPACE ---
^Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "{Delete}"               ; Explorer: Delete File
    else
        Send "+{Home}{Delete}"        ; Global: Delete Line
}

; --- ENTER ---
Enter::
{
    if WinActive("ahk_group Explorer")
        Send "{F2}"                   ; Explorer: Rename
    else
        Send "{Enter}"                ; Global: Enter
}

; --- ARROW UP ---
^Up::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}"   ; Explorer: Parent Folder
    else
        Send "^{Home}"                ; Global: Top of File
}

; --- ARROW DOWN ---
^Down::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}" ; Explorer: Open (Same Window)
    else
        Send "^{End}"                 ; Global: End of File
}

; --- ARROW LEFT ---
^Left::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}" ; Explorer: Back
    else
        Send "{Home}"                 ; Global: Start of Line
}

; --- ARROW RIGHT ---
^Right::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}" ; Explorer: Forward
    else
        Send "{End}"                   ; Global: End of Line
}

; --- BRACKET LEFT ([) ---
^[::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}"
    else if WinActive("ahk_group Editors")
        Send "^!{Left}"
    else
        Send "^["
}

; --- BRACKET RIGHT (]) ---
^]::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}"
    else if WinActive("ahk_group Editors")
        Send "^!{Right}"
    else
        Send "^]"
}

; --- COPY (Cmd+C) ---
^c::
{
    if WinActive("ahk_group Terminals")
        Send "^+c"
    else
        Send "^c"
}

; --- PASTE (Cmd+V) ---
^v::
{
    if WinActive("ahk_group Terminals")
        Send "^+v"
    else
        Send "^v"
}

; --- FIND (Cmd+F) ---
^f::
{
    if WinActive("ahk_group Terminals")
        Send "^+f"
    else if WinActive("ahk_group Explorer")
        Send "^e" ; Search Box in Explorer
    else
        Send "^f"
}

; --- NEW TAB/WINDOW (Cmd+N) ---
^n::
{
    if WinActive("ahk_group Explorer")
        Send "^n"
    else
        Send "^n"
}

; --- NEW FOLDER/FILE (Cmd+Shift+N) ---
^+n::
{
    if WinActive("ahk_group Explorer")
        Send "^+n"
    else if WinActive("ahk_group Editors")
        Send "^+n" ; Go to File
    else
        Send "^+n"
}

; ==============================================================================
; SECTION 4: BROWSER SPECIFICS
; ==============================================================================
#HotIf WinActive("ahk_group Browsers")
    ^!i::Send "{F12}"      ; DevTools
    ^+j::Send "^j"         ; Downloads
    ^y::Send "^h"          ; History
    ^l::Send "^l"          ; Address Bar
    ^t::Send "^t"          ; New Tab
    ^+t::Send "^+t"        ; Reopen Tab
#HotIf

; ==============================================================================
; SECTION 5: EDITOR SPECIFICS (IntelliJ / VS Code)
; ==============================================================================
#HotIf WinActive("ahk_group Editors")
    ; Alt mapping for tool windows
    $#1::Send "!1"         ; Project
    $#7::Send "!7"         ; Structure
    $#9::Send "!9"         ; Git
    $#`::Send "!{F12}"     ; Terminal
    $#/::Send "^/"         ; Comment
    $#d::Send "^d"         ; Duplicate
    $#b::Send "^b"         ; Declaration
#HotIf

; ==============================================================================
; SECTION 6: GLOBAL UTILS & F-KEYS
; ==============================================================================
#HotIf ; GLOBAL SCOPE

; F-Keys (Standard Mode Fix)
F3::Send "#{Tab}"       ; Mission Control
F4::Send "^{Esc}"       ; Launchpad
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; System
^Space::Send "^{Esc}"   ; Start Menu
LCtrl & Tab::AltTab     ; Alt-Tab
^q::Send "!{F4}"        ; Quit
^m::WinMinimize "A"     ; Minimize
^!Esc::Send "^+{Esc}"   ; Task Manager
^,::Send "^!s"          ; Settings

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

; Mouse & Hardware
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend