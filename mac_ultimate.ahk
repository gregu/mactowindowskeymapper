; ==============================================================================
; MAC OS ULTIMATE V36 (INTELLIJ INJECTION + DUPLICATE CONTROL)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook

; Maska klawisza Win (żeby Start nie wyskakiwał przy LCtrl)
A_MenuMaskKey := "vkE8"

; --- DEFINICJA GRUP ---
GroupAdd "Editors", "ahk_exe idea64.exe"      ; IntelliJ
GroupAdd "Editors", "ahk_exe Code.exe"        ; VS Code
GroupAdd "Explorer", "ahk_class CabinetWClass"

; ==============================================================================
; SECTION 1: CORE REMAPPING (GLOBAL)
; ==============================================================================

; Cmd (LWin) -> Ctrl
*LWin::Send "{Blind}{LCtrl DownR}"
*LWin Up::Send "{Blind}{LCtrl Up}"

; Ctrl (LCtrl) -> Win (Z blokadą Menu Start)
*LCtrl::Send "{Blind}{LWin DownR}"
*LCtrl Up::
{
    Send "{Blind}{LWin Up}"
    if (A_PriorKey = "LCtrl")
        Send "{Blind}{vkE8}"
}

; ==============================================================================
; SECTION 2: INTELLIJ "CLINCH" (Tylko dla IntelliJ)
; ==============================================================================
; Używamy $ oraz Scancode, aby Windows nie przechwycił Win+F/Win+R.

#HotIf WinActive("ahk_exe idea64.exe")

    ; CMD+F (Find)
    $#f::
    {
        Send "{LCtrl down}"
        Sleep 15
        Send "{sc021 down}" ; F
        Sleep 15
        Send "{sc021 up}{LCtrl up}"
    }

    ; CMD+R (Replace)
    $#r::
    {
        Send "{LCtrl down}"
        Sleep 15
        Send "{sc013 down}" ; R
        Sleep 15
        Send "{sc013 up}{LCtrl up}"
    }

    ; CMD+SHIFT+F (Find in Path)
    $#+f::
    {
        Send "{LCtrl down}{LShift down}"
        Sleep 15
        Send "{sc021 down}" ; F
        Sleep 15
        Send "{sc021 up}{LShift up}{LCtrl up}"
    }

    ; CMD+SHIFT+R (Replace in Path)
    $#+r::
    {
        Send "{LCtrl down}{LShift down}"
        Sleep 15
        Send "{sc013 down}" ; R
        Sleep 15
        Send "{sc013 up}{LShift up}{LCtrl up}"
    }

#HotIf

; ==============================================================================
; SECTION 3: GLOBAL LOGIC (Z wyłączeniem IntelliJ dla duplikatów)
; ==============================================================================

; Cmd+Space -> Start Menu
^Space::Send "^{Esc}"

; Cmd+Tab -> Alt+Tab
LCtrl & Tab::AltTab

; --- NAWIGACJA (Działa wszędzie) ---
; Używamy *^, aby obsłużyć Cmd+Arrows oraz Cmd+Shift+Arrows w jednym bloku
*^Left::  Send (GetKeyState("Shift", "P") ? "+{Home}" : "{Home}")
*^Right:: Send (GetKeyState("Shift", "P") ? "+{End}" : "{End}")
*^Up::    Send (GetKeyState("Shift", "P") ? "+^{Home}" : "^{Home}")
*^Down::  Send (GetKeyState("Shift", "P") ? "+^{End}" : "^{End}")

; --- EDYCJA ---
^Backspace::Send "+{Home}{Delete}"

; --- EKSPLORATOR ---
#HotIf WinActive("ahk_group Explorer")
    Enter::Send "{F2}"
    ^Down::Send "{Enter}"
    ^Up::Send "!{Up}"
    ^Backspace::Send "{Delete}"
#HotIf

; --- MULTIMEDIA ---
F7::Send "{Media_Prev}"
F8::Send "{Media_Play_Pause}"
F9::Send "{Media_Next}"
F11::Send "{Volume_Down}"
F12::Send "{Volume_Up}"

; --- HARDWARE ---
SC029::Send "{Text}§"       ; Klawisz pod ESC
+SC029::Send "{Text}±"
LCtrl & LButton::Click "Right"
RAlt::RAlt