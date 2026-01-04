# macOS Keybindings for Windows (AHK V20)

This AutoHotkey v2 script remaps Windows keys to match macOS behavior. It is specifically optimized for developers using **IntelliJ/VS Code** and users of **Logitech MX Keys**.

## ⌨️ 1. Hardware Setup (Logitech MX Keys)
For the F-keys to function as described (F3 for Mission Control, F7-12 for Media), you must set your keyboard to **Standard F-Keys mode**.

1.  Locate the **Esc** key.
2.  Press **`Fn + Esc`** once to toggle the lock.
3.  **Result:** The keyboard should now send standard F1-F12 signals. The script will programmatically convert them back to Media keys where appropriate.

## 🚀 2. Installation (GitHub ZIP / Portable)
You do not need a full system installation. You can run this from a folder.

1.  Go to the **[AutoHotkey GitHub Releases](https://github.com/AutoHotkey/AutoHotkey/releases)** page.
2.  Download the latest **`.zip`** file (e.g., `AutoHotkey_2.0.x.zip`).
3.  Extract the ZIP contents to a folder on your computer.
4.  Download the `mac_ultimate_v20.ahk` script and place it in that folder.
5.  **Run the script:**
    * **Option A:** Drag and drop `mac_ultimate_v20.ahk` onto **`AutoHotkey64.exe`**.
    * **Option B (Recommended):** Right-click `AutoHotkey64.exe` -> **Run as Administrator**, then browse and select the script.
    * *Note: Administrator rights are required to override system shortcuts like Win+F (Search) and Win+C (Copilot).*

## ⚡ 3. Key Mappings & Features

### System & Modifiers
| Key | Action |
| :--- | :--- |
| **Cmd (⌘)** | Acts as **Control**. |
| **Control (⌃)** | Acts as **Windows Key** (Start Menu blocked on simple tap). |
| **Cmd + Space** | Start Menu. |
| **Cmd + Tab** | Alt + Tab. |
| **Cmd + Q** | Quit Application (`Alt + F4`). |
| **Cmd + M** | Minimize Window. |

### F-Row (Hybrid Mode)
| Key | Action |
| :--- | :--- |
| **F3** | Mission Control (Task View). |
| **F4** | Launchpad (Start Menu). |
| **F7 - F9** | Media: Prev, Play/Pause, Next. |
| **F10 - F12** | Volume: Mute, Down, Up. |

### IDEs (IntelliJ / VS Code)
*Overrides Windows system shortcuts to prevent conflicts.*
* **Cmd + Shift + F**: Find in Files (Blocks Windows Web Search).
* **Cmd + F**: Find (Blocks Windows Feedback Hub).
* **Cmd + C**: Copy (Blocks Windows Copilot).
* **Cmd + /**: Comment Line.
* **Cmd + 1**: Project View.
* **Cmd + Backtick (`):** Open Terminal.

### Finder Navigation (Windows Explorer)
* **Cmd + ↓**: Open file/folder.
* **Cmd + ↑**: Go to parent folder.
* **Cmd + [** or **Cmd + ←**: Back.
* **Cmd + ]** or **Cmd + →**: Forward.
* **Enter**: Rename file.
* **Cmd + Backspace**: Delete file to Recycle Bin.
* **Cmd + Shift + N**: Create New Folder.

### Text Navigation (Global)
* **Cmd + Arrows**: Jump to Start/End of line or Top/Bottom of file.
* **Option (Alt) + Arrows**: Jump by Word.
* **Cmd + Backspace**: Delete current line.
* **Option + Backspace**: Delete previous word.

### Browsers (Chrome / Edge / Firefox)
* **Cmd + L**: Highlight Address Bar.
* **Cmd + T**: New Tab.
* **Cmd + Shift + T**: Reopen Closed Tab.
* **Cmd + R**: Refresh.
* **Cmd + Opt + I**: Developer Tools (F12).

### Screenshots
* **Cmd + Shift + 3**: Print Screen.
* **Cmd + Shift + 4**: Snipping Tool.