module Caesar where

import Data.Char (isAlpha, isUpper, isLower)

-- função auxiliar para pegar a posição da letra no alfabeto (A=0, B=1, ..., Z=25)
letterPos :: Char -> Int
letterPos c
    | isUpper c = fromEnum c - fromEnum 'A'
    | isLower c = fromEnum c - fromEnum 'a'
    | otherwise = error "não é letra"

-- busca a letra correspondente à posição no alfabeto (0=A, 1=B, ..., 25=Z)
letterIn :: Int -> Char
letterIn i
    | i >= 0 && i < 26 = toEnum (i + fromEnum 'A')
    | otherwise = error "índice fora do intervalo"

-- função que aplica o deslocamento de César a um caractere
-- fórmula: nova_posicao = (posicao_atual + deslocamento) % 26
caesarShift :: Char -> Int -> Char
caesarShift c shift
    | isAlpha c = letterIn ((letterPos c + shift) `mod` 26)
    | otherwise = error "caractere inválido, apenas letras alfabéticas são suportadas"

caesar :: String -> Int -> String
caesar str shift = map (\c -> caesarShift c shift) str