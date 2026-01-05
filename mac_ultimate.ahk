; ==============================================================================
; MAC OS ULTIMATE V48 (CUSTOM COMBINATIONS - THE IRON GRIP)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
SetWinDelay -1
SetControlDelay -1

; Maska menu start
A_MenuMaskKey := "vkE8"

; ==============================================================================
; 1. THE IRON GRIP (Blokowanie Win+Klawisz na poziomie AHK)
; ==============================================================================
; Użycie "&" sprawia, że LWin staje się "klawiszem prefiksowym".
; System nie widzi LWin, dopóki go nie puścisz (a my go wyłączymy przy puszczeniu).

; --- EDYCJA I SYSTEM (Cmd + Litera) ---
; {Blind} sprawia, że Shift przechodzi dalej.
; Czyli: Trzymasz Shift + Cmd + F -> Skrypt wysyła Shift + Ctrl + F.

LWin & a::Send "{Blind}^a"        ; Select All
LWin & c::Send "{Blind}^c"        ; Copy
LWin & v::Send "{Blind}^v"        ; Paste
LWin & x::Send "{Blind}^x"        ; Cut
LWin & z::Send "{Blind}^z"        ; Undo
LWin & s::Send "{Blind}^s"        ; Save
LWin & f::Send "{Blind}^f"        ; Find (IntelliJ Fix)
LWin & r::Send "{Blind}^r"        ; Replace / Refresh
LWin & n::Send "{Blind}^n"        ; New
LWin & t::Send "{Blind}^t"        ; New Tab
LWin & w::Send "{Blind}^w"        ; Close
LWin & q::Send "!{F4}"            ; Quit -> Alt+F4
LWin & /::Send "{Blind}^/"        ; Comment (IntelliJ)
LWin & d::Send "{Blind}^d"        ; Duplicate (IntelliJ)
LWin & b::Send "{Blind}^b"        ; Bold / Go to declaration
LWin & l::Send "{Blind}^l"        ; Address Bar

; --- NAWIGACJA (Cmd + Strzałki) ---
LWin & Left::Send "{Blind}{Home}"
LWin & Right::Send "{Blind}{End}"
LWin & Up::Send "{Blind}^{Home}"
LWin & Down::Send "{Blind}^{End}"

; --- EDYCJA TEKSTU ---
LWin & Backspace::Send "+{Home}{Delete}"

; --- SYSTEMOWE ---
LWin & Space::Send "^{Esc}"       ; Start Menu
LWin & Tab::AltTab                ; App Switcher

; --- SCREENSHOTY (Cmd + Shift + 3/4) ---
; Tutaj musimy sprawdzić Shifta ręcznie, bo cyfry mają inne symbole z Shiftem
LWin & 3::
{
    if GetKeyState("Shift", "P")
        Send "{PrintScreen}"
    else
        Send "^3"
}

LWin & 4::
{
    if GetKeyState("Shift", "P")
        Send "#+s"
    else
        Send "^4"
}

; --- MYSZKA (Multicursor w IntelliJ) ---
LWin & LButton::Send "^{LButton}"

; ==============================================================================
; 2. CO ZROBIĆ Z SAMYM KLAWISZEM WIN?
; ==============================================================================
; Jeśli naciśniesz i puścisz Cmd (bez innego klawisza), nie rób nic.
; To całkowicie zabija przypadkowe otwieranie Menu Start.
LWin::return 

; ==============================================================================
; 3. POZOSTAŁE ULEPSZENIA
; ==============================================================================

; Alt + Strzałki (Word Jump) -> Ctrl + Arrows
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; F-Keys (Media Mode Fix)
SC13F::Send "#{Tab}"        ; Task View
SC121::Send "^{Esc}"        ; Start / Launchpad

; Explorer Fixes
#HotIf WinActive("ahk_class CabinetWClass")
    Enter::Send "{F2}"
    LWin & Down::Send "{Enter}"
    LWin & Up::Send "!{Up}"
#HotIf

; Klawisz §/±
SC029::Send "{Text}§"
+SC029::Send "{Text}±"