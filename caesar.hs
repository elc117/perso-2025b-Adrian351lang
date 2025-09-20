module Caesar where

import Data.Char (toUpper, isAlpha, isUpper, isLower)

-- função auxiliar para pegar a posição da letra no alfabeto (A=0, B=1, ..., Z=25)
letterPos :: Char -> Int
letterPos c
    | isUpper c = fromEnum c - fromEnum 'A'
    | isLower c = fromEnum c - fromEnum 'a'
    | otherwise = error "não é letra"

-- função que aplica o deslocamento de César a um caractere
-- fórmula: nova_posicao = (posicao_atual + deslocamento) % 26
caesarShift :: Char -> Int -> Char
caesarShift c shift
    | isAlpha c = toEnum ((letterPos c + shift) `mod` 26 + fromEnum 'A')
    | otherwise = error "caractere inválido, apenas letras alfabéticas são suportadas"

caesar :: String -> Int -> String
caesar str shift = map (\c -> caesarShift c shift) str