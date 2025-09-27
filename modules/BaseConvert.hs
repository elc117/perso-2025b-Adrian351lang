module BaseConvert where

import Data.Char (isDigit, isUpper, isLower)

-- converte um número para sua representação em caractere (base64).
-- a base máxima é 64 porque (10 números + 26 letras maiúsculas + 26 letras minúsculas + 2 caracteres especiais = 64).
-- fromEnum pega o código ASCII do char, e toEnum faz o contrário
digitToBase :: Int -> Char
digitToBase n
    | n < 10    = toEnum (n + fromEnum '0')       -- converte  0-9  para '0'-'9'
    | n < 36    = toEnum (n + fromEnum 'A' - 10)  -- converte 10-35 para 'A'-'Z'
    | n < 62    = toEnum (n + fromEnum 'a' - 36)  -- converte 36-61 para 'a'-'z'
    | n == 62   = '+'                             -- caso especial: 62 representado por '+', como no sistema base64
    | n == 63   = '/'                             -- caso especial: 63 representado por '/', como no sistema base64
    | otherwise = error "base fora do raio: 2-64" -- base inválida

-- função inversa da de cima
baseToDigit :: Char -> Int
baseToDigit c
    | isDigit c = fromEnum c - fromEnum '0'
    | isUpper c = fromEnum c - fromEnum 'A' + 10
    | isLower c = fromEnum c - fromEnum 'a' + 36
    | c == '+'  = 62
    | c == '/'  = 63
    | otherwise = error "caractere inválido"

-- converte um número em string de uma determinada base para decimal.
-- recebe um inteiro representando a base e a string contendo o número a converter.
baseToDecimal :: Int -> String -> Int
baseToDecimal base number = sum [(base ^ weight) * baseToDigit digit | (digit, weight) <- zip (reverse number) [0..], baseToDigit digit < base]
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
        convert 0 = ""                           -- condição de parada para recursão
        convert x = let (q, r) = x `divMod` base -- divide e pega quociente e resto
                    in digitToBase r : convert q -- converte o resto para dígito e recursa com o quociente

-- observação: o operador ':' concatena char com string

-- converte um número em string de uma determinada base para outra base.
-- recebe a base de origem, a base de destino e o número em string.
-- usa baseToDecimal para converter para decimal e depois decimalToBase para converter para a nova base.
baseToBase :: String -> Int -> Int -> String
baseToBase number fromBase toBase
    | fromBase == toBase = number                                               -- se as bases são iguais, retorna o número original
    | fromBase == 10     = decimalToBase toBase (read number)                   -- se a base de origem é decimal, converte diretamente de decimal para a base de destino
    | toBase   == 10     = show (baseToDecimal fromBase number)                 -- se a base de destino é decimal, converte só para decimal
    | otherwise          = decimalToBase toBase (baseToDecimal fromBase number) -- caso padrão, converte para decimal e depois para a nova base
