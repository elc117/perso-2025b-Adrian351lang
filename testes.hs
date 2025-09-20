import BaseConvert
import MorseFuncs
import Caesar

main :: IO()
main = do
    putStrLn "Digite o texto a criptografar com a cifra de césar (somente letras e espaços):"
    raw <- getLine
    putStrLn "Digite o número de deslocamento (positivo para direita, negativo para esquerda):"
    shift <- readLn
    putStrLn $ "Texto original: " ++ raw
    putStrLn $ "Texto criptografado: " ++ (caesar raw shift) ++ ", deslocamento: " ++ (show shift)

    putStrLn "Digite o número a converter (caracteres válidos: (0-9), (A-Z), (a-z), '+', '/'):"
    input <- getLine
    putStrLn "Digite a base do número de entrada (2-64):"
    inputBase <- readLn
    putStrLn "Digite a base do número de saída (2-64):"
    outputBase <- readLn

    let decimal = baseToDecimal inputBase input
    let result = decimalToBase outputBase decimal

    putStrLn $ "Valor original: " ++ input ++ " (base " ++ (show inputBase) ++ ")"
    putStrLn $ "Valor convertido: " ++ result ++ " (base " ++ (show outputBase) ++ ")"

    putStrLn "Digite o texto em morse (separar letras por espaços simples e palavras por barras):"
    morse <- getLine
    putStrLn $ "Morse original: " ++ morse
    putStrLn $ "Morse decodificado: " ++ (morseToText morse)

    putStrLn "Digite o texto a converter para morse:"
    text <- getLine
    putStrLn $ "Texto original: " ++ text
    putStrLn $ "Texto em morse: " ++ (textToMorse text)