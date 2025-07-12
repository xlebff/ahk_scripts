#Requires AutoHotkey v2.0
#SingleInstance Force

DetectHiddenWindows("On")
SetTitleMatchMode(2)

; отправка кнопок на яндекс музыку
YandexSend(button) 
{
    if WinExist("Chrome") {
        if !WinActive("Chrome") {
            WinActivate
            WinWaitActive
            Send("^2")
            Send(button)
            WinMinimize
        } else {
            Send("^2")
            Send(button)
        }
    }
}

OpenCheck(name, path)
{
    if !WinExist(name) {
        Run(path)
    } else if !WinActive(path) {
        WinActivate(name)
    }
}

; медиа
+F1:: Send("{Media_Prev}")
+F2:: Send("{Media_Play_Pause}")
+F3:: Send("{Media_Next}")

; понравившиеся
+F4::
{
    YandexSend("{f}")
}
 
; повтор
+F5::
{
    YandexSend("{r}")
}

; chrome
^F1::
{
    OpenCheck("Chrome", "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")
}

; telegram
ActivateTelegram() {
    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        whr.Open("POST", "http://localhost:23984/api/activate", true)
        whr.Send()
        whr.WaitForResponse()
        return (whr.Status = 200)
    }
    catch {
        Run("tg://")
        Sleep(1000)
        return WinExist("ahk_exe Telegram.exe")
    }
}

^F2::
{
    if WinExist("Telegram") {
        ActivateTelegram()
    } else {
        Run("D:\Program Files\Telegram Desktop\Telegram.exe")
    }
}

; obsidian
^F3::
{
    OpenCheck("Obsidian", "D:\Program Files\Obsidian\Obsidian.exe")
}

; steam
^F4::
{
    OpenCheck("Steam", "D:\Program Files\Steam\steam.exe")
}


enToRu := Map(
    "q", "й", "w", "ц", "e", "у", "r", "к", "t", "е", "y", "н", "u", "г", "i", "ш", "o", "щ", "p", "з",
    "[", "х", "]", "ъ", "a", "ф", "s", "ы", "d", "в", "f", "а", "g", "п", "h", "р", "j", "о", "k", "л",
    "l", "д", ";", "ж", "'", "э", "z", "я", "x", "ч", "c", "с", "v", "м", "b", "и", "n", "т", "m", "ь",
    ",", "б", ".", "ю", "/", ".", "``", "ё",
    "Q", "Й", "W", "Ц", "E", "У", "R", "К", "T", "Е", "Y", "Н", "U", "Г", "I", "Ш", "O", "Щ", "P", "З",
    "{", "Х", "}", "Ъ", "A", "Ф", "S", "Ы", "D", "В", "F", "А", "G", "П", "H", "Р", "J", "О", "K", "Л",
    "L", "Д", ":", "Ж", '"', "Э", "Z", "Я", "X", "Ч", "C", "С", "V", "М", "B", "И", "N", "Т", "M", "Ь",
    "<", "Б", ">", "Ю", "?", ",", "~", "Ё"
)

ruToEn := Map()

for en, ru in enToRu
    ruToEn[ru] := en

#^Space::
{
    oldClipboard := A_Clipboard
    A_Clipboard := ""
    Send "^c"
    ClipWait

    newText := ""
    for char in StrSplit(A_Clipboard) {
        if enToRu.Has(char)
            newText .= enToRu[char]
        else if ruToEn.Has(char)
            newText .= ruToEn[char]
        else
            newText .= char
    }

    A_Clipboard := newText
    ClipWait
    Send "^v"
    ToolTip newText
    Sleep 1000
    ToolTip
}