import BaseConvert
import MorseFuncs
import Caesar
import Romans
import Vigenere

import Test.HUnit

baseTest :: Test
baseTest = TestCase $ do
    assertEqual "FFFF(16) -> 65535(10)" (baseToDecimal 16 "FFFF") 65535
    assertEqual "42(10) -> 101010(2)" (decimalToBase 2 42) "101010"
    assertEqual "3A(16) -> 111010(2)" (decimalToBase 2 (baseToDecimal 16 "3A")) "111010"
    assertEqual "1111011011(2) -> 3DB(16)" (decimalToBase 16 (baseToDecimal 2 "1111011011")) "3DB"

morseTest :: Test
morseTest = TestCase $ do
    assertEqual "morse code -> -- --- .-. ... . / -.-. --- -.. ." (textToMorse "morse code") "-- --- .-. ... . / -.-. --- -.. ."
    assertEqual "-- --- .-. ... . / -.-. --- -.. . -> morse code" (morseToText "-- --- .-. ... . / -.-. --- -.. .") "MORSE CODE"

caesarTest :: Test
caesarTest = TestCase $ do
    assertEqual "ATTACKATONCE (4) -> EXXEGOEXSRGI" (caesar "ATTACKATONCE" 4) "EXXEGOEXSRGI"
    assertEqual "EXXEGOEXSRGI (-4) -> ATTACKATONCE" (caesar "EXXEGOEXSRGI" (-4)) "ATTACKATONCE"

romansTest :: Test
romansTest = TestCase $ do
    assertEqual "123 -> CXXIII" (toRoman 123) "CXXIII"
    assertEqual "CXXIII -> 123" (fromRoman "CXXIII") 123

vigenereTest :: Test
vigenereTest = TestCase $ do
    assertEqual "GEEKSFORGEEKS (AYUSH) -> GCYCZFMLYLEIM" (toVigenere "GEEKSFORGEEKS" "AYUSH") "GCYCZFMLYLEIM"
    assertEqual " GCYCZFMLYLEIM (AYUSH) -> GEEKSFORGEEKS" (fromVigenere "GCYCZFMLYLEIM" "AYUSH") "GEEKSFORGEEKS"

testes :: Test
testes =
    TestList [
        baseTest,
        morseTest,
        caesarTest,
        romansTest,
        vigenereTest
    ]

main :: IO()
main = do
    putStrLn "Rodando os testes..."
    runTestTT testes
    return ()

    -- putStrLn "Digite o texto a decodificar com a cifra de Vigenère (somente letras serão alteradas):"
    -- codedText <- getLine
    -- putStrLn "Digite a chave (somente letras):"
    -- key <- getLine
    -- putStrLn $ "Texto original: " ++ codedText
    -- putStrLn $ "Texto decodificado com Vigenère: " ++ (fromVigenere codedText key) ++ "\nchave: " ++ key

    -- putStrLn "Digite o texto a codificar com a cifra de Vigenère (somente letras serão alteradas):"
    -- rawText <- getLine
    -- putStrLn "Digite a chave (somente letras):"
    -- key <- getLine
    -- putStrLn $ "Texto original: " ++ rawText
    -- putStrLn $ "Texto criptografado com Vigenère: " ++ (toVigenere rawText key) ++ "\nchave: " ++ key

    -- putStrLn "Digite o número inteiro a converter para numeral romano (máximo 3999):"
    -- num <- readLn
    -- putStrLn $ "Número original: " ++ (show num)
    -- putStrLn $ "Número em romano: " ++ (toRoman num)

    -- putStrLn "Digite o número em romanos a converter para inteiro: (letras maiúsculas)"
    -- roman <- getLine
    -- putStrLn $ "Número em inteiro: " ++ (show $ fromRoman roman)

    -- putStrLn "Digite o texto a criptografar com a cifra de césar (somente letras serão alteradas):"
    -- raw <- getLine
    -- putStrLn "Digite o número de deslocamento (positivo para criptografar, negativo para descriptografar):"
    -- shift <- readLn
    -- putStrLn $ "Texto original: " ++ raw
    -- putStrLn $ "Texto criptografado: " ++ (caesar raw shift) ++ ", deslocamento: " ++ (show shift)

    -- putStrLn "Digite o número a converter (caracteres válidos: (0-9), (A-Z), (a-z), '+', '/'):"
    -- input <- getLine
    -- putStrLn "Digite a base do número de entrada (2-64):"
    -- inputBase <- readLn
    -- putStrLn "Digite a base do número de saída (2-64):"
    -- outputBase <- readLn

    -- let decimal = baseToDecimal inputBase input
    -- let result = decimalToBase outputBase decimal

    -- putStrLn $ "Valor original: " ++ input ++ " (base " ++ (show inputBase) ++ ")"
    -- putStrLn $ "Valor convertido: " ++ result ++ " (base " ++ (show outputBase) ++ ")"

    -- putStrLn "Digite o texto em morse (separar letras por espaços simples e palavras por barras):"
    -- morse <- getLine
    -- putStrLn $ "Morse original: " ++ morse
    -- putStrLn $ "Morse decodificado: " ++ (morseToText morse)

    -- putStrLn "Digite o texto a converter para morse:"
    -- text <- getLine
    -- putStrLn $ "Texto original: " ++ text
    -- putStrLn $ "Texto em morse: " ++ (textToMorse text)
