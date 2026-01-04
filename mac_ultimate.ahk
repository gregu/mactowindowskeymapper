; ==============================================================================
; MAC OS ULTIMATE V42 (EXPLICIT HOOKS - STABLE EDITION)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook

; Maska dla klawisza Win (Zapobiega otwieraniu Menu Start)
A_MenuMaskKey := "vkE8"

; ==============================================================================
; 1. SCREENSHOTS (Naprawa "4 aplikacji z belki")
; ==============================================================================
; Używamy $#, aby Windows nie mógł "ukraść" Win+4 dla paska zadań.

$#+3::Send "{PrintScreen}"  ; Cmd+Shift+3
$#+4::                      ; Cmd+Shift+4
{
    Send "{LWin Up}{LShift Up}" ; Czyścimy fizyczny stan dla Windowsa
    Sleep 10
    Send "#+s"                  ; Wyślij natywny Snip & Sketch
}

; ==============================================================================
; 2. INTELLIJ & GLOBAL SHORTCUTS (The "Cmd" Experience)
; ==============================================================================
; Mapujemy fizyczny Win (#) na Ctrl (^). 
; Dzięki $ system nie powinien odpalać Feedback Hub / Search Web.

$#f::Send "^f"              ; Cmd+F -> Ctrl+F (Find)
$#r::Send "^r"              ; Cmd+R -> Ctrl+R (Replace)
$#+f::Send "^+f"            ; Cmd+Shift+F (Find in Path)
$#c::Send "^c"              ; Cmd+C (Copy)
$#v::Send "^v"              ; Cmd+V (Paste)
$#s::Send "^s"              ; Cmd+S (Save)
$#z::Send "^z"              ; Cmd+Z (Undo)
$#+z::Send "^+z"            ; Cmd+Shift+Z (Redo)
$#a::Send "^a"              ; Cmd+A (Select All)
$#w::Send "^w"              ; Cmd+W (Close)
$#t::Send "^t"              ; Cmd+T (New Tab)
$#n::Send "^n"              ; Cmd+N (New)
$#q::Send "!{F4}"            ; Cmd+Q (Quit)
$#/::Send "^/"              ; Cmd+/ (Comment)
$#d::Send "^d"              ; Cmd+D (Duplicate)

; ==============================================================================
; 3. NAVIGATION (Cmd + Arrows)
; ==============================================================================
$#Left::Send "{Home}"
$#Right::Send "{End}"
$#Up::Send "^{Home}"
$#Down::Send "^{End}"

; Zaznaczanie (Cmd + Shift + Arrows)
$#+Left::Send "+{Home}"
$#+Right::Send "+{End}"
$#+Up::Send "+^{Home}"
$#+Down::Send "+^{End}"

; Word Jump (Alt + Arrows -> Ctrl + Arrows)
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Cmd + Backspace (Delete line)
$#Backspace::Send "+{Home}{Delete}"

; ==============================================================================
; 4. MODIFIERS & SYSTEM
; ==============================================================================

; Cmd + Space (Start Menu)
$#Space::Send "^{Esc}"

; Fizyczny Ctrl -> Działa jak Win (Dla innych skrótów systemowych)
LControl::LWin

; ==============================================================================
; 5. F-KEYS (Logitech MX Keys)
; ==============================================================================
; Jeśli klawiatura jest w trybie Media, używamy tych kodów:

$F3::Send "#{Tab}"          ; Mission Control
$F4::Send "^{Esc}"          ; Launchpad/Start

; Mapowanie przycisków Logitech (nad F3/F4), jeśli standardowe F nie działają:
SC13F::Send "#{Tab}"        ; Przycisk Task View
SC121::Send "^{Esc}"        ; Przycisk Search

; Multimedia
$F7::Send "{Media_Prev}"
$F8::Send "{Media_Play_Pause}"
$F9::Send "{Media_Next}"
$F11::Send "{Volume_Down}"
$F12::Send "{Volume_Up}"

; ==============================================================================
; 6. EXPLORER & MISC
; ==============================================================================
#HotIf WinActive("ahk_class CabinetWClass")
    Enter::Send "{F2}"      ; Rename
    #Down::Send "{Enter}"   ; Open
    #Up::Send "!{Up}"       ; Parent
#HotIf

; Klawisz pod Esc (§/±)
SC029::Send "{Text}§"
+SC029::Send "{Text}±"