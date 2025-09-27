module Romans where

import Data.Char (toUpper)
import Data.List (group)

-- converte os milhares
thousandToRoman:: Int -> String
thousandToRoman d
  | d == 0 = ""
  | d == 1 = "M"
  | d == 2 = "MM"
  | d == 3 = "MMM"
  | otherwise = "⍰" -- caso especial para números maiores que 3999, que não possuem representação em numeral romano tradicional

-- converte as centenas
hundredToRoman:: Int -> String
hundredToRoman d
  | d == 0 = ""
  | d == 1 = "C"
  | d == 2 = "CC"
  | d == 3 = "CCC"
  | d == 4 = "CD"
  | d == 5 = "D"
  | d == 6 = "DC"
  | d == 7 = "DCC"
  | d == 8 = "DCCC"
  | d == 9 = "CM"

-- converte as dezenas
tenToRoman:: Int -> String
tenToRoman d
  | d == 0 = ""
  | d == 1 = "X"
  | d == 2 = "XX"
  | d == 3 = "XXX"
  | d == 4 = "XL"
  | d == 5 = "L"
  | d == 6 = "LX"
  | d == 7 = "LXX"
  | d == 8 = "LXXX"
  | d == 9 = "XC"

-- converte as unidades
unitToRoman:: Int -> String
unitToRoman d
  | d == 0 = ""
  | d == 1 = "I"
  | d == 2 = "II"
  | d == 3 = "III"
  | d == 4 = "IV"
  | d == 5 = "V"
  | d == 6 = "VI"
  | d == 7 = "VII"
  | d == 8 = "VIII"
  | d == 9 = "IX"

-- converte um numero inteiro para o numeral romano (máximo 3999)
-- separa o numero em milhares, centenas, dezenas e unidades
toRoman:: Int -> String
toRoman num
    | num < 4000 = thousandToRoman thousands ++ hundredToRoman hundreds ++ tenToRoman tens ++ unitToRoman units
    | otherwise = "⍰" -- caso especial para números maiores que 3999, que não possuem representação em numeral romano tradicional

    where
        thousands = num `mod` 10000 `div` 1000
        hundreds  = num `mod` 1000 `div` 100
        tens      = num `mod` 100 `div` 10
        units     = num `mod` 10

-- converte um caractere romano para um numero inteiro
romanCharToInt:: Char -> Int
romanCharToInt c
    | c == 'I' = 1
    | c == 'V' = 5
    | c == 'X' = 10
    | c == 'L' = 50
    | c == 'C' = 100
    | c == 'D' = 500
    | c == 'M' = 1000
    | otherwise = 0 -- caso especial para caractere inválido

-- verifica se deve somar ou subtrair o valor do caractere romano
fromRomanChar:: Char -> Char -> Int
fromRomanChar c next
    | cup == 'I' && (next == 'V' || next == 'X') = -1   -- caso especial de subtração, ex: IV = 4, IX = 9
    | cup == 'X' && (next == 'L' || next == 'C') = -10
    | cup == 'C' && (next == 'D' || next == 'M') = -100
    | otherwise = romanCharToInt cup

    where
        cup = toUpper c

-- verifica se todos os caracteres são letras romanas válidas
isValidRomanLetters :: String -> Bool
isValidRomanLetters str = all (`elem` "IVXLCDM") (map toUpper str)

-- verifica se há mais de 3 letras iguais consecutivas
noLetterOverrepetition :: String -> Bool
noLetterOverrepetition str = not $ any (>= 4) (map length (group (map toUpper str)))
-- a função group agrupa letras iguais consecutivas, exemplo: "XXIIX" -> ["XX","II","X"]
-- e então map length conta o tamanho de cada grupo, exemplo: ["XX","II","X"] -> [2,2,1]
-- por fim, any (>= 4) verifica se há algum grupo com 4 ou mais letras iguais consecutivas

-- converte uma string de numeral romano para um número inteiro
fromRoman :: String -> Int
fromRoman str
    | not (isValidRomanLetters str) = 0 -- retorna 0 se houver caractere inválido
    | not (noLetterOverrepetition str) = 0
    | otherwise = sum (map (\(c, next) -> fromRomanChar c next) pairs)

    where
        pairs = zip str (tail str ++ " ") -- emparelha cada caractere com o próximo. exemplo: "XIV" -> [('X','I'),('I','V'),('V',' ')]
