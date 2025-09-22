module Caesar where

import Data.Char (isAlpha, isUpper, isLower)

import SharedFuncs (letterPos, letterIn)

-- função que aplica o deslocamento de César a um caractere
-- fórmula: nova_posicao = (posicao_atual + deslocamento) % 26
caesarShift :: Char -> Int -> Char
caesarShift c shift
    | isAlpha c = letterIn ((letterPos c + shift) `mod` 26) -- se é uma letra, aplica o deslocamento
    | otherwise = c                                         -- senão, mantém caracteres não alfabéticos inalterados

caesar :: String -> Int -> String
caesar str shift = map (\c -> caesarShift c shift) str