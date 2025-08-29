#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

CheckCurrentSetting() {
    try {
        currentValue := RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
            "Hidden")
        return currentValue
    } catch Error as e {
        MsgBox "Не удалось прочитать значение реестра: " e.Message
        return 0
    }
}

^!p:: {
    if CheckCurrentSetting() != 0 {
        newValue := CheckCurrentSetting() = 2 ? 1 : 2
        RegWrite newValue, "REG_DWORD",
            "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
            "Hidden"
        Send("{F5}")
    }
}
