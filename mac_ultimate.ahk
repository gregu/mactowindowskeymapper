; ==============================================================================
; MAC OS ULTIMATE V63 (STABLE HYBRID EDITION)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook

; --- POWERTOYS ARCHITECTURE ---
; 1. PowerToys maps Physical Cmd (Thumb) -> Ctrl (^)
; 2. PowerToys maps Physical Ctrl (Corner) -> Win (#)
; 3. Physical Alt remains Alt (!)

; ==============================================================================
; 1. SYSTEM GLOBAL
; ==============================================================================
; Spotlight (PowerToys Run defaults to Alt+Space)
^Space::Send "!{Space}"

; Emoji Picker (Cmd+Ctrl+Space -> Win+.)
; Physical: Ctrl(Thumb) + Win(Corner) + Space -> System sees ^#Space
^#Space::Send "#."

; Force Quit (Cmd+Opt+Esc -> Ctrl+Shift+Esc)
^!Esc::Send "^+{Esc}"

; Lock Screen (Ctrl+Cmd+Q -> Win+L)
; Physical: Win(Corner) + Ctrl(Thumb) + Q -> System sees #^Q
#^q::Send "#l"

; Help (Cmd+Shift+/ -> F1)
^+/::Send "{F1}"

; Show Desktop (Cmd+F3 -> Win+D)
^F3::Send "#d"

; Sleep (Cmd+Opt+Power/Eject) - Safe DllCall
^!SC15E::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

; Screenshots (Cmd+Shift+3/4/5)
^+3::Send "{PrintScreen}"
^+4::Send "#+s"
^+5::Send "#+s"

; ==============================================================================
; 2. FINDER / EXPLORER NAVIGATOR
; ==============================================================================
#HotIf WinActive("ahk_class CabinetWClass") or WinActive("ahk_class Progman")
    ; Navigation
    ^Down::Send "{Enter}"        ; Open
    ^Up::Send "!{Up}"            ; Parent
    ^[::Send "!{Left}"           ; Back
    ^]::Send "!{Right}"          ; Forward
    Enter::Send "{F2}"           ; Rename
    
    ; Deleting
    ^Backspace::Send "{Del}"     ; Trash
    ^+Backspace::Send "+{Del}"   ; Delete Perm
    ^+Del::FileRecycleEmpty      ; Empty Trash
    
    ; Folders (Cmd+Shift+...)
    ^+c::Run "::{20D04FE0-3AEA-1069-A2D8-08002B30309D}" ; Computer
    ^+d::Run A_Desktop
    ^+h::Run A_MyDocuments
    ^+a::Run "shell:AppsFolder"
    ^+u::Run "C:\Windows\System32"
    ^+k::Run "::{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" ; Network
    
    ; Quick Look (PowerToys Peek must be set to Ctrl+Space)
    Space::
    {
        try {
            if InStr(ControlGetClassNN(ControlGetFocus("A")), "DirectUIHWND")
                Send "^{Space}"
            else
                Send "{Space}"
        } catch
            Send "{Space}"
    }
    ^y::Send "^{Space}"

    ; Hidden Files (Cmd+Shift+.)
    ^+SC034::
    {
        RegReadPath := "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
        if (RegRead(RegReadPath, "Hidden") = 2) 
            RegWrite(1, "REG_DWORD", RegReadPath, "Hidden")
        else 
            RegWrite(2, "REG_DWORD", RegReadPath, "Hidden")
        Send "{F5}"
    }
    
    ; Views
    ^1::Send "^!1" ; Icons
    ^2::Send "^!6" ; List
    ^3::Send "^!2" ; Details
#HotIf

; ==============================================================================
; 3. TEXT NAVIGATION (GLOBAL)
; ==============================================================================
; Cmd + Arrows (Home/End)
^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"

; Cmd + Shift + Arrows (Selection)
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Alt + Arrows (Word Jump - Standard Windows uses Ctrl+Arrows)
; Physical Alt is Alt. We need to map Alt -> Ctrl for arrows.
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"
!Delete::Send "^{Delete}"

; Cmd + Backspace (Delete Line)
^Backspace::Send "+{Home}{Delete}"

; Redo (Cmd+Shift+Z -> Ctrl+Y)
^+z::Send "^y"

; ==============================================================================
; 4. BROWSERS (Chrome, Edge, Firefox, Arc, Brave)
; ==============================================================================
GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Browsers", "ahk_exe firefox.exe"
GroupAdd "Browsers", "ahk_exe brave.exe"
GroupAdd "Browsers", "ahk_exe arc.exe"

#HotIf WinActive("ahk_group Browsers")
    ; History Nav
    ^[::Send "!{Left}"
    ^]::Send "!{Right}"
    ; Tabs Nav
    ^{::Send "^+{Tab}"
    ^}::Send "^{Tab}"
    ; Address Bar
    ^l::Send "!d"
    ; Dev Tools
    ^!i::Send "{F12}"
    ; Downloads
    ^!j::Send "^j"
    ; Clear Data
    ^+Del::Send "^+{Del}"
    ; Zoom (Cmd + / Cmd - / Cmd 0)
    ^=::Send "^{=}"
    ^-::Send "^{-}"
    ^0::Send "^{0}"
#HotIf

; ==============================================================================
; 5. WINDOW MANAGEMENT & MISSION CONTROL
; ==============================================================================
; Mission Control Keys
$F3::Send "#{Tab}"
SC13F::Send "#{Tab}"
$F4::Send "{LWin}"
SC121::Send "{LWin}"

; Spaces (Desktops) - Physical Ctrl (Win) + Arrows
; PowerToys maps Physical Ctrl -> Win (#)
#Left::Send "#^{Left}"
#Right::Send "#^{Right}"
#Down::Send "#{Down}" ; App Expose

; Rectangle/Magnet Style Snapping
; Physical Ctrl (Win) + Alt + Arrows
#!Left::Send "#{Left}"
#!Right::Send "#{Right}"
#!Up::Send "#{Up}"
#!Down::Send "#{Down}"
#!Enter::Send "#{Up}"

; Standard Window Ops
^m::Send "#{Down}"  ; Minimize
^h::Send "#{Down}"  ; Hide
^!h::Send "#{Home}" ; Hide Others

; ==============================================================================
; 6. TERMINAL & DEV FIXES
; ==============================================================================
GroupAdd "Terminals", "ahk_exe WindowsTerminal.exe"
GroupAdd "Terminals", "ahk_exe powershell.exe"
GroupAdd "Terminals", "ahk_exe cmd.exe"
GroupAdd "Terminals", "ahk_exe code.exe"
GroupAdd "Terminals", "ahk_exe mintty.exe" ; Git Bash

#HotIf WinActive("ahk_group Terminals")
    ; Copy/Paste (Cmd+C/V -> Ctrl+Shift+C/V for terminals)
    ^c::Send "^+c"
    ^v::Send "^+v"
    
    ; SIGINT (Physical Ctrl+C -> Native Ctrl+C)
    ; Physical Ctrl sends Win (#). We catch Win+C and send clean Ctrl+C
    #c::Send "^c"
    
    ; Clear
    ^k::Send "clear{Enter}"
    
    ; Find
    ^f::Send "^+f"
    
    ; New Tab/Close Tab
    ^t::Send "^+t"
    ^w::Send "^+w"
#HotIf

; ==============================================================================
; 7. MISC
; ==============================================================================
; App Switcher (Cmd+Tab -> Alt+Tab)
LCtrl & Tab::AltTab
; Quit App (Cmd+Q -> Alt+F4)
^q::Send "!{F4}"
; Characters
SC029::Send "{Text}§"
+SC029::Send "{Text}±"