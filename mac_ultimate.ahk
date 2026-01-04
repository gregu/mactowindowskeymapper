; ==============================================================================
; MAC OS ULTIMATE EXPERIENCE FOR WINDOWS (NO-ADMIN / PORTABLE)
; Optimized for: Logitech MX Keys for Mac
; Author: [Twoje Imię/GitHub Username]
; ==============================================================================

#NoEnv
#SingleInstance Force
SendMode Input
SetTitleMatchMode 2

; --- GROUP DEFINITIONS: TERMINALS ---
; Apps where Ctrl should behave natively (SIGINT) and Copy/Paste is specific.
GroupAdd, Terminals, ahk_exe WindowsTerminal.exe
GroupAdd, Terminals, ahk_exe powershell.exe
GroupAdd, Terminals, ahk_exe cmd.exe
GroupAdd, Terminals, ahk_exe mintty.exe ; Git Bash
GroupAdd, Terminals, ahk_class ConsoleWindowClass

; ==============================================================================
; SECTION 1: TERMINAL / WSL / VIM MODE
; ==============================================================================
#IfWinActive ahk_group Terminals

    ; 1. Revert Physical Keys to Native Windows
    ; Necessary because global swap (LWin::LCtrl) would break Ctrl+C (SIGINT)
    LCtrl::LCtrl
    LWin::LWin

    ; 2. Mac-like Copy/Paste (Thumb usage)
    ; Physical Cmd+C -> Ctrl+Shift+C (Standard Terminal Copy)
    LWin & c::Send ^+c
    ; Physical Cmd+V -> Ctrl+Shift+V (Standard Terminal Paste)
    LWin & v::Send ^+v

    ; 3. Tab Management & Search
    LWin & t::Send ^+t ; New Tab
    LWin & w::Send ^+w ; Close Tab
    LWin & f::Send ^+f ; Find

    ; 4. Prevent Start Menu on standalone Cmd press
    LWin::Return

#IfWinActive

; ==============================================================================
; SECTION 2: GLOBAL GUI MODE (Browser, IDEs, Explorer)
; ==============================================================================

; --- A. MAIN KEY SWAP (Command <-> Control) ---
; Physical Command (LWin) acts as Control
LWin::LCtrl
; Physical Control (LCtrl) acts as Windows Key
LCtrl::LWin

; --- B. TEXT NAVIGATION (Mac Style) ---
; Cmd + Arrows -> Home/End
^Left::Send {Home}
^Right::Send {End}
^Up::Send ^{Home}
^Down::Send ^{End}

; Alt (Option) + Arrows -> Ctrl + Arrows (Jump words)
!Left::Send ^{Left}
!Right::Send ^{Right}

; --- C. WINDOW & SYSTEM MANAGEMENT ---
; Cmd + Tab -> App Switcher (Alt+Tab)
LCtrl & Tab::AltTab

; Cmd + Space -> Start Menu (Spotlight equivalent)
^Space::Send ^{Esc}

; Cmd + Q -> Close Window (Alt+F4)
^q::Send !{F4}

; Cmd + Backspace -> Delete line/file
^Backspace::Send +{Home}{Delete}

; --- D. MOUSE EMULATION ---
; Physical Ctrl + Click -> Right Click
; (Since LCtrl is mapped to LWin globally, we listen for LWin/Super)
#LButton::Click Right

; --- E. SCREENSHOTS ---
; Cmd + Shift + 3 -> PrintScreen (Full)
^+3::Send {PrintScreen}
; Cmd + Shift + 4 -> Snipping Tool (Selection)
^+4::Send #+s

; ==============================================================================
; SECTION 3: EXCEPTIONS & SAFETY
; ==============================================================================

; Preserve Right Alt (Option) for special characters (Polish ą, ę, etc.)
RAlt::RAlt

; EMERGENCY SUSPEND SWITCH
; Press F8 to toggle script on/off
F8::Suspend