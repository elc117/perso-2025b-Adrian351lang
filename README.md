# Identificação:
Nome: Adrian Bellé Secretti <br>
Curso: Sistemas de Informação

# Tema:
Este projeto se trata de um sistema de conversão e codificação de sistemas númericos, de criptografia e códigos. <br>
Até agora foram inplementadas as seguintes funcionalidades: <br>
1. Conversor de bases numéricas.
2. Coficação de código morse.
3. Decoficação de código morse.
4. Criptografia com cifra de césar.
5. Converter decimal para romanos.
6. Converter romanos para decimal. (W.I.P.)
7. Codificar texto com cifra de Vigenère.
8. Decodificar texto com cifra de Vigenère.

## Conversor de Bases:
O conversor de bases suporta números nas bases 2 até 64. <br>
A menor base possível é 2 (sistema binário) porque não seria possível uma base 1. <br>
A maior base é 64 porque há um limite de caracteres reconhecidos como dígitos. <br>
Por enquanto, não há suporte para números com vírgula. <br>
Decidi usar como base uma versão modificada do sistema Base64, que usa os caracteres (0-9), (A-Z), (a-z), '+' e '/'. <br>
Para converter de base X para base Y, é necessário primeiro converter base X para base 10 e depois base 10 para base Y. <br>

### 1. Converter de base X para base 10:
Se usa a seguinte fórmula: <br>
```soma(base ^ peso * dígito; do dígito menos significativo ao mais significativo)```
<br> <br>
![image](https://wikimedia.org/api/rest_v1/media/math/render/svg/ed875ba981decb322a05335f7efdb5490244d67f)

### Converter de base 10 para base Y:
Usa-se o método das divisões sucessivas, que se trata de: <br>
1. Dividir o número por Y e pegar os restos até chegar a 0.
2. Os restos serão o número na base Y.
<br> <br>
![image](https://homework.study.com/cimages/multimages/16/capture14204776639827140608.png)

## Morse:
O decodificador de código morse considera que as letras em morse são separadas por espaços, e as palavras, por barras. <br>
Para a conversão, apenas separei cada letra do texto usei um sistema com switch-case para a conversão. <br>
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

## Converter para romanos:
Suporta números até 3999. <br>
Os números romanos funcionam da seguinte forma: <br><br>
![image](https://media.geeksforgeeks.org/wp-content/uploads/20230711104223/Roman-numerals.webp)

## Cifra de Vigenère:
Esta cifra é um método de criptografia que recebe um texto e uma chave, e criptografa o texto usando aquela chave. <br>
É similar à cifra de César, mas aqui cada letra recebe um deslocamento diferente, de acordo com a chave. <br>
Primeiro, a chave é estendida para o mesmo tamanho do texto, e então o código de cada letra do texto e somada com o código de cada letra da chave. <br>
Abaixo está a tabela com as combinações de letras: <br> <br>
![image](https://www.thecrazyprogrammer.com/wp-content/uploads/2017/08/Vigenere-Cipher-Table.png)

# Desenvolvimento:
A criação das funções de conversão em si não foi difícil, apenas precisei aprender algumas funções novas, como "intercalate", "fromEnum" e funções recursivas. <br>
A parte mais trabalhosa foi a criação da interface com o framework scotty, já que é complexo conseguir o input do usuário usando-o.

# Execução:
Criei dos arquivos de módulo, um com as funções relacionadas à conversão de bases e outro com as funções relacionadas a morse. <br>
Deixei um arquivo de teste que usa o IO padrão do haskell. <br>
O site em si está no arquivo "scotty.hs", que abre em servidor na porta 3000. <br>
O makefile que está no projeto já tem os comandos para compilar os testes e o site. <br>

## Endereço:
Se executado com o ghc na própria máquina, o link deve ser: <br>
http://localhost:3000

## Requisitos (baixar com o cabal):
1. scotty
2. text

# Resultado:
TODO

# Referências:
1. WIKIPEDIA CONTRIBUTORS. Base64. Disponível em: <https://en.wikipedia.org/wiki/Base64>.
2. Number Bases. Disponível em: <https://www.mathsisfun.com/numbers/bases.html>.
3. GEEKSFORGEEKS. Number System and Base Conversions. Disponível em: <https://www.geeksforgeeks.org/digital-logic/number-system-and-base-conversions/>.
4. Numeral system. Disponível em: <https://en.wikipedia.org/wiki/Numeral_system>.
5. Base Conversion Guide UCR · Math 135A Decimal Binary Octal Hexidecimal (Base 10) (Base 2) (Base 8) (Base 16). [s.l: s.n.]. Disponível em: <https://math.ucr.edu/~jbritton/BaseConversionGuide.pdf>.
6. CHRIS. How to get the ASCII value of a character in Haskell? Disponível em: <https://stackoverflow.com/questions/3261236/how-to-get-the-ascii-value-of-a-character-in-haskell>.
7. International Morse Code | communications. Disponível em: <https://www.britannica.com/topic/International-Morse-Code>.
8. WIKIPEDIA CONTRIBUTORS. Caesar cipher. Disponível em: <https://en.wikipedia.org/wiki/Caesar_cipher>.
9. GEEKSFORGEEKS. Caesar Cipher in Cryptography. Disponível em: <https://www.geeksforgeeks.org/ethical-hacking/caesar-cipher-in-cryptography/>.
10. THE EDITORS OF ENCYCLOPAEDIA BRITANNICA. Roman Numeral | Chart & Facts, 2019. Disponível em: <https://www.britannica.com/topic/Roman-numeral>.
11. Roman numerals chart. Disponível em: <https://www.rapidtables.com/math/symbols/roman_numerals.html>.
12. Haskell/Recursion - Wikibooks, open books for an open world. Disponível em: <https://en.wikibooks.org/wiki/Haskell/Recursion>.
13. GEEKSFORGEEKS. Roman Numerals 1 to 100 | Roman Numbers Chart, Rules & Examples. Disponível em: <https://www.geeksforgeeks.org/maths/roman-numerals/>.
14. WIKIPEDIA CONTRIBUTORS. Morse code. Disponível em: <https://en.wikipedia.org/wiki/Morse_code>.
15. SILVA, K. D. One problem five solutions — Zip Function. Disponível em: <https://kevin-da-silva.medium.com/one-problem-five-solutions-zip-function-ad1ed3bd1f16>.
16. GEEKSFORGEEKS. Roman to Integer Conversion. Disponível em: <https://www.geeksforgeeks.org/dsa/roman-number-to-integer/>.
17. Haskell : group. Disponível em: <https://zvon.org/other/haskell/Outputlist/group_f.html>.
18. GEEKSFORGEEKS. Vigenere Cipher. Disponível em: <https://www.geeksforgeeks.org/dsa/vigenere-cipher/>.
19. INSTRUCTABLES. Best Codes. Disponível em: <https://www.instructables.com/Best-Codes/>.
20. What is the best alternative for Morse code? Disponível em: <https://www.quora.com/What-is-the-best-alternative-for-Morse-code>.
21. Secret Language: Cryptography & Secret Codes | Exploratorium. Disponível em: <https://www.exploratorium.edu/explore/secret-language>.
22. Haskell : cycle. Disponível em: <https://zvon.org/other/haskell/Outputprelude/cycle_f.html>.
23. Haskell : length. Disponível em: <https://zvon.org/other/haskell/Outputprelude/length_f.html>.
24. WIKIPEDIA CONTRIBUTORS. Vigenère cipher. Disponível em: <https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher>.
25. ELIAS, D. Gerador de Referências ABNT [Atualizado para 2021]. Disponível em: <https://www.mybib.com/pt/ferramentas/gerador-referencias-abnt>.