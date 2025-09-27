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
    assertEqual "3A(16) -> 111010(2)" (baseToBase "3A" 16 2) "111010"
    assertEqual "1111011011(2) -> 3DB(16)" (baseToBase "1111011011" 2 16) "3DB"

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
