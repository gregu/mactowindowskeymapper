; ==============================================================================
; MAC OS ULTIMATE EXPERIENCE V17 (Structure Fixed)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

; MASK KEY: Prevents Start Menu interference
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

; ==============================================================================
; SECTION 1: CORE REMAPPING (HARDWARE LEVEL)
; ==============================================================================

; Cmd (LWin) -> Ctrl
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; Ctrl (LCtrl) -> Win (Blocked Start Menu)
*LCtrl::Send "{Blind}{LWin DownR}"
*LCtrl Up::
{
    Send "{Blind}{LWin Up}"
    if (A_PriorKey = "LCtrl")
        Send "{Blind}{vkE8}"
}

; Key under ESC (ISO Layout: Paragraph/Plus-Minus)
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

; ==============================================================================
; SECTION 2: CONTEXT SPECIFIC (EXPLORER / FINDER)
; ==============================================================================
#HotIf WinActive("ahk_group Explorer")

    ; Rename
    Enter::Send "{F2}"
    
    ; Open Folder (Same Window)
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

    ; Navigation (Back/Forward)
    ^[::SendInput "{LCtrl Up}!{Left}"
    ^]::SendInput "{LCtrl Up}!{Right}"
    ^Left::SendInput "{LCtrl Up}!{Left}"
    ^Right::SendInput "{LCtrl Up}!{Right}"

    ; Delete (Specific to Explorer)
    ^Backspace::Send "{Delete}"
    ^+Backspace::Send "+{Delete}"

    ; Properties / New Item
    ^i::Send "!{Enter}"
    ^n::Send "^n"
    ^+n::Send "^+n"
    
#HotIf

; ==============================================================================
; SECTION 3: CONTEXT SPECIFIC (BROWSERS)
; ==============================================================================
#HotIf WinActive("ahk_group Browsers")
    
    ^l::Send "^l"          ; Address Bar
    ^t::Send "^t"          ; New Tab
    ^+t::Send "^+t"        ; Reopen Tab
    ^w::Send "^w"          ; Close Tab
    ^r::Send "^r"          ; Reload
    ^+r::Send "^+{F5}"     ; Hard Reload
    
    ; Zoom
    ^=::Send "^{=}"
    ^-::Send "^{-}"
    ^0::Send "^0"
    
    ; History/Downloads
    ^y::Send "^h"
    ^+j::Send "^j"
    
    ; DevTools (Cmd+Opt+I -> F12)
    ^!i::Send "{F12}"

#HotIf

; ==============================================================================
; SECTION 4: CONTEXT SPECIFIC (TERMINALS)
; ==============================================================================
#HotIf WinActive("ahk_group Terminals")
    ^c::Send "^+c"
    ^v::Send "^+v"
    ^f::Send "^+f"
    LCtrl::LCtrl ; Restore physical Ctrl for SIGINT
#HotIf

; ==============================================================================
; SECTION 5: GLOBAL SHORTCUTS (INTELLIJ / SYSTEM / EDITORS)
; ==============================================================================
; These run everywhere unless overridden above.
#HotIf

; --- SYSTEM ---
^Space::Send "^{Esc}"           ; Cmd+Space -> Start Menu
LCtrl & Tab::AltTab             ; Cmd+Tab -> Alt+Tab
F3::Send "#{Tab}"               ; Mission Control
^q::Send "!{F4}"                ; Quit
^m::WinMinimize "A"             ; Minimize
^h::WinMinimize "A"             ; Hide
^!Esc::Send "^+{Esc}"           ; Force Quit (Task Manager)
^#q::Send "#l"                  ; Lock Screen
^,::Send "^!s"                  ; Settings (Ctrl+Alt+S)

; --- SCREENSHOTS ---
^+3::Send "{PrintScreen}"       ; Full
^+4::
{
    SendInput "{LCtrl Up}"
    SendInput "#+s"             ; Snipping Tool
    return
}

; --- INTELLIJ / EDITORS BYPASS ---
; We catch these globally to prevent Windows from stealing Win+Key
$^+f::Send "^+f"       ; Find in Path
$^f::Send "^f"         ; Find
$^r::Send "^r"         ; Replace
$^+r::Send "^+r"       ; Replace in Path
$^+n::Send "^+n"       ; Go to File
$^e::Send "^e"         ; Recent Files
$^b::Send "^b"         ; Go to Declaration
$^+a::Send "^+a"       ; Find Action

; --- EDITING & TEXT NAV ---
$^/::Send "^/"         ; Comment
$^d::Send "^d"         ; Duplicate
$^z::Send "^z"         ; Undo
$^+z::Send "^+z"       ; Redo

; Cursor Movement
^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Word Movement (Option+Arrows)
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Delete Line (Cmd+Backspace)
; This is now safely below the Explorer override
^Backspace::Send "+{Home}{Delete}"

; --- MOUSE & MISC ---
LCtrl & LButton::Click "Right"
RAlt::RAlt

F8::Suspend