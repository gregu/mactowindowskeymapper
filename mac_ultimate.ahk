; ==============================================================================
; MAC OS ULTIMATE V49 (THE MASKED INTERCEPTOR - LOGI KILLER)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
SetWinDelay -1
SetControlDelay -1
ProcessSetPriority "Realtime" ; Najwyższy możliwy priorytet dla skryptu

; Maska (wirtualny klawisz, który nic nie robi, ale "zużywa" klawisz Win)
vkMask := "vkE8"

; ==============================================================================
; 1. AGRESYWNA ZAMIANA MODYFIKATORÓW
; ==============================================================================

*LWin::
{
    ; KROK 1: Oszukaj Windowsa, że klawisz Win został już "zużyty"
    Send "{Blind}{" vkMask "}"
    
    ; KROK 2: Fizycznie "puść" klawisz Win w oczach systemu
    Send "{Blind}{LWin Up}"
    
    ; KROK 3: Wciśnij Ctrl
    Send "{Blind}{LCtrl Down}"
    
    ; KROK 4: Czekaj, aż Ty fizycznie puścisz klawisz na klawiaturze
    KeyWait "LWin"
    
    ; KROK 5: Puść Ctrl
    Send "{Blind}{LCtrl Up}"
}

; Fizyczny Ctrl działa jako Win (dla Cmd+Space)
*LCtrl::
{
    Send "{Blind}{LWin Down}"
    KeyWait "LCtrl"
    Send "{Blind}{LWin Up}"
    ; Maska, żeby samo Ctrl nie otwierało niczego dziwnego
    if (A_PriorKey = "LCtrl")
        Send "{Blind}{" vkMask "}"
}

; ==============================================================================
; 2. SKRÓTY SYSTEMOWE (Dostosowane do nowego silnika)
; ==============================================================================
; Teraz Cmd to dla systemu Ctrl. Więc piszemy skróty z ^.

; Cmd+Space -> Start (Fizycznie Ctrl+Space -> Wysyła Win+Esc)
^Space::Send "^{Esc}"

; Cmd+Tab -> Alt+Tab (Fizycznie Ctrl+Tab)
LCtrl & Tab::AltTab

; --- SCREENSHOTY (Cmd+Shift+3/4) ---
^+3::Send "{PrintScreen}"
^+4::Send "#+s"

; --- NAWIGACJA (Cmd + Strzałki) ---
^Left::Send "{Home}"
^Right::Send "{End}"
^Up::Send "^{Home}"
^Down::Send "^{End}"

; --- ZAZNACZANIE (Cmd + Shift + Strzałki) ---
+^Left::Send "+{Home}"
+^Right::Send "+{End}"
+^Up::Send "+^{Home}"
+^Down::Send "+^{End}"

; --- INNE ---
^Backspace::Send "+{Home}{Delete}"
!Left::Send "^{Left}"
!Right::Send "^{Right}"
!Backspace::Send "^{Backspace}"

; ==============================================================================
; 3. FIXES
; ==============================================================================
#HotIf WinActive("ahk_class CabinetWClass")
    Enter::Send "{F2}"
    ^Down::Send "{Enter}"
    ^Up::Send "!{Up}"
#HotIf

; Klawisze F3/F4 (Logitech codes)
SC13F::Send "#{Tab}"
SC121::Send "^{Esc}"

; Klawisz pod Esc
SC029::Send "{Text}§"
+SC029::Send "{Text}±"