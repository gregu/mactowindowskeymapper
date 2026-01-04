# Mac-Like Experience for Windows (No Admin Rights)

This AutoHotKey script provides a macOS-like keyboard experience on Windows 10/11. It is specifically designed for users who:
* Use a **Logitech MX Keys for Mac** (or similar Mac layout keyboard).
* **Do not have Administrator privileges** (Corporate laptops).
* Need seamless switching between **GUI apps** (IntelliJ, Browser) and **Terminal/WSL**.

## 🚀 Features

* **Command ⌘ behaves like Control** (Copy, Paste, Select All).
* **Physical Control behaves like Windows Key**.
* **Smart Terminal Mode:**
    * In Terminals (WSL, PowerShell), `Cmd+C` performs `Ctrl+Shift+C` (Copy).
    * Physical `Ctrl` sends native signal (essential for `Ctrl+C` SIGINT or Vim navigation).
* **Navigation:** `Cmd + Arrows` for Home/End; `Option + Arrows` for word jumping.
* **System Shortcuts:**
    * `Cmd + Tab` → App Switcher (Alt+Tab).
    * `Cmd + Space` → Start Menu.
    * `Cmd + Q` → Close Window.
    * `Cmd + Shift + 3/4` → Screenshots.
* **Mouse:** `Ctrl + Click` triggers **Right Click**.

## ⚙️ Prerequisites

1.  **AutoHotKey (Portable):**
    * Download the `.zip` version of AutoHotKey (v1.1 or v2.0) from the [official site](https://www.autohotkey.com/).
    * Extract it to a folder (no installation required).
2.  **Logitech Keyboard Setup:**
    * **Crucial Step:** Ensure your keyboard is sending Windows codes on the Windows channel.
    * Press and hold **`Fn + P`** for 3 seconds while on the Windows channel. The LED should blink.

## 📦 Installation

1.  Clone this repository or download `mac_ultimate.ahk`.
2.  Drag and drop `mac_ultimate.ahk` onto `AutoHotkeyU64.exe` (from the portable folder).
3.  Look for the green "H" icon in the system tray.

## ⌨️ Key Mappings

| Action | Physical Key Combo | Emulated Windows Action |
| :--- | :--- | :--- |
| **Copy / Paste** | `Cmd + C` / `V` | `Ctrl + C` / `V` |
| **Terminal Copy** | `Cmd + C` | `Ctrl + Shift + C` |
| **Start Menu** | `Cmd + Space` | `Win` (Ctrl+Esc) |
| **App Switcher** | `Cmd + Tab` | `Alt + Tab` |
| **Close App** | `Cmd + Q` | `Alt + F4` |
| **Right Click** | `Ctrl + Left Click` | `Right Click` |
| **End of Line** | `Cmd + Right Arrow` | `End` |
| **Next Word** | `Opt + Right Arrow` | `Ctrl + Right Arrow` |

## 🛠 Troubleshooting

* **Script interfering with a game?**
    * Press **`F8`** to Suspend the script. Press again to Resume.
* **IntelliJ Shortcuts:**
    * Keep IntelliJ keymap set to **"Windows"**. The script handles the translation so you can use your thumb (Command key) naturally.
* **Terminal Copy/Paste not working?**
    * Ensure your Windows Terminal settings map `Copy` to `Ctrl+Shift+C` and `Paste` to `Ctrl+Shift+V` (this is default).

## 📄 License

MIT License. Feel free to modify and share.