# Mac-Like Experience for Windows (No Admin Rights)

This AutoHotKey script provides a comprehensive macOS-like experience on Windows 10/11. It is optimized for **Logitech MX Keys for Mac** and works without Administrator privileges (portable).

## 🚀 Features

* **Command ⌘ is Control:** Use your thumb for Copy/Paste (`Cmd+C`, `Cmd+V`).
* **Smart Finder (Explorer):**
    * `Enter` renames files (like macOS).
    * `Cmd + ↓` opens files/folders.
    * `Cmd + ↑` goes to parent folder.
    * `Cmd + Backspace` deletes files.
* **Smart Terminal (WSL/PowerShell):**
    * `Cmd+C` performs `Copy` (sends `Ctrl+Shift+C`).
    * Physical `Ctrl` behaves natively (essential for `SIGINT` or `Vim`).
* **Navigation:** macOS style text navigation (`Cmd+Arrows`, `Option+Arrows`).
* **System:** `Cmd+Space` for Start Menu, `Cmd+Q` to close windows, `Cmd+Tab` to switch apps.

## ⚙️ Prerequisites

1.  **AutoHotKey v2.0 (Portable):**
    * Go to the [AutoHotkey GitHub Releases page](https://github.com/AutoHotkey/AutoHotkey/releases).
    * Scroll to the latest version and expand **Assets**.
    * Download the **.zip** file (e.g., `AutoHotkey_2.0.18.zip`).
    * Extract it to a folder of your choice.
2.  **Keyboard State:** Ensure your `Command` key acts as the Windows key (opens Start Menu) when the script is OFF. This is the default behavior for most Mac keyboards plugged into Windows.

## 📦 Installation

1.  Download `mac_ultimate_v2.ahk` from this repository.
2.  Drag and drop the `.ahk` file onto `AutoHotkey64.exe` (located in the folder where you extracted AutoHotkey).
3.  Enjoy! (A green "H" icon in the system tray indicates it's running).

## ⌨️ Cheat Sheet

| Action | Mac Shortcut (Your Hands) | Result on Windows |
| :--- | :--- | :--- |
| **Copy/Paste** | `Cmd + C/V` | Works everywhere |
| **Rename File** | `Enter` | Renames file (F2) |
| **Open File** | `Cmd + ↓` or `Cmd + O` | Opens file (Enter) |
| **Delete File** | `Cmd + Backspace` | Deletes file |
| **Spotlight** | `Cmd + Space` | Opens Start Menu |
| **Right Click** | `Ctrl + Left Click` | Right Click |

## 🛠 Troubleshooting

* **Script interfering with a game?**
    * Press **`F8`** to Suspend the script. Press again to Resume.
* **IntelliJ Shortcuts:**
    * Keep IntelliJ keymap set to **"Windows"**. The script handles the translation so you can use your thumb (Command key) naturally.
* **Terminal Copy/Paste not working?**
    * Ensure your Windows Terminal settings map `Copy` to `Ctrl+Shift+C` and `Paste` to `Ctrl+Shift+V` (this is default).

## 📄 License

MIT License. Copyright (c) 2026 Zjedz Mnie sp. z o.o.