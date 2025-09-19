{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger (logStdoutDev)

main :: IO ()
main = scotty 3000 $ do
    middleware logStdoutDev

    -- sessão de conversão de bases
    -- acessar em http://localhost:3000/bases
    get "/bases" $ do
        text "hello bases"

    -- sessão de conversão de morse
    -- acessar em http://localhost:3000/morse
    get "/morse" $ do
        text "hello morse"
