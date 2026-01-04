; ==============================================================================
; MAC OS ULTIMATE V41 (NO FN+ESC REQUIRED - MEDIA MODE DEFAULT)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook

A_MenuMaskKey := "vkE8"

; --- KLUCZOWY SWAP MODYFIKATORÓW ---
LWin::LCtrl
LCtrl::LWin

; ==============================================================================
; 1. SYSTEM & MULTIMEDIA
; ==============================================================================

; Klawisze F3 i F4 na MX Keys w trybie Media wysyłają specjalne kody (SC).
; Mapujemy je na Mission Control i Launchpad.
; Uwaga: SC13F i SC121 to kody przycisków "Task View" i "Search/Start" w Logitech.

SC13F::Send "#{Tab}"        ; Przycisk "Task View" (nad F3) -> Mission Control
SC121::Send "^{Esc}"        ; Przycisk "Search" (nad F4) -> Launchpad

; Jeśli Twoje F3/F4 nadal nie działają, odkomentuj poniższe standardowe:
; $F3::Send "#{Tab}"
; $F4::Send "^{Esc}"

; Reszta multimediów (Głośność, Jasność) działa NATYWNIE z klawiatury.
; Nie musimy ich pisać w skrypcie, dzięki czemu oszczędzasz miejsce i czas.

; --- SCREENSHOTS ---
^+3::Send "{PrintScreen}"
^+4::Send "#+s"

; ==============================================================================
; 2. NAWIGACJA & EDYCJA (Cmd to teraz Ctrl)
; ==============================================================================

^Space::Send "^{Esc}"       ; Cmd + Space
LCtrl & Tab::AltTab         ; Cmd + Tab

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
^q::Send "!{F4}"            ; Cmd + Q

; ==============================================================================
; 3. EXPLORER FIXES
; ==============================================================================

#HotIf WinActive("ahk_class CabinetWClass")
    Enter::Send "{F2}"
    ^Down::Send "{Enter}"
    ^Up::Send "!{Up}"
#HotIf

; Klawisz pod ESC (§/±)
SC029::Send "{Text}§"
+SC029::Send "{Text}±"