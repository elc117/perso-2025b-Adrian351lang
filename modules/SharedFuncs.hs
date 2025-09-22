-- funções que se compartilham com outros módulos

module SharedFuncs where

import Data.Char (isUpper, isLower)

-- função auxiliar para pegar a posição da letra no alfabeto (A=0, B=1, ..., Z=25)
letterPos :: Char -> Int
letterPos c
    | isUpper c = fromEnum c - fromEnum 'A'
    | isLower c = fromEnum c - fromEnum 'a'
    | otherwise = error "caractere inválido, apenas letras alfabéticas são suportadas"

-- busca a letra correspondente à posição no alfabeto (0=A, 1=B, ..., 25=Z)
letterIn :: Int -> Char
letterIn i
    | i >= 0 && i < 26 = toEnum (i + fromEnum 'A')
    | otherwise = error "índice fora do intervalo"