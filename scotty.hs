{-# LANGUAGE OverloadedStrings #-}

-- para o scotty
import Web.Scotty
import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as T

-- módulos locais
import BaseConvert
import MorseFuncs
import Caesar
import Romans
import Vigenere

main :: IO ()
main = scotty 3000 $ do
    get "/" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/mainpage.html"

    get "/bases" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/bases.html"

    post "/bases/result" $ do
        input <- formParam "input" :: ActionM Text
        inputBase <- formParam "inputBase" :: ActionM Int
        outputBase <- formParam "outputBase" :: ActionM Int

        let decimal = baseToDecimal inputBase (T.unpack input)
        let result = decimalToBase outputBase decimal

        html $ T.pack $ "<h3>Valor original:</h3>" ++ T.unpack input ++ " (base " ++ show inputBase ++ ")" ++
                        "<h3>Valor convertido:</h3>" ++ result ++ " (base " ++ show outputBase ++ ")" ++
                        "<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/morse/encode" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/morsencode.html"

    post "/morse/encode/result" $ do
        text <- formParam "text" :: ActionM Text
        let originalText = T.unpack text
        let morseText = textToMorse originalText
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++ "<h3>Texto em morse: </h3>" ++ morseText ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
    
    get "/morse/decode" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/morsedecode.html"

    post "/morse/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        let morseText = T.unpack text
        let decodedText = morseToText morseText
        html $ T.pack $ "<h3>Morse: </h3>" ++ morseText ++ "<h3>Texto decodificado: </h3>" ++ decodedText ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/caesar" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/caesar.html"
    
    post "/caesar/result" $ do
        text <- formParam "text" :: ActionM Text
        shift <- formParam "shift" :: ActionM Int
        let originalText = T.unpack text
        let caesarText = caesar originalText shift
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++ "<h3>Texto criptografado: </h3>" ++ caesarText ++ " (deslocamento: " ++ (show shift) ++ ")<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/romans/to" $ do
        html "<h1>Conversor para Números Romanos 🇻🇦</h1>\
             \<form action='/romans/to/result' method='post'>\
             \Número inteiro a converter (máximo 3999): <input type='number' name='num' min='1' max='3999' required><br/>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Year_1575_in_Arabic_and_Roman_numbers.jpg/250px-Year_1575_in_Arabic_and_Roman_numbers.jpg\" alt=\"image\" width=512px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/romans/to/result" $ do
        num <- formParam "num" :: ActionM Int
        let romanNum = toRoman num
        html $ T.pack $ "<h3>Número original: </h3>" ++ show num ++ "<h3>Número em romanos: </h3>" ++ romanNum ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
    
    get "/romans/from" $ do
        html "<h1>Conversor de Números Romanos 🇻🇦</h1>\
             \<h3 color=\"red\">nota: apenas letras romanas (MDCLXVI)</h3>\
             \<form action='/romans/from/result' method='post'>\
             \Número em romanos a converter: <input type='text' name='roman' required><br/>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://media.geeksforgeeks.org/wp-content/uploads/20230711104223/Roman-numerals.webp\" alt=\"image\" width=256px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"
    
    post "/romans/from/result" $ do
        roman <- formParam "roman" :: ActionM Text
        let romanStr = T.unpack roman
        let intNum = fromRoman romanStr
        html $ T.pack $ "<h3>Número em romanos: </h3>" ++ romanStr ++ "<h3>Número em inteiro: </h3>" ++ show intNum ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/vigenere/encode" $ do
        html "<h1>Codificador de Vigenère 🔐</h1>\
             \<h3 color=\"red\">nota 1: somente letras serão alteradas</h3>\
             \<h3 color=\"red\">nota 2: NÃO coloque acentos</h3>\
             \<form action='/vigenere/encode/result' method='post'>\
             \Texto a codificar (somente letras):<br><input type='text' name='text' required><br/><br/>\
             \Chave (somente letras):<br><input type='text' name='key' required><br/><br/>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://www.thecrazyprogrammer.com/wp-content/uploads/2017/08/Vigenere-Cipher-Table.png\" alt=\"image\" width=256px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/vigenere/encode/result" $ do
        text <- formParam "text" :: ActionM Text
        key <- formParam "key" :: ActionM Text
        let originalText = T.unpack text
        let keyText = T.unpack key
        let vigenereText = toVigenere originalText keyText
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++ "<h3>Texto codificado: </h3>" ++ vigenereText ++ " (chave: " ++ keyText ++ ")<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/vigenere/decode" $ do
        html "<h1>Decodificador de Vigenère 🔐</h1>\
             \<h3 color=\"red\">nota: somente letras serão alteradas</h3>\
             \<form action='/vigenere/decode/result' method='post'>\
             \Texto a decodificar (somente letras):<br><input type='text' name='text' required><br/><br/>\
             \Chave (somente letras):<br><input type='text' name='key' required><br/><br/>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://www.thecrazyprogrammer.com/wp-content/uploads/2017/08/Vigenere-Cipher-Table.png\" alt=\"image\" width=256px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/vigenere/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        key <- formParam "key" :: ActionM Text
        let cipherText = T.unpack text
        let keyText = T.unpack key
        let decodedText = fromVigenere cipherText keyText
        html $ T.pack $ "<h3>Texto codificado: </h3>" ++ cipherText ++ "<h3>Texto decodificado: </h3>" ++ decodedText ++ " (chave: " ++ keyText ++ ")<br><br><a href=\"/\">Voltar para a página principal</a><br>"
