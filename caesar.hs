module Caesar where

import Data.Char (toUpper, isAlpha)

-- desloca a letra se for alfabética, senão dá erro
tryShift :: Char -> Int -> Char
tryShift c shift
    | isAlpha c = toEnum (fromEnum (toUpper c) + shift) -- se for letra, converte para minúscula e faz o deslocamento
    | otherwise = error "caractere inválido, apenas letras alfabéticas são suportadas"

-- deslocamento das letras conforme a cifra de césar
caesarShift :: Char -> Int -> Char
caesarShift c shift
    | fromEnum shifted > fromEnum 'Z' = toEnum (fromEnum shifted - fromEnum 26) -- caso passe de 'z', considera que 'a' vem depois de 'z' e volta para trás
    | fromEnum shifted < fromEnum 'A' = toEnum (fromEnum shifted + fromEnum 26) -- mesma coisa, mas para se for para trás de 'a'
    | otherwise = shifted

    -- faz o deslocamento conforme e número que foi passado
    where
        shifted = tryShift c shift

caesar :: String -> Int -> String
caesar str shift = map (\c -> caesarShift c shift) str