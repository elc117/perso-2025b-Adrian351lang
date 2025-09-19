{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)

import Data.Char (isDigit, isUpper, isLower, toUpper)
import Data.List (intercalate)

import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as T

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

morseParse :: String -> Char
morseParse str
    | str == ".-"   = 'A'
    | str == "-..." = 'B'
    | str == "-.-." = 'C'
    | str == "-.."  = 'D'
    | str == "."    = 'E'
    | str == "..-." = 'F'
    | str == "--."  = 'G'
    | str == "...." = 'H'
    | str == ".."   = 'I'
    | str == ".---" = 'J'
    | str == "-.-"  = 'K'
    | str == ".-.." = 'L'
    | str == "--"   = 'M'
    | str == "-."   = 'N'
    | str == "---"  = 'O'
    | str == ".--." = 'P'
    | str == "--.-" = 'Q'
    | str == ".-."  = 'R'
    | str == "..."  = 'S'
    | str == "-"    = 'T'
    | str == "..-"  = 'U'
    | str == "...-" = 'V'
    | str == ".--"  = 'W'
    | str == "-..-" = 'X'
    | str == "-.--" = 'Y'
    | str == "--.." = 'Z'
    | str == ".----"= '1'
    | str == "..---"= '2'
    | str == "...--"= '3'
    | str == "....-"= '4'
    | str == "....."= '5'
    | str == "-...."= '6'
    | str == "--..."= '7'
    | str == "---.."= '8'
    | str == "----."= '9'
    | str == "-----"= '0'
    | str == "/"    = ' '
    | otherwise = error "código morse inválido"

getMorse :: Char -> String
getMorse ch
    | c == 'A' = ".-"
    | c == 'B' = "-..."
    | c == 'C' = "-.-."
    | c == 'D' = "-.."
    | c == 'E' = "."
    | c == 'F' = "..-."
    | c == 'G' = "--."
    | c == 'H' = "...."
    | c == 'I' = ".."
    | c == 'J' = ".---"
    | c == 'K' = "-.-"
    | c == 'L' = ".-.."
    | c == 'M' = "--"
    | c == 'N' = "-."
    | c == 'O' = "---"
    | c == 'P' = ".--."
    | c == 'Q' = "--.-"
    | c == 'R' = ".-."
    | c == 'S' = "..."
    | c == 'T' = "-"
    | c == 'U' = "..-"
    | c == 'V' = "...-"
    | c == 'W' = ".--"
    | c == 'X' = "-..-"
    | c == 'Y' = "-.--"
    | c == 'Z' = "--.."
    | c == '1' = ".----"
    | c == '2' = "..---"
    | c == '3' = "...--"
    | c == '4' = "....-"
    | c == '5' = "....."
    | c == '6' = "-...."
    | c == '7' = "--..."
    | c == '8' = "---.."
    | c == '9' = "----."
    | c == '0' = "-----"
    | c == ' ' = "/"
    | otherwise = error "caractere não disponível em morse"

    where
        c = toUpper ch

-- converte uma string em código morse para texto comum
-- separa as palavras (letras, em morse) e verifica cada uma
morseToText :: String -> String
morseToText str = map morseParse (words str) 

-- o inverso da de cima
textToMorse :: String -> String
textToMorse str = intercalate " " (map getMorse str)

main :: IO ()
main = scotty 3000 $ do
    middleware logStdoutDev

    -- sessão de conversão de bases
    -- acessar em http://localhost:3000/bases
    get "/bases" $ do
        let input  = "FFFF"
        let inputBase = 16
        let outputBase = 10

        let decimal = baseToDecimal inputBase input
        let result = decimalToBase outputBase decimal

        text $ T.append "Valor original: " input
        text $ T.append "Valor convertido: " result

    -- sessão de conversão de morse
    -- acessar em http://localhost:3000/morse
    get "/morse" $ do
        let morse = ". . / .-. ."
        text $ T.append "Morse original: " morse
        text $ T.append "Morse decodificado: " (morseToText morse)

    get "/" $ do
        html "<form action='/submit' method='post'><input name='userInput' type='text'><input type='submit'></form>"

    post "/submit" $ do
        userInput <- param "userInput" :: ActionM Text
        html $ mconcat ["You entered: ", userInput]