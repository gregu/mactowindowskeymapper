; ==============================================================================
; MAC OS ULTIMATE V22 (Zero Duplicates & Clean Logic)
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
; SECTION 1: GLOBAL SYSTEM KILLERS (Priority 1)
; ==============================================================================
; These override Windows Native shortcuts immediately.
; Defined ONCE here to prevent "Duplicate Hotkey" errors.
; These apply to IntelliJ, Explorer, and Desktop alike.

$#c::Send "^c"          ; Win+C -> Copy (Kills Copilot)
$#f::Send "^f"          ; Win+F -> Find (Kills Feedback Hub)
$#+f::Send "^+f"        ; Win+Shift+F -> Find in Files (Kills Web Search)
$#r::Send "^r"          ; Win+R -> Refresh/Run (Kills Run)
$#e::Send "^e"          ; Win+E -> Recent Files (Kills Explorer launch)
$#a::Send "^a"          ; Win+A -> Select All (Kills Action Center)
$#s::Send "^s"          ; Win+S -> Save (Kills Search)
$#v::Send "^v"          ; Win+V -> Paste (Kills Clipboard History)
$#x::Send "^x"          ; Win+X -> Cut (Kills Quick Link Menu)
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo

; ==============================================================================
; SECTION 2: HYBRID F-KEYS (Logitech MX Fix)
; ==============================================================================
; Prerequisite: Enable "Standard F-Keys" (Fn+Esc) on keyboard.

F3::Send "#{Tab}"       ; F3 -> Mission Control
F4::Send "^{Esc}"       ; F4 -> Launchpad (Start)

; Restore Media Keys (Mapping F7-F12 back to Media functions)
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

; Ctrl (LCtrl) -> Win
*LCtrl::Send "{Blind}{LWin DownR}"
*LCtrl Up::
{
    Send "{Blind}{LWin Up}"
    if (A_PriorKey = "LCtrl")
        Send "{Blind}{vkE8}"
}

; Key under ESC (ISO Layout)
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

; ==============================================================================
; SECTION 4: CONTEXT - EXPLORER
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
    
    ; Delete Files
    ^Backspace::Send "{Delete}"
    ^+Backspace::Send "+{Delete}"
    
    ; New
    ^n::Send "^n"
    ^+n::Send "^+n"
    ^i::Send "!{Enter}" ; Properties
    
    ; Override the Global Win+Shift+F for Explorer specifically (Optional)
    ; If you want Win+Shift+F to focus Search Box in Explorer:
    ^+f::Send "^e"
#HotIf

; ==============================================================================
; SECTION 5: CONTEXT - BROWSERS
; ==============================================================================
#HotIf WinActive("ahk_group Browsers")
    ^!i::Send "{F12}"      ; DevTools
    ^+j::Send "^j"         ; Downloads
    ^y::Send "^h"          ; History
    ^l::Send "^l"          ; Address Bar
#HotIf

; ==============================================================================
; SECTION 6: CONTEXT - EDITORS (IntelliJ / VS Code)
; ==============================================================================
#HotIf WinActive("ahk_group Editors")
    ; NOTE: Win+F, Win+C etc are handled in Section 1 (Global).
    ; Here we map things that don't conflict with System keys but need specific Alt mapping.
    
    $#1::Send "!1"         ; Cmd+1 -> Alt+1 (Project)
    $#7::Send "!7"         ; Cmd+7 -> Alt+7 (Structure)
    $#9::Send "!9"         ; Cmd+9 -> Alt+9 (Git)
    $#`::Send "!{F12}"     ; Cmd+Backtick -> Terminal
    $#/::Send "^/"         ; Comment
    $#d::Send "^d"         ; Duplicate
    $#b::Send "^b"         ; Declaration
#HotIf

; ==============================================================================
; SECTION 7: CONTEXT - TERMINALS
; ==============================================================================
#HotIf WinActive("ahk_group Terminals")
    ^c::Send "^+c"
    ^v::Send "^+v"
    ^f::Send "^+f"
    LCtrl::LCtrl
#HotIf

; ==============================================================================
; SECTION 8: GLOBAL FALLBACKS (Must be last)
; ==============================================================================
#HotIf ; Reset context to Global

; System
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

; Text Navigation (Global)
^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Word Navigation
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Delete Line (Global)
; This is safe here because Explorer has its own specific definition in Section 4
^Backspace::Send "+{Home}{Delete}"

; Mouse
LCtrl & LButton::Click "Right"
RAlt::RAlt

F8::Suspend