; ==============================================================================
; MAC OS ULTIMATE V26 (CLEAN CORE - NO DUPLICATES GUARANTEED)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
InstallMouseHook

A_MenuMaskKey := "vkE8"

; --- GROUPS ---
GroupAdd "Explorer", "ahk_class CabinetWClass"
GroupAdd "Explorer", "ahk_class ExploreWClass"

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

GroupAdd "Browsers", "ahk_exe chrome.exe"
GroupAdd "Browsers", "ahk_exe msedge.exe"
GroupAdd "Browsers", "ahk_exe firefox.exe"

; ==============================================================================
; SECTION 1: WINDOWS SYSTEM KILLERS (Priority Override)
; ==============================================================================
; Zatrzymujemy natywne skróty Windows (Win+...) zanim cokolwiek innego zadziała.

$#c::Send "^c"          ; Copilot
$#f::Send "^f"          ; Feedback Hub
$#+f::Send "^+f"        ; Web Search
$#r::Send "^r"          ; Run
$#e::Send "^e"          ; Explorer
$#a::Send "^a"          ; Action Center
$#s::Send "^s"          ; Search
$#v::Send "^v"          ; Clipboard History
$#x::Send "^x"          ; Win+X Menu
$#z::Send "^z"          ; Undo
$#+z::Send "^+z"        ; Redo
$#l::Send "^l"          ; Lock Screen
$#t::Send "^t"          ; Taskbar Focus

; ==============================================================================
; SECTION 2: CORE MODIFIERS (Global Remap)
; ==============================================================================

; --- CMD (LWin) -> CTRL ---
; To sprawia, że KAŻDY skrót Cmd+X działa jak Ctrl+X automatycznie.
; Nie musimy definiować ^t, ^w, ^c, ^v ręcznie, chyba że chcemy zmienić ich działanie.
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; --- CTRL (LCtrl) -> WIN ---
*LCtrl::
{
    if WinActive("ahk_group Terminals")
        Send "{Blind}{LCtrl DownR}" ; Terminale potrzebują Ctrl
    else
        Send "{Blind}{LWin DownR}"
}

*LCtrl Up::
{
    if WinActive("ahk_group Terminals")
        Send "{Blind}{LCtrl Up}"
    else {
        Send "{Blind}{LWin Up}"
        if (A_PriorKey = "LCtrl")
            Send "{Blind}{vkE8}"
    }
}

; ==============================================================================
; SECTION 3: THE DISPATCHER (Logic Center)
; ==============================================================================
; Definiujemy tu TYLKO te klawisze, które mają różne działanie w różnych oknach.

; --- BACKSPACE ---
^Backspace::
{
    if WinActive("ahk_group Explorer")
        Send "{Delete}"               ; Usuń plik
    else
        Send "+{Home}{Delete}"        ; Usuń linię
}

; --- ENTER ---
Enter::
{
    if WinActive("ahk_group Explorer")
        Send "{F2}"                   ; Zmień nazwę
    else
        Send "{Enter}"
}

; --- NAVIGATION (Arrows) ---
^Up::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Up}"   ; Folder w górę
    else
        Send "^{Home}"                ; Pocz. pliku
}

^Down::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}{Enter}" ; Otwórz (to samo okno)
    else
        Send "^{End}"                 ; Koniec pliku
}

^Left::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}" ; Wstecz
    else
        Send "{Home}"                 ; Pocz. linii
}

^Right::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}" ; Dalej
    else
        Send "{End}"                   ; Koniec linii
}

; --- BRACKETS ([ ]) ---
^[::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Left}"
    else if WinActive("ahk_group Editors")
        Send "^!{Left}"
    else
        Send "^["
}

^]::
{
    if WinActive("ahk_group Explorer")
        SendInput "{LCtrl Up}!{Right}"
    else if WinActive("ahk_group Editors")
        Send "^!{Right}"
    else
        Send "^]"
}

; --- FIND (Cmd+F) ---
^f::
{
    if WinActive("ahk_group Terminals")
        Send "^+f"
    else if WinActive("ahk_group Explorer")
        Send "^e"
    else
        Send "^f"
}

; --- NEW ITEM (Cmd+N / Cmd+Shift+N) ---
^n::
{
    ; Globalny remap załatwia Ctrl+N, tutaj tylko wyjątki jeśli potrzebne
    Send "^n"
}

^+n::
{
    if WinActive("ahk_group Explorer")
        Send "^+n" ; Nowy folder
    else if WinActive("ahk_group Editors")
        Send "^+n" ; Go to File
    else
        Send "^+n"
}

; --- COPY / PASTE (Fix for Terminals) ---
^c::
{
    if WinActive("ahk_group Terminals")
        Send "^+c"
    else
        Send "^c"
}

^v::
{
    if WinActive("ahk_group Terminals")
        Send "^+v"
    else
        Send "^v"
}

; ==============================================================================
; SECTION 4: UNIQUE CONTEXTS (Only keys NOT defined above)
; ==============================================================================

#HotIf WinActive("ahk_group Browsers")
    ^!i::Send "{F12}"      ; DevTools
    ^+j::Send "^j"         ; Downloads
    ^y::Send "^h"          ; History
    ; Nie dodajemy tu ^t, ^w, ^l bo globalny remap LWin->LCtrl to załatwia!
#HotIf

#HotIf WinActive("ahk_group Explorer")
    ^+Backspace::Send "+{Delete}"
    ^i::Send "!{Enter}"
#HotIf

#HotIf WinActive("ahk_group Editors")
    ; Skróty z Altem (IntelliJ używa Alt+1, my chcemy Cmd+1)
    $#1::Send "!1"
    $#7::Send "!7"
    $#9::Send "!9"
    $#`::Send "!{F12}"
    $#/::Send "^/"
    $#d::Send "^d"
    $#b::Send "^b"
#HotIf

; ==============================================================================
; SECTION 5: GLOBAL UTILS
; ==============================================================================
#HotIf ; GLOBAL

; F-Keys (Dla trybu Standard F-Keys)
F3::Send "#{Tab}"       ; Mission Control
F4::Send "^{Esc}"       ; Launchpad
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F10::Send "{Volume_Mute}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; System
^Space::Send "^{Esc}"   ; Start Menu
LCtrl & Tab::AltTab     ; Alt-Tab
^q::Send "!{F4}"        ; Quit
^m::WinMinimize "A"     ; Minimize
^!Esc::Send "^+{Esc}"   ; Task Manager
^,::Send "^!s"          ; Settings

; Screenshots
^+3::Send "{PrintScreen}"
^+4::
{
    SendInput "{LCtrl Up}"
    SendInput "#+s"
    return
}

; Selection (Shift + Arrows)
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; Word Navigation
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; Hardware
LCtrl & LButton::Click "Right"
RAlt::RAlt
SC029::Send "{Text}§"
+SC029::Send "{Text}±"

F8::Suspend