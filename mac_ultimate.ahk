; ==============================================================================
; MAC OS ULTIMATE V52 (JAVA COMPATIBILITY MODE - SendEvent)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
; Zmiana silnika na SendEvent (wolniejszy, ale lepiej działa z Javą/Adminem)
SetKeyDelay 0, 0 
SendMode "Event" 

; Maska menu start
A_MenuMaskKey := "vkE8"

; ==============================================================================
; 1. BEZWARUNKOWY REMAP (Blind Mode)
; ==============================================================================
; Używamy składni bez gwiazdki (*) w specyficzny sposób dla LWin.
; Próbujemy "oszukać" system, że LWin to tak naprawdę LCtrl.

LWin::LCtrl
LCtrl::LWin

; ==============================================================================
; 2. WYMUSZANIE HOOKA NA INTELLIJ
; ==============================================================================
; Gdy IntelliJ staje się aktywne, wymuszamy odświeżenie skryptu.
; Czasem to pozwala "wskoczyć" przed system.

Loop {
    if WinActive("ahk_exe idea64.exe") {
        ; Jeśli jesteśmy w IntelliJ, upewnij się, że Hook jest aktywny
        if (A_TimeIdle < 500) ; Tylko jeśli piszesz
            InstallKeybdHook
    }
    Sleep 1000
}

; ==============================================================================
; 3. SKRÓTY (Oparte na nowym LCtrl)
; ==============================================================================

; Cmd+Space -> Menu Start
^Space::Send "^{Esc}"

; Cmd+Tab -> Alt+Tab
LCtrl & Tab::AltTab

; --- SCREENSHOTY ---
^+3::Send "{PrintScreen}"
^+4::Send "#+s"

; --- NAWIGACJA ---
^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"

+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; --- EDYCJA ---
^Backspace::Send "+{Home}{Delete}"

; Alt + Strzałki
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; ==============================================================================
; 4. FIXES
; ==============================================================================
#HotIf WinActive("ahk_class CabinetWClass")
    Enter::Send "{F2}"
    ^Down::Send "{Enter}"
    ^Up::Send "!{Up}"
#HotIf

SC13F::Send "#{Tab}"
SC121::Send "^{Esc}"
SC029::Send "{Text}§"
+SC029::Send "{Text}±"