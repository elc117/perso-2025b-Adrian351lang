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
        html "<h1>Este é um site de ferramentas utilitárias de conversão.</h1>\
             \<h2>🛠️ Ferramentas disponíveis: 🛠️</h2>\
             \1. <a href=\"bases\">Conversor de bases numéricas</a> 🔟<br>\
             \<br>2. <a href=\"morse/encode\">Codificador de código morse</a> 📶<br>\
             \<br>3. <a href=\"morse/decode\">Decodificador de código morse</a> 📶<br>\
             \<br>4. <a href=\"caesar\">Criptografia com cifra de César</a> 🔣<br>\
             \<br>5. <a href=\"romans/to\">Converter número de decimal para romanos</a> 🇻🇦<br>\
             \<br>6. <a href=\"romans/from\">Converter número de romanos para decimal</a> 🇻🇦<br>\
             \<br>7. <a href=\"vigenere/encode\">Codificador de Vigenère</a> 🔐<br>\
             \<br>8. <a href=\"vigenere/decode\">Decodificador de Vigenère</a> 🔐<br>\
             \<br><br><a href=\"https://github.com/elc117/perso-2025b-Adrian351lang\">Código fonte (github)</a> 🖥️"

    get "/bases" $ do
        html "<h1>Conversor de Bases 🔟</h1>\
             \<h3>Caracteres suportados: (0-9), (A-Z), (a-z), '+' e '/'</h3>\
             \<form action='/bases/result' method='post'>\
             \Número a converter: <input type='text' name='input'><br/>\
             \Base do número de entrada (2-64): <input type='number' name='inputBase' min='2' max='64'><br/>\
             \Base do número de saída (2-64): <input type='number' name='outputBase' min='2' max='64'><br/>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://www.lifewire.com/thmb/_Kcz92SYc2CaYMDaktNp4iRuwhY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/173580191-56a6f9b85f9b58b7d0e5cb75.jpg\" alt=\"image\" width=512px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

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
        html "<h1>Codificador de Morse 📶</h1>\
             \<h3 color=\"red\">Nota: somente letras e números</h3>\
             \<form action='/morse/encode/result' method='post'>\
             \Texto a codificar: <input type='text' name='text' required><br>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Telegraph_key_and_sounder%2C_L.C.T._%28L._C._Tillotson%29_and_Co.%2C_8_Dey_Street%2C_NY_-_Bennington_Museum_-_Bennington%2C_VT_-_DSC08636.JPG/250px-Telegraph_key_and_sounder%2C_L.C.T._%28L._C._Tillotson%29_and_Co.%2C_8_Dey_Street%2C_NY_-_Bennington_Museum_-_Bennington%2C_VT_-_DSC08636.JPG\" alt=\"image\" width=512px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/morse/encode/result" $ do
        text <- formParam "text" :: ActionM Text
        let originalText = T.unpack text
        let morseText = textToMorse originalText
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++ "<h3>Texto em morse: </h3>" ++ morseText ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
    
    get "/morse/decode" $ do
        html "<h1>Decodificador de Morse 📶</h1>\
             \<h3 color=\"red\">Nota: separar letras por espaços e palavras por barra</h3>\
             \<form action='/morse/decode/result' method='post'>\
             \Código morse a decodificar: <input type='text' name='text' required><br>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://images.sampletemplates.com/wp-content/uploads/2015/05/12144219/Morse-Code-Chart-to-Download.jpg\" alt=\"image\" width=420px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/morse/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        let morseText = T.unpack text
        let decodedText = morseToText morseText
        html $ T.pack $ "<h3>Morse: </h3>" ++ morseText ++ "<h3>Texto decodificado: </h3>" ++ decodedText ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/caesar" $ do
        html "<h1>Criptografia com cifra de César 🔣</h1>\
             \<h3 color=\"red\">nota: somente letras serão alteradas</h3>\
             \<form action='/caesar/result' method='post'>\
             \Texto a criptografar (somente letras):<br><input type='text' name='text' required><br/><br/>\
             \Número de deslocamento (positivo para criptografar, negativo para descriptografar):<br><input type='number' name='shift' required><br/><br/>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<img src=\"https://i.ytimg.com/vi/KwjJKOrcwkg/maxresdefault.jpg\" alt=\"image\" width=512px><br>\
             \<img src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Confederate_cipher_disk.jpg/250px-Confederate_cipher_disk.jpg\" alt=\"image\" width=256px><br>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"
    
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
