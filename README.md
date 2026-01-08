# 🍏 Ultimate macOS Experience for Windows (V63)

Transform your Windows 10/11 workflow into macOS. Optimized for **Logitech MX Keys**, **IntelliJ IDEA**, and **Developers** (No Admin Rights required).

## 🚀 The Hybrid Architecture

This project uses a robust **2-Layer Approach** to bypass Windows restrictions and avoid conflicts:

1.  **Layer 1 (Hardware): Microsoft PowerToys**
    * Remaps physical keys at the low-level registry hook.
    * **Crucial:** Maps `Win (Left)` ➔ `Ctrl (Left)`.
    * *Result:* Windows sees a clean `Ctrl` signal. Zero conflicts with Start Menu or Feedback Hub.
2.  **Layer 2 (Logic): AutoHotkey v2**
    * Handles navigation, window management, special characters, and app-specific logic (Terminal, Finder).

---

## 🛠️ Prerequisites

1.  **[Microsoft PowerToys](https://github.com/microsoft/PowerToys/releases)**
    * Download the `UserSetup` version (installable without Admin rights).
2.  **[AutoHotkey v2](https://github.com/AutoHotkey/AutoHotkey/releases)**
    * Download and install `AutoHotkey_2.0.x_setup.exe`.

---

## ⚙️ Configuration (Step-by-Step)

### 1. PowerToys Keyboard Manager
Open PowerToys -> Keyboard Manager -> **Remap keys**. Add exactly these two mappings:

| Physical Key (Input) | Mapped To (Output) | Why? |
| :--- | :--- | :--- |
| **Win (Left)** | **Ctrl (Left)** | Makes your Thumb key act as Ctrl (Cmd behavior). |
| **Ctrl (Left)** | **Win (Left)** | Moves the Windows key to the corner (for Snap/Lock). |

### 2. PowerToys Utilities
Enable these modules to match macOS behavior:
* **PowerToys Run:** On (Shortcut: `Alt + Space`). Acts as **Spotlight**.
* **Peek:** On (Shortcut: `Ctrl + Space`). Acts as **Quick Look**.

### 3. Install the Script
1.  Download `mac_ultimate_v63.ahk`.
2.  Double-click `INSTALL_AUTOSTART.bat` to automatically copy the script to your Windows Startup folder.
3.  Run the `.ahk` file manually once to start it immediately.

---

## ✨ Key Features

* **System:** Spotlight (`Cmd+Space`), Force Quit, Lock Screen, Emoji Picker (`Cmd+Ctrl+Space`).
* **Finder:** Navigation (`Cmd+Arrows`), Quick Look (`Space`), New Folder, Delete (`Cmd+Back`).
* **Text:** macOS cursor navigation (`Cmd/Opt + Arrows`), `Cmd+A/C/V/Z`.
* **Browsers:** Native tab management, Zoom (`Cmd +/-`), Address Bar (`Cmd+L`).
* **IntelliJ/VS Code:** Works **natively**! `Cmd+C/V/F`, `Cmd+Click`, Refactorings all work because the system sees `Ctrl`.
* **Terminal:**
    * `Cmd+C` = Copy.
    * `Cmd+V` = Paste.
    * `Ctrl+C` (Corner key) = SIGINT (Interrupt signal).

## 📚 Shortcuts Reference

For a complete list of all 400+ supported shortcuts, see **[supportedShortcuts.md](supportedShortcuts.md)**.

## ❓ FAQ

**Why doesn't the script handle `Cmd+C`?**
Because PowerToys handles it! By remapping Win->Ctrl at the hardware level, `Cmd+C` is sent as `Ctrl+C` to Windows natively. This is faster and bug-free.

**The Start Menu opens when I press Cmd!**
PowerToys is likely not running or the Keyboard Manager is disabled.

---
**License:** MIT