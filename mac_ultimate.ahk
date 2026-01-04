; ==============================================================================
; MAC OS ULTIMATE V21 (Duplicate Fixed & Final Polish)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

; MASK KEY
A_MenuMaskKey := "vkE8"

; --- GROUPS ---
GroupAdd "Editors", "ahk_exe idea64.exe"      ; IntelliJ
GroupAdd "Editors", "ahk_exe Code.exe"        ; VS Code
GroupAdd "Editors", "ahk_exe studio64.exe"    ; Android Studio
GroupAdd "Editors", "ahk_exe pycharm64.exe"
GroupAdd "Editors", "ahk_exe webstorm64.exe"

GroupAdd "Explorer", "ahk_class CabinetWClass"
GroupAdd "Explorer", "ahk_class ExploreWClass"

GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Browsers", "ahk_exe firefox.exe"

GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"
GroupAdd "Terminals", "ahk_exe powershell.exe"
GroupAdd "Terminals", "ahk_exe cmd.exe"

; ==============================================================================
; SECTION 1: SYSTEM SHORTCUT KILLERS (GLOBAL)
; ==============================================================================
; Explicitly kill Windows native shortcuts (Win+F, Win+C, etc.)
; This ensures they don't open System Apps.

$#c::Send "^c"          ; Win+C -> Copy (Kills Copilot)
$#f::Send "^f"          ; Win+F -> Find (Kills Feedback Hub)
$#+f::Send "^+f"        ; Win+Shift+F -> Find in Files (Kills Web Search)
$#r::Send "^r"          ; Win+R -> Refresh/Run
$#e::Send "^e"          ; Win+E -> Recent Files (Kills Explorer)
$#a::Send "^a"          ; Win+A -> Select All (Kills Action Center)
$#s::Send "^s"          ; Win+S -> Save (Kills Search)
$#v::Send "^v"          ; Win+V -> Paste
$#x::Send "^x"          ; Win+X -> Cut
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo

; ==============================================================================
; SECTION 2: HYBRID F-KEYS (MX KEYS SETUP)
; ==============================================================================
; REQUIREMENT: Enable "Standard F-Keys" on your keyboard (Fn+Esc).
; AHK will then translate them back to Media Keys where needed.

F3::Send "#{Tab}"       ; F3 -> Mission Control
F4::Send "^{Esc}"       ; F4 -> Launchpad (Start)

; Restore Media Keys
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; ==============================================================================
; SECTION 3: CORE REMAPPING
; ==============================================================================
; Cmd (LWin) -> Ctrl
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; Ctrl (LCtrl) -> Win (With Start Menu Block)
*LCtrl::Send "{Blind}{LWin DownR}"
*LCtrl Up::
{
    Send "{Blind}{LWin Up}"
    if (A_PriorKey = "LCtrl")
        Send "{Blind}{vkE8}"
}

; ==============================================================================
; SECTION 4: SYSTEM SHORTCUTS
; ==============================================================================
^Space::Send "^{Esc}"       ; Start Menu
LCtrl & Tab::AltTab         ; Alt-Tab
^q::Send "!{F4}"            ; Quit
^m::WinMinimize "A"         ; Minimize
^!Esc::Send "^+{Esc}"       ; Task Manager
^,::Send "^!s"              ; Settings

; Screenshots
^+3::Send "{PrintScreen}"
^+4::
{
    SendInput "{LCtrl Up}"
    SendInput "#+s"
    return
}

; ISO Key (Paragraph/PlusMinus)
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

; ==============================================================================
; SECTION 5: INTELLIJ & EDITORS
; ==============================================================================
#HotIf WinActive("ahk_group Editors")
    ; Extra redundancy for IntelliJ
    $#f::Send "^f"
    $#+f::Send "^+f"
    $#r::Send "^r"
    $#+r::Send "^+r"
    
    ; Specific Tools
    $#1::Send "!1"         ; Project
    $#7::Send "!7"         ; Structure
    $#9::Send "!9"         ; Git
    $#`::Send "!{F12}"     ; Terminal
    $#/::Send "^/"         ; Comment
    $#d::Send "^d"         ; Duplicate
#HotIf

; ==============================================================================
; SECTION 6: EXPLORER
; ==============================================================================
#HotIf WinActive("ahk_group Explorer")
    Enter::Send "{F2}"
    
    ; Open in Same Window
    ^Down::
    {
        SendInput "{LCtrl Up}{Enter}"
        return
    }
    
    ; Parent Folder
    ^Up::
    {
        SendInput "{LCtrl Up}!{Up}"
        return
    }
    
    ; Navigation
    ^[::SendInput "{LCtrl Up}!{Left}"
    ^]::SendInput "{LCtrl Up}!{Right}"
    ^Left::SendInput "{LCtrl Up}!{Left}"
    ^Right::SendInput "{LCtrl Up}!{Right}"
    
    ; File Ops
    ^Backspace::Send "{Delete}"
    ^+Backspace::Send "+{Delete}"
    ^n::Send "^n"
    ^+n::Send "^+n"
    ^i::Send "!{Enter}"
#HotIf

; ==============================================================================
; SECTION 7: BROWSERS
; ==============================================================================
#HotIf WinActive("ahk_group Browsers")
    ^!i::Send "{F12}"
    ^+j::Send "^j"
    ^y::Send "^h"
    ^l::Send "^l"
#HotIf

; ==============================================================================
; SECTION 8: GLOBAL TEXT & TERMINALS
; ==============================================================================
; Terminals
#HotIf WinActive("ahk_group Terminals")
    ^c::Send "^+c"
    ^v::Send "^+v"
    ^f::Send "^+f"
    LCtrl::LCtrl
#HotIf

; Global Text Nav (Always Active)
^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"
^Backspace::Send "+{Home}{Delete}"

LCtrl & LButton::Click "Right"
RAlt::RAlt

F8::Suspend