

main :: IO()
main = do
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