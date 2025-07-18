#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

YandexSend(button) {
    static chromeWin := "Chrome"

    if WinExist(chromeWin) {
        try {
            if !WinActive(chromeWin) {
                WinActivate(chromeWin)
                WinWaitActive(chromeWin)
                Send("^2")
                Send(button)
                WinMinimize(chromeWin)
            } else {
                Send("^2")
                Send(button)
            }
        } catch as e {
            MsgBox("Ошибка: " e.Message)
        }
    } else {
        MsgBox("Chrome window is not found")
    }
}

Hotkey("+F4", (*) => YandexSend("{f}"))
Hotkey("+F5", (*) => YandexSend("{r}"))