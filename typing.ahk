#Requires AutoHotkey v2.0
#NoTrayIcon
#SingleInstance Force

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

toUp := Map(
    "0", "⁰", "1", "¹", "2", "²", "3", "³", "4", "⁴", "5", "⁵", "6", "⁶", "7", "⁷", "8", "⁸", "9", "⁹", 
    "+", "⁺", "-", "⁻", "=", "⁼", "(", "⁽", ")", "⁾", ".", "⋅",
    "a", "ᵃ", "b", "ᵇ", "c", "ᶜ", "d", "ᵈ", "e", "ᵉ", "f", "ᶠ", "g", "ᵍ", "h", "ʰ", "i", "ⁱ", "j", "ʲ", "k", "ᵏ", "l", "ˡ", "m", "ᵐ", "n", "ⁿ", "o", "ᵒ", "p", "ᵖ", "q", "ᑫ", "r", "ʳ", "s", "ˢ", "t", "ᵗ", "u", "ᵘ", "v", "ᵛ", "w", "ʷ", "x", "ˣ", "y", "ʸ", "z", "ᶻ",

    "₀", "⁰", "₁", "¹", "₂", "²", "₃", "³", "₄", "⁴", "₅", "⁵", "₆", "⁶", "₇", "⁷", "₈", "⁸", "₉", "⁹",
    "₊", "⁺", "₋", "⁻", "₌", "⁼", "₍", "⁽", "₎", "⁾", 
    "ₐ", "ᵃ", "ₑ", "ᵉ", "ₕ", "ʰ", "ᵢ", "ⁱ", "ⱼ", "ʲ", "ₖ", "ᵏ", "ₗ", "ˡ", "ₘ", "ᵐ", "ₙ", "ⁿ", "ₒ", "ᵒ", "ₚ", "ᵖ", "ᵣ", "ʳ", "ₛ", "ˢ", "ₜ", "ᵗ", "ᵤ", "ᵘ", "ᵥ", "ᵛ", "ₓ", "ˣ"
)

toLow := Map(
    "0", "₀", "1", "₁", "2", "₂", "3", "₃", "4", "₄", "5", "₅", "6", "₆", "7", "₇", "8", "₈", "9", "₉", 
    "+", "₊", "-", "₋", "=", "₌", "(", "₍", ")", "₎", 
    "a", "ₐ","e", "ₑ", "h", "ₕ", "i", "ᵢ", "j", "ⱼ", "k", "ₖ", "l", "ₗ", "m", "ₘ", "n", "ₙ", "o", "ₒ", "p", "ₚ", "r", "ᵣ", "s", "ₛ", "t", "ₜ", "u", "ᵤ", "v", "ᵥ", "x", "ₓ", 
    
    "⁰", "₀", "¹", "₁", "²", "₂", "³", "₃", "⁴", "₄", "⁵", "₅", "⁶", "₆", "⁷", "₇", "⁸", "₈", "⁹", "₉", 
    "⁺", "₊", "⁻", "₋", "⁼", "₌", "⁽", "₍", "⁾", "₎",
    "ᵃ", "ₐ", "ᵉ", "ₑ", "ʰ", "ₕ", "ⁱ", "ᵢ", "ʲ", "ⱼ", "ᵏ", "ₖ", "ˡ", "ₗ", "ᵐ", "ₘ", "ⁿ", "ₙ", "ᵒ", "ₒ", "ᵖ", "ₚ", "ʳ", "ᵣ", "ˢ", "ₛ", "ᵗ", "ₜ", "ᵘ", "ᵤ", "ᵛ", "ᵥ", "ˣ", "ₓ"
)

ClipboardCopy() {
    oldClipboard := A_Clipboard
    A_Clipboard := ""
    Send "^c"
    ClipWait
    return oldClipboard
}

ClipboardPaste(newText, oldClipboard, isToolTip) {
    A_Clipboard := newText
    ClipWait
    Send "^v"

    if isToolTip
        ToolTip newText

    Sleep 1000
    ToolTip
    A_Clipboard := oldClipboard
}

#^Space:: {
    oldClipboard := ClipboardCopy()

    newText := ""
    for char in StrSplit(A_Clipboard) {
        if enToRu.Has(char)
            newText .= enToRu[char]
        else if ruToEn.Has(char)
            newText .= ruToEn[char]
        else
            newText .= char
    }

    ClipboardPaste(newText, oldClipboard, true)
}

!-:: {
    oldClipboard := ClipboardCopy()

    newText := ""
    for char in StrSplit(A_Clipboard) {
        if toLow.Has(char)
            newText .= toLow[char]
        else
            newText .= char
    }

    ClipboardPaste(newText, oldClipboard, true)
}

!=:: {
    oldClipboard := ClipboardCopy()

    newText := ""
    for char in StrSplit(A_Clipboard) {
        if toUp.Has(char)
            newText .= toUp[char]
        else
            newText .= char
    }

    ClipboardPaste(newText, oldClipboard, true)
}