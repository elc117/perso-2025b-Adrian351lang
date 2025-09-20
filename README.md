# Identificação:
Nome: Adrian Bellé Secretti <br>
Curso: Sistemas de Informação

# Tema:
Este projeto se trata de um sistema de conversão e codificação de sistemas númericos, de criptografia e códigos. <br>
Até agora foram inplementadas as seguintes funcionalidades: <br>
1. Conversor de número em base númerica X para base numérica Y, bases de 2 a 64.
2. Coficação de código morse.
3. Decoficação de código morse.
4. Criptografia com cifra de césar.

O conversor de bases suporta números nas bases 2 até 64. Os caracteres aceitos são (0-9), (A-Z), (a-z), '+' e '/'. <br>
A menor base possível é 2 (sistema binário) porque não seria possível uma base 1. <br>
A maior base é 64 porque há um limite de caracteres reconhecidos como dígitos. <br>
Por enquanto, não há suporte para números com vírgula. <br>
<br>
O decodificador de código morse considera que as letras em morse são separadas por espaços, e as palavras, por barras. <br>
<br>
O criptografador de cifra de césar recebe um texto com apenas letras e espaços e criptografa de acordo. <br>

# Funcionamento:
Decidi usar como base o sistema Base64, que usa os caracteres (0-9), (A-Z), (a-z), '+' e '/', como mencionado acima. <br>
Para converter de base X para base Y, é necessário primeiro converter base X para base 10 e depois base 10 para base Y. <br>

## Para converter de base X para base 10, se usa a seguinte fórmula:
```soma(base ^ peso * dígito; do dígito menos significativo ao mais significativo)```
<br> <br>
![image](https://wikimedia.org/api/rest_v1/media/math/render/svg/ed875ba981decb322a05335f7efdb5490244d67f)

## Para converter de base 10 para base Y, se usa o método das divisões sucessivas, que se trata de:
1. Dividir o número por Y e pegar os restos até chegar a 0.
2. Os restos serão o número na base Y.
<br> <br>
![image](https://homework.study.com/cimages/multimages/16/capture14204776639827140608.png)

## Morse:
Para a conversão de código morse, apenas separei cada letra do texto usei um sistema com switch-case para a conversão. <br>
<br> <br>
![image](https://images.sampletemplates.com/wp-content/uploads/2015/05/12144219/Morse-Code-Chart-to-Download.jpg)

## Cifra de César:
A codificação de César recebe um conjunto de letras e um número de deslocamento N, de 0 a 26, e desloca todas as letras N letras para a direita. Exemplo: <br>
Texto original: ATTACKATONCE <br>
Deslocamento: 4 <br>
Texto criptografado: EXXEGOEXSRGI <br>
A fórmula em pseudocódigo é a seguinte: <br>
Caesar (palavra, deslocamento) = letra_na_posicao((posicao(letra) + deslocamento) % 26); para toda letra em palavra <br>
<br><br>
![image](https://media.geeksforgeeks.org/wp-content/uploads/ceaserCipher.png)

# Desenvolvimento:
A criação das funções de conversão em si não foi difícil, apenas precisei aprender algumas funções novas, como "intercalate", "fromEnum" e funções recursivas. <br>
A parte mais trabalhosa foi a criação da interface com o framework scotty, já que é complexo conseguir o input do usuário usando-o.

# Execução:
Criei dos arquivos de módulo, um com as funções relacionadas à conversão de bases e outro com as funções relacionadas a morse. <br>
Deixei um arquivo de teste que usa o IO padrão do haskell. <br>
O site em si está no arquivo scotty.hs, que abre em servidor na porta 3000. <br>
## Para executar, acessar os seguintes links:
1. http://localhost:3000
2. http://localhost:3000/bases
3. http://localhost:3000/morse/encode
4. http://localhost:3000/morse/decode

## Requisitos (baixar com o cabal):
1. scotty
2. text

# Resultado:
TODO

# Referências:
1. https://en.wikipedia.org/wiki/Base64
2. https://www.mathsisfun.com/numbers/bases.html
3. https://www.geeksforgeeks.org/digital-logic/number-system-and-base-conversions/
4. https://en.wikipedia.org/wiki/Numeral_system
5. https://math.ucr.edu/~jbritton/BaseConversionGuide.pdf
6. https://stackoverflow.com/questions/3261236/how-to-get-the-ascii-value-of-a-character-in-haskell
7. https://www.britannica.com/topic/International-Morse-Code
8. https://en.wikipedia.org/wiki/Caesar_cipher
9. https://www.geeksforgeeks.org/ethical-hacking/caesar-cipher-in-cryptography/
10. https://www.britannica.com/topic/Roman-numeral
11. https://www.rapidtables.com/math/symbols/roman_numerals.html
12. https://en.wikibooks.org/wiki/Haskell/Recursion
