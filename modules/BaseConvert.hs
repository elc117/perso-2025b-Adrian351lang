module BaseConvert where

import Data.Char (isDigit, isUpper, isLower)

-- converte um número para sua representação em caracter (base64).
-- a base máxima é 64 porque (10 números + 26 letras maiúsculas + 26 letras minúsculas + 2 caracteres especiais = 64).
-- fromEnum pega o código ASCII do char, e toEnum faz o contrário
intToBase64 :: Int -> Char
intToBase64 n
    | n < 10    = toEnum (n + fromEnum '0')       -- converte  0-9  para '0'-'9'
    | n < 36    = toEnum (n + fromEnum 'A' - 10)  -- converte 10-35 para 'A'-'Z'
    | n < 62    = toEnum (n + fromEnum 'a' - 36)  -- converte 36-61 para 'a'-'z'
    | n == 62   = '+'                             -- caso especial: 62 representado por '+', como no sistema base64
    | n == 63   = '/'                             -- caso especial: 63 representado por '/', como no sistema base64
    | otherwise = error "base fora do raio: 2-64" -- base inválida

-- função inversa da de cima
base64toInt :: Char -> Int
base64toInt c
    | isDigit c = fromEnum c - fromEnum '0'
    | isUpper c = fromEnum c - fromEnum 'A' + 10
    | isLower c = fromEnum c - fromEnum 'a' + 36
    | c == '+'  = 62
    | c == '/'  = 63
    | otherwise = error "caractere inválido"

-- converte um número em string de uma determinada base para decimal.
-- recebe um inteiro representando a base e a string contendo o número a converter.
baseToDecimal :: Int -> String -> Int
baseToDecimal base number = sum [(base ^ weight) * base64toInt digit | (digit, weight) <- zip (reverse number) [0..], base64toInt digit < base]
-- fórmula: soma(base ^ peso * dígito; do dígito menos significativo ao mais significativo)
-- "zip" agrupa cada caracter com o seu peso correspondente.
-- "reverse number" é para numerar o dígito MENOS significativo primeiro.
-- "base64toInt digit" converte o dígito para inteiro.
-- a soma acumula o valor total em decimal.

-- converte um número decimal para um número em string de uma determinada base.
-- recebe a base e o número decimal.
-- método das divisões sucessivas.
-- convert é recursivo.
decimalToBase :: Int -> Int -> String
decimalToBase base 0 = "0"                       -- caso especial para zero
decimalToBase base n = reverse (convert n)       -- inverte o resultado para ficar na ordem correta
    where
        convert 0 = ""                           -- caso base para recursão
        convert x = let (q, r) = x `divMod` base -- divide e pega quociente e resto
                    in intToBase64 r : convert q -- converte o resto para dígito e recursa com o quociente
