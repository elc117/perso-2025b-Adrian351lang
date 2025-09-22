module Vigenere where

import Data.Char (isAlpha)

import sharedFuncs (letterPos, letterIn)

-- cifra um único caractere usando a cifra de Vigenère
toVigenereChar :: Char -> Char -> Char
toVigenereChar textChar keyChar
    | isAlpha textChar && isAlpha keyChar = letterIn ((letterPos textChar + letterPos keyChar) `mod` 26) -- aplica a cifra
    | otherwise = textChar -- mantém caracteres não alfabéticos inalterados

-- codifica um texto usando a cifra de Vigenère com uma chave
toVigenere :: String -> String -> String
toVigenere text key = map (\(textChar, keyChar) -> toVigenereChar textChar keyChar) (zip text extendedKey)
    where
        extendedKey = take (length text) (cycle key) -- extende a chave para o tamanho do texto

fromVigenereChar :: Char -> Char -> Char
fromVigenereChar cipherChar keyChar
    | isAlpha cipherChar && isAlpha keyChar = letterIn ((letterPos cipherChar - letterPos keyChar + 26) `mod` 26) -- aplica a decifra
    | otherwise = cipherChar -- mantém caracteres não alfabéticos inalterados

fromVigenere :: String -> String -> String
fromVigenere cipherText key = map (\(cipherChar, keyChar) -> fromVigenereChar cipherChar keyChar) (zip cipherText extendedKey)
    where
        extendedKey = take (length cipherText) (cycle key) -- extende a chave para o tamanho do texto