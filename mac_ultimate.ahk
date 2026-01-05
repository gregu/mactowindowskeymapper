; ==============================================================================
; MAC OS ULTIMATE V50 (INPUT HOOK - THE VACUUM CLEANER)
; ==============================================================================
#Requires AutoHotkey v2.0
#SingleInstance Force
#UseHook
InstallKeybdHook
SetWinDelay -1
SetControlDelay -1
ProcessSetPriority "Realtime"

; ==============================================================================
; 1. THE VACUUM (Całkowite usunięcie LWin z oczu systemu)
; ==============================================================================
; Tworzymy InputHook, który "połyka" klawisz LWin.
; Windows w ogóle nie dowie się, że go nacisnąłeś.

WinHook := InputHook("V0 L0") ; V0 = Ukryj klawisz przed systemem
WinHook.KeyOpt("{LWin}", "SN") ; S = Suppress (Zablokuj), N = Notify (Powiadom skrypt)

; Kiedy naciskasz fizyczny Win -> Skrypt wciska wirtualny Ctrl
WinHook.OnKeyDown := ((*) => SendInput("{LCtrl Down}"))

; Kiedy puszczasz fizyczny Win -> Skrypt puszcza wirtualny Ctrl
WinHook.OnKeyUp := ((*) => SendInput("{LCtrl Up}"))

WinHook.Start()

; ==============================================================================
; 2. FIZYCZNY CTRL -> WIN (Dla Cmd+Space)
; ==============================================================================
; Skoro zabiliśmy Win, musimy dać Ci sposób na otwarcie Menu Start.
; Fizyczny Ctrl (lewy dół) będzie działał jak Win.

*LCtrl::
{
    SendInput "{LWin Down}"
}

*LCtrl Up::
{
    SendInput "{LWin Up}"
    ; Zapobiega otwieraniu Startu, jeśli użyłeś Ctrl jako modyfikatora
    if (A_PriorKey = "LCtrl")
        SendInput "{vkE8}" 
}

; ==============================================================================
; 3. SKRÓTY (Bazujemy na Ctrl, bo Win został zamieniony w Pkt 1)
; ==============================================================================

; Cmd+Space -> Menu Start (Teraz fizycznie Ctrl+Space)
^Space::Send "^{Esc}"

; Cmd+Tab -> Alt+Tab (Fizycznie Ctrl+Tab)
LCtrl & Tab::AltTab

; --- SCREENSHOTY ---
^+3::Send "{PrintScreen}"
^+4::Send "#+s"

; --- NAWIGACJA (Cmd+Strzałki) ---
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

; Alt + Strzałki (Word Jump)
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

; Klawisze F3/F4 (Logitech Codes)
SC13F::Send "#{Tab}"
SC121::Send "^{Esc}"

SC029::Send "{Text}§"
+SC029::Send "{Text}±"