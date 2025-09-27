module MorseFuncs where

import Data.Char (toUpper)
import Data.List (intercalate)

morseParse :: String -> Char
morseParse code
    | code == ".-"    = 'A'
    | code == "-..."  = 'B'
    | code == "-.-."  = 'C'
    | code == "-.."   = 'D'
    | code == "."     = 'E'
    | code == "..-."  = 'F'
    | code == "--."   = 'G'
    | code == "...."  = 'H'
    | code == ".."    = 'I'
    | code == ".---"  = 'J'
    | code == "-.-"   = 'K'
    | code == ".-.."  = 'L'
    | code == "--"    = 'M'
    | code == "-."    = 'N'
    | code == "---"   = 'O'
    | code == ".--."  = 'P'
    | code == "--.-"  = 'Q'
    | code == ".-."   = 'R'
    | code == "..."   = 'S'
    | code == "-"     = 'T'
    | code == "..-"   = 'U'
    | code == "...-"  = 'V'
    | code == ".--"   = 'W'
    | code == "-..-"  = 'X'
    | code == "-.--"  = 'Y'
    | code == "--.."  = 'Z'
    | code == ".----" = '1'
    | code == "..---" = '2'
    | code == "...--" = '3'
    | code == "....-" = '4'
    | code == "....." = '5'
    | code == "-...." = '6'
    | code == "--..." = '7'
    | code == "---.." = '8'
    | code == "----." = '9'
    | code == "-----" = '0'
    | code == "/"     = ' '
    | otherwise = '⍰' -- caractere para indicar erro

getMorse :: Char -> String
getMorse c
    | cup == 'A' = ".-"
    | cup == 'B' = "-..."
    | cup == 'C' = "-.-."
    | cup == 'D' = "-.."
    | cup == 'E' = "."
    | cup == 'F' = "..-."
    | cup == 'G' = "--."
    | cup == 'H' = "...."
    | cup == 'I' = ".."
    | cup == 'J' = ".---"
    | cup == 'K' = "-.-"
    | cup == 'L' = ".-.."
    | cup == 'M' = "--"
    | cup == 'N' = "-."
    | cup == 'O' = "---"
    | cup == 'P' = ".--."
    | cup == 'Q' = "--.-"
    | cup == 'R' = ".-."
    | cup == 'S' = "..."
    | cup == 'T' = "-"
    | cup == 'U' = "..-"
    | cup == 'V' = "...-"
    | cup == 'W' = ".--"
    | cup == 'X' = "-..-"
    | cup == 'Y' = "-.--"
    | cup == 'Z' = "--.."
    | cup == '1' = ".----"
    | cup == '2' = "..---"
    | cup == '3' = "...--"
    | cup == '4' = "....-"
    | cup == '5' = "....."
    | cup == '6' = "-...."
    | cup == '7' = "--..."
    | cup == '8' = "---.."
    | cup == '9' = "----."
    | cup == '0' = "-----"
    | cup == ' ' = "/"
    | otherwise = "⍰" -- caractere para indicar erro

    where
        cup = toUpper c

-- converte uma string em código morse para texto comum
-- separa as palavras (letras, em morse) e verifica cada uma
morseToText :: String -> String
morseToText str = map morseParse (words str)

-- o inverso da de cima
-- intercala as letras em morse com espaço entre elas
textToMorse :: String -> String
textToMorse str = intercalate " " (map getMorse str)
