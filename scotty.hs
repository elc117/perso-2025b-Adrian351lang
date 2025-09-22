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
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++
                        "<h3>Texto em morse: </h3>" ++ morseText ++
                        "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
    
    get "/morse/decode" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/morsedecode.html"

    post "/morse/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        let morseText = T.unpack text
        let decodedText = morseToText morseText
        html $ T.pack $ "<h3>Morse: </h3>" ++ morseText ++
        "<h3>Texto decodificado: </h3>" ++ decodedText ++
        "<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/caesar" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/caesar.html"
    
    post "/caesar/result" $ do
        text <- formParam "text" :: ActionM Text
        shift <- formParam "shift" :: ActionM Int
        let originalText = T.unpack text
        let caesarText = caesar originalText shift
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++
        "<h3>Texto criptografado: </h3>" ++ caesarText ++ " (deslocamento: " ++ (show shift) ++
        ")<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/romans/to" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/toromans.html"

    post "/romans/to/result" $ do
        num <- formParam "num" :: ActionM Int
        let romanNum = toRoman num
        html $ T.pack $ "<h3>Número original: </h3>" ++ show num ++
        "<h3>Número em romanos: </h3>" ++ romanNum ++
        "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
    
    get "/romans/from" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/fromromans.html"
    
    post "/romans/from/result" $ do
        roman <- formParam "roman" :: ActionM Text
        let romanStr = T.unpack roman
        let intNum = fromRoman romanStr
        html $ T.pack $ "<h3>Número em romanos: </h3>" ++ romanStr ++
        "<h3>Número em inteiro: </h3>" ++ show intNum ++
        "<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/vigenere/encode" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/tovigenere.html"

    post "/vigenere/encode/result" $ do
        text <- formParam "text" :: ActionM Text
        key <- formParam "key" :: ActionM Text
        let originalText = T.unpack text
        let keyText = T.unpack key
        let vigenereText = toVigenere originalText keyText
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++
        "<h3>Texto codificado: </h3>" ++ vigenereText ++ " (chave: " ++ keyText ++
        ")<br><br><a href=\"/\">Voltar para a página principal</a><br>"

    get "/vigenere/decode" $ do
        setHeader "Content-Type" "text/html; charset=utf-8"
        file "static/fromvigenere.html"

    post "/vigenere/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        key <- formParam "key" :: ActionM Text
        let cipherText = T.unpack text
        let keyText = T.unpack key
        let decodedText = fromVigenere cipherText keyText
        html $ T.pack $ "<h3>Texto codificado: </h3>" ++ cipherText ++
        "<h3>Texto decodificado: </h3>" ++ decodedText ++ " (chave: " ++ keyText ++
        ")<br><br><a href=\"/\">Voltar para a página principal</a><br>"
