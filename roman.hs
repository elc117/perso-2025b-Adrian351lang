module Romans where

-- converte os milhares
thousandToRoman:: Int -> String
thousandToRoman d
  | d == 0 = ""
  | d == 1 = "M"
  | d == 2 = "MM"
  | d == 3 = "MMM"
  | otherwise = error "valor muito grande"

-- converte as centenas
hundredToRoman:: Int -> String
hundredToRoman d
  | d == 0 = ""
  | d == 1 = "C"
  | d == 2 = "CC"
  | d == 3 = "CCC"
  | d == 4 = "CD"
  | d == 5 = "D"
  | d == 6 = "DC"
  | d == 7 = "DCC"
  | d == 8 = "DCCC"
  | d == 9 = "CM"

-- converte as dezenas
tenToRoman:: Int -> String
tenToRoman d
  | d == 0 = ""
  | d == 1 = "X"
  | d == 2 = "XX"
  | d == 3 = "XXX"
  | d == 4 = "XL"
  | d == 5 = "L"
  | d == 6 = "LX"
  | d == 7 = "LXX"
  | d == 8 = "LXXX"
  | d == 9 = "XC"

-- converte as unidades
unitToRoman:: Int -> String
unitToRoman d
  | d == 0 = ""
  | d == 1 = "I"
  | d == 2 = "II"
  | d == 3 = "III"
  | d == 4 = "IV"
  | d == 5 = "V"
  | d == 6 = "VI"
  | d == 7 = "VII"
  | d == 8 = "VIII"
  | d == 9 = "IX"

-- converte um numero inteiro para o numeral romano (máximo 3999)
-- separa o numero em milhares, centenas, dezenas e unidades
toRoman:: Int -> String
toRoman num
    | num < 4000 = thousandToRoman thousands ++ hundredToRoman hundreds ++ tenToRoman tens ++ unitToRoman units
    | otherwise = error "valor muito grande"

    where
        thousands = num `mod` 10000 `div` 1000
        hundreds  = num `mod` 1000 `div` 100
        tens      = num `mod` 100 `div` 10
        units     = num `mod` 10