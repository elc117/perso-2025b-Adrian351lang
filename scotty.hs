{-# LANGUAGE OverloadedStrings #-}

-- para o scotty
import Web.Scotty
import Control.Monad.IO.Class (liftIO)
import Data.Text.Lazy (Text)
import qualified Data.Text.Lazy as T

-- módulos locais
import BaseConvert
import MorseFuncs

main :: IO ()
main = scotty 3000 $ do
    get "/" $ do
        html "<h1>Este é um site de ferramentas utilitárias de conversão.</h1>\
             \<h2>Ferramentas disponíveis:</h2>\
             \<a href=\"bases\">Conversor de bases numéricas</a><br>\
             \<br><a href=\"morse/encode\">Codificador de código morse</a><br>\
             \<br><a href=\"morse/decode\">Decodificador de código morse</a><br>"

    get "/bases" $ do
        html "<h1>Conversor de Bases</h1>\
             \<h2>Caracteres suportados: (0-9), (A-Z), (a-z), '+' e '/'</h2>\
             \<form action='/bases/result' method='post'>\
             \Número a converter: <input type='text' name='input'><br/>\
             \Base do número de entrada (2-64): <input type='number' name='inputBase' min='2' max='64'><br/>\
             \Base do número de saída (2-64): <input type='number' name='outputBase' min='2' max='64'><br/>\
             \<input type='submit' value='converter'>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>\
             \</form>"

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
        html "<h1>Codificador de Morse</h1>\
             \<form action='/morse/encode/result' method='post'>\
             \Texto a codificar: <input type='text' name='text' required>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/morse/encode/result" $ do
        text <- formParam "text" :: ActionM Text
        let originalText = T.unpack text
        let morseText = textToMorse originalText
        html $ T.pack $ "<h3>Texto original: </h3>" ++ originalText ++ "<h3>Texto em morse: </h3>" ++ morseText ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
    
    get "/morse/decode" $ do
        html "<h1>Decodificador de Morse</h1>\
             \<h2>Separar letras por espaços e palavras por barra</h2>\
             \<form action='/morse/decode/result' method='post'>\
             \Código morse a decodificar: <input type='text' name='text' required>\
             \<input type='submit' value='converter'>\
             \</form>\
             \<br><a href=\"/\">Voltar para a página principal</a><br>"

    post "/morse/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        let morseText = T.unpack text
        let decodedText = morseToText morseText
        html $ T.pack $ "<h3>Morse: </h3>" ++ morseText ++ "<h3>Texto decodificado: </h3>" ++ decodedText ++ "<br><br><a href=\"/\">Voltar para a página principal</a><br>"
