module MorseFuncs where

import Data.Char (toUpper)
import Data.List (intercalate)

morseParse :: String -> Char
morseParse str
    | str == ".-"   = 'A'
    | str == "-..." = 'B'
    | str == "-.-." = 'C'
    | str == "-.."  = 'D'
    | str == "."    = 'E'
    | str == "..-." = 'F'
    | str == "--."  = 'G'
    | str == "...." = 'H'
    | str == ".."   = 'I'
    | str == ".---" = 'J'
    | str == "-.-"  = 'K'
    | str == ".-.." = 'L'
    | str == "--"   = 'M'
    | str == "-."   = 'N'
    | str == "---"  = 'O'
    | str == ".--." = 'P'
    | str == "--.-" = 'Q'
    | str == ".-."  = 'R'
    | str == "..."  = 'S'
    | str == "-"    = 'T'
    | str == "..-"  = 'U'
    | str == "...-" = 'V'
    | str == ".--"  = 'W'
    | str == "-..-" = 'X'
    | str == "-.--" = 'Y'
    | str == "--.." = 'Z'
    | str == ".----"= '1'
    | str == "..---"= '2'
    | str == "...--"= '3'
    | str == "....-"= '4'
    | str == "....."= '5'
    | str == "-...."= '6'
    | str == "--..."= '7'
    | str == "---.."= '8'
    | str == "----."= '9'
    | str == "-----"= '0'
    | str == "/"    = ' '
    | otherwise = '⍰' -- caractere para indicar erro

getMorse :: Char -> String
getMorse ch
    | c == 'A' = ".-"
    | c == 'B' = "-..."
    | c == 'C' = "-.-."
    | c == 'D' = "-.."
    | c == 'E' = "."
    | c == 'F' = "..-."
    | c == 'G' = "--."
    | c == 'H' = "...."
    | c == 'I' = ".."
    | c == 'J' = ".---"
    | c == 'K' = "-.-"
    | c == 'L' = ".-.."
    | c == 'M' = "--"
    | c == 'N' = "-."
    | c == 'O' = "---"
    | c == 'P' = ".--."
    | c == 'Q' = "--.-"
    | c == 'R' = ".-."
    | c == 'S' = "..."
    | c == 'T' = "-"
    | c == 'U' = "..-"
    | c == 'V' = "...-"
    | c == 'W' = ".--"
    | c == 'X' = "-..-"
    | c == 'Y' = "-.--"
    | c == 'Z' = "--.."
    | c == '1' = ".----"
    | c == '2' = "..---"
    | c == '3' = "...--"
    | c == '4' = "....-"
    | c == '5' = "....."
    | c == '6' = "-...."
    | c == '7' = "--..."
    | c == '8' = "---.."
    | c == '9' = "----."
    | c == '0' = "-----"
    | c == ' ' = "/"
    | otherwise = "⍰" -- caractere para indicar erro

    where
        c = toUpper ch

-- converte uma string em código morse para texto comum
-- separa as palavras (letras, em morse) e verifica cada uma
morseToText :: String -> String
morseToText str = map morseParse (words str) 

-- o inverso da de cima
-- intercala as letras em morse com espaço entre elas
textToMorse :: String -> String
textToMorse str = intercalate " " (map getMorse str)