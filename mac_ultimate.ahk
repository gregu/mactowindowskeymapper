#Requires AutoHotkey v2.0
#SingleInstance Force
SetTitleMatchMode 2

; --- GROUP DEFINITIONS ---
GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"
GroupAdd "Terminals", "ahk_exe powershell.exe"
GroupAdd "Terminals", "ahk_exe cmd.exe"
GroupAdd "Terminals", "ahk_class ConsoleWindowClass"
GroupAdd "Explorer", "ahk_class CabinetWClass"
GroupAdd "Explorer", "ahk_class ExploreWClass"

; ==============================================================================
; MODE 1: TERMINALS (Native Ctrl, Cmd=Copy)
; ==============================================================================
#HotIf WinActive("ahk_group Terminals")
    LCtrl::LCtrl
    LWin::LWin
    LWin & c::Send "^+c"
    LWin & v::Send "^+v"
    LWin & t::Send "^+t"
    LWin & w::Send "^+w"
    LWin & f::Send "^+f"
    LWin::Return
#HotIf

; ==============================================================================
; MODE 2: EXPLORER / FINDER (Enter renames file)
; ==============================================================================
#HotIf WinActive("ahk_group Explorer")
    Enter::Send "{F2}"
    ^Down::Send "{Enter}"
    ^o::Send "{Enter}"
    ^Up::Send "!{Up}"
    ^Left::Send "!{Left}"
    ^Right::Send "!{Right}"
    ^Backspace::Send "{Delete}"
    ^+n::Send "^+n"
#HotIf

; ==============================================================================
; MODE 3: GLOBAL GUI (Standard Apps)
; ==============================================================================
LWin::LCtrl
LCtrl::LWin

^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"
!Left::Send "^{Left}"
!Right::Send "^{Right}"

LCtrl & Tab::AltTab
^Space::Send "^{Esc}"
^q::Send "!{F4}"
^Backspace::Send "+{Home}{Delete}"

#LButton::Click "Right"
^+3::Send "{PrintScreen}"
^+4::Send "#+s"

; Right Alt (Option) remains unchanged for special characters
RAlt::RAlt

; Suspend script with F8
F8::Suspend