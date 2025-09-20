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
        text "Página principal. Adicione no link '/bases', '/morse/encode' ou 'morse/decode'."

    get "/bases" $ do
        html "<h1>Base Converter</h1><form action='/bases/result' method='post'>\
             \Número a converter: <input type='text' name='input'><br/>\
             \Base do número de entrada (2-64): <input type='number' name='inputBase' min='2' max='64'><br/>\
             \Base do número de saída (2-64): <input type='number' name='outputBase' min='2' max='64'><br/>\
             \<input type='submit' value='Convert'></form>"

    post "/bases/result" $ do
        input <- formParam "input" :: ActionM Text
        inputBase <- formParam "inputBase" :: ActionM Int
        outputBase <- formParam "outputBase" :: ActionM Int

        let decimal = baseToDecimal inputBase (T.unpack input)
        let result = decimalToBase outputBase decimal

        html $ T.pack $ "Valor original: " ++ T.unpack input ++ " (base " ++ show inputBase ++ ")<br/>" ++
                        "Valor convertido: " ++ result ++ " (base " ++ show outputBase ++ ")"

    get "/morse/encode" $ do
        html "<form action='/morse/encode/result' method='post'><input type='text' name='text' required><input type='submit' value='Converter texto para morse'></form>"

    post "/morse/encode/result" $ do
        text <- formParam "text" :: ActionM Text
        let originalText = T.unpack text
        let morseText = textToMorse originalText
        html $ T.pack $ "Texto original: " ++ originalText ++ "<br>Texto em morse: " ++ morseText
    
    get "/morse/decode" $ do
        html "<form action='/morse/decode/result' method='post'><input type='text' name='text' required><input type='submit' value='Converter morse para texto'></form>"

    post "/morse/decode/result" $ do
        text <- formParam "text" :: ActionM Text
        let morseText = T.unpack text
        let decodedText = morseToText morseText
        html $ T.pack $ "Texto original: " ++ morseText ++ "<br>Texto em morse: " ++ decodedText
