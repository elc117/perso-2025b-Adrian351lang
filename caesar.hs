import Data.Char (toLower, isAlpha)

-- desloca a letra se for alfabética, senão dá erro
tryShift :: Char -> Int -> Char
tryShift c shift
    | isAlpha c = toEnum (fromEnum (toLower c) + shift) -- se for letra, converte para minúscula e faz o deslocamento
    | c == ' ' = ' '                                    -- mantém espaços sem alteração
    | otherwise = error "caractere inválido, apenas letras alfabéticas são suportadas"

-- deslocamento das letras conforme a cifra de césar
caesarShift :: Char -> Int -> Char
caesarShift c shift
    | shifted == ' ' = ' '                                                      -- mantém espaços sem alteração
    | fromEnum shifted > fromEnum 'z' = toEnum (fromEnum shifted - fromEnum 26) -- caso passe de 'z', considera que 'a' vem depois de 'z' e volta para trás
    | fromEnum shifted < fromEnum 'a' = toEnum (fromEnum shifted + fromEnum 26) -- mesma coisa, mas para se for para trás de 'a'
    | otherwise = shifted

    -- faz o deslocamento conforme e número que foi passado
    where
        shifted = tryShift c shift

caesar :: String -> Int -> String
caesar str shift = map (\c -> caesarShift c shift) str

main :: IO()
main = do
    putStrLn "Digite o texto a criptografar com a cifra de césar (somente letras e espaços):"
    raw <- getLine
    putStrLn "Digite o número de deslocamento (positivo para direita, negativo para esquerda):"
    shift <- readLn
    putStrLn $ "Texto original: " ++ raw
    putStrLn $ "Texto criptografado: " ++ (caesar raw shift) ++ ", deslocamento: " ++ (show shift)