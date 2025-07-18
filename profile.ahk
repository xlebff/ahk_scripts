#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon
#Include pathes.ahk

DetectHiddenWindows(true)
SetTitleMatchMode(2)

class AppManager {
    static OpenCheck(name, path, isUri := false) {
        if !WinExist(name) {
            Run(path)
            return false
        }
        
        if !WinActive(name) {
            if !isUri {
                try {
                    WinActivate(name)
                    WinWaitActive(name,, 1)
                } catch {
                    Run(path)
                }
            } else {
                Run(path)
            }
        }
        return true
    }
}

HotIfWinActive()
^F1:: AppManager.OpenCheck("Chrome", chrome)
^F2:: AppManager.OpenCheck("Telegram", telegram, true)
^F3:: AppManager.OpenCheck("Obsidian", obsidian)
^F4:: AppManager.OpenCheck("Steam", steam, true)
^F5:: AppManager.OpenCheck("Discord", discord, true)