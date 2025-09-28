# Identificação 🪪:
- Nome: Adrian Bellé Secretti
- Curso: Sistemas de Informação
- Semestre: 2025/2
- Desenvolvimento: 15/09 a 28/09

# Tema 📄:
Este projeto se trata de um sistema de conversão/codificação de sistemas númericos, de criptografia e códigos. <br>
Há uma página principal com os links que levam para cada subpágina. <br>
Até agora foram implementadas as seguintes funcionalidades: <br>
- Conversor de bases numéricas.
- Codificar texto para morse.
- Decodificar morse para texto.
- Criptografia de mensagens com cifra de césar.
- Converter número decimal para romanos.
- Converter de romanos para decimal.
- Codificar texto com cifra de Vigenère.
- Decodificar texto com cifra de Vigenère.

# Desenvolvimento 🛠️:
Explicação detalhada de como fiz cada sistema:

## Conversor de Bases:
O conversor de bases suporta números nas bases 2 até 64. <br>
A menor base possível é 2 (sistema binário) porque não seria possível uma base 1. <br>
A maior base é 64 porque há um limite de caracteres reconhecidos como dígitos. <br>
Por enquanto, não há suporte para números com vírgula. <br>
Decidi usar como base uma versão modificada do sistema Base64, que usa os caracteres (0-9), (A-Z), (a-z), '+' e '/'. <br>
Para converter de base X para base Y, é necessário primeiro converter base X para base 10 e depois base 10 para base Y. <br>

### Passo 1. Converter de base X para base 10:
Para números sem vírgula se usa a seguinte fórmula (em pseudocódigo): <br>
```soma(base ^ peso * dígito; do dígito menos significativo ao mais significativo)```
<br> <br>
Esta é a fórmula matemática detalhada:
<br> <br>
![image](https://wikimedia.org/api/rest_v1/media/math/render/svg/ed875ba981decb322a05335f7efdb5490244d67f)

### Passo 2. Converter de base 10 para base Y:
Usa-se o método das divisões sucessivas, que se trata de: <br>
1. Dividir o número por Y e pegar os restos até chegar a 0.
2. Os restos ao contrário serão o número na base Y.

Exemplo com binário:
<br> <br>
![image](https://homework.study.com/cimages/multimages/16/capture14204776639827140608.png)

## Morse:
O decodificador de código morse considera que as letras em morse são separadas por espaços, e as palavras, por barras. <br>
Para a conversão, apenas separei cada letra do texto usei um sistema com switch-case (pipes) para a conversão. <br>
<br> <br>
![image](https://images.sampletemplates.com/wp-content/uploads/2015/05/12144219/Morse-Code-Chart-to-Download.jpg)

## Cifra de César:
A codificação de César recebe um conjunto de letras e um número de deslocamento N, de 1 a 25, e desloca todas as letras N letras para a direita. Exemplo: <br>
Texto original: ATTACKATONCE <br>
Deslocamento: 4 <br>
Texto criptografado: EXXEGOEXSRGI <br>
A fórmula em pseudocódigo é a seguinte: <br>
```Caesar (palavra, deslocamento) = letra_na_posicao((posicao(letra) + deslocamento) % 26); para toda letra em palavra``` <br>
onde: <br>
letra_na_posicao(0) = 'A' <br>
letra_na_posicao(1) = 'B' <br>
posicao('A') = 0 <br>
...
<br><br>
![image](https://media.geeksforgeeks.org/wp-content/uploads/ceaserCipher.png)

## Converter para romanos:
Suporta números até 3999. <br>
Os números romanos funcionam da seguinte forma: <br><br>
![image](https://media.geeksforgeeks.org/wp-content/uploads/20230711104223/Roman-numerals.webp)

## Cifra de Vigenère:
Esta cifra é um método de criptografia que recebe um texto e uma chave, e criptografa o texto usando aquela chave. <br>
É similar à cifra de César, mas aqui cada letra recebe um deslocamento diferente, de acordo com a chave. <br>
Primeiro, a chave é estendida para o mesmo tamanho do texto, e então o código de cada letra do texto é somada com o código de cada letra da chave. <br>
Abaixo está a tabela com as combinações de letras: <br> <br>
![image](https://www.thecrazyprogrammer.com/wp-content/uploads/2017/08/Vigenere-Cipher-Table.png)

## Programação:
A parte das funções de conversão de códigos em si não foi difícil, apenas exigiu tempo e estudo. <br>
Muitos desses sistemas de codificação eu já tinha pelo menos um breve conhecimento. O que eu fiz foi estudar mais profundamente como eles funcionam, e desenvolver uma lógica para aplicar esses métodos na linguagem haskell. <br>
Também tive que estudar várias funções nativas do haskell, como fromEnum, intercalate, isAlpha, cycle, divMod, funcões recursivas, entre outras que não conhecia. <br>
O mais difícil foi desenvolver as interfaces, pois tive que estudar HTML e CSS, já que eu tinha pouco conhecimento sobre eles. <br>
Os botões da página principal foram feitos com javascript. <br>
Para automatizar a compilação e execução usei makefile, docker e shellscript. <br>
A parte do docker não é necessária, mas pode ajudar com a questão das dependências. <br>
Foram usadas IAs apenas para auxílio nas pesquisas, não para gerar código. <br>

# Execução 🖥️:
A estrutura do projeto está da seguinte forma: <br>
- modules/: pasta com os módulos contendo as funções do programa, compartilhadas entre o arquivo scotty e o arquivo de testes. <br>
- main/: pasta com dois arquivos, o scotty.hs, que abre o servidor na porta 3000, e o arquivo de testes, para testar as funções com a biblioteca HUnit. <br>
- pages/: pasta com as páginas HTML e CSS. <br>
- makefile: compila e roda o código. <br>
- dockerfile: constrói a imagem docker para o scotty. <br>
- docker.sh: roda o servidor no container docker. <br>

## Endereço:
Provavelmente o link será esse: <br>
http://localhost:3000/

## Requisitos:
Para executar o programa, é necessário ter o GHC (Glasgow Haskell Compiler) instalado na máquina, assim como o Cabal, para as dependências. <br>
Se usar o dockerfile, é necessário ter o Docker instalado também. <br>

### Para o servidor:
```shell
cabal install --lib scotty text
make run
```

### Para os testes:
```shell
cabal install --lib HUnit
make test
```

### Para o docker:
```shell
chmod +x docker.sh
./docker.sh
```

## Observação:
É importante que a pasta "pages/" esteja junto com o executável, senão dará erro 404. <br>

# Resultado 📊:
Abaixo está o teste do programa realizado no dia 25/09/2025: <br>
## Vídeo (acelerado):
https://github.com/user-attachments/assets/7c26c4eb-d095-4677-8fcd-dbe6c0fa7790

# Referências 📜:
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
25. DAVIDWEBB. What does the “in” keyword do in Haskell? Disponível em: <https://stackoverflow.com/questions/52705485/what-does-the-in-keyword-do-in-haskell>.
26. Haskell Cheat Sheet. Disponível em: <https://hackage.haskell.org/package/CheatSheet-1.5/src/CheatSheet.pdf>.
27. Let vs. Where - HaskellWiki. Disponível em: <https://wiki.haskell.org/Let_vs._Where>.
28. HANDSOMEGORILLA. What does the use of a colon between symbols in a parameter in a Haskell function definition do? Disponível em: <https://stackoverflow.com/questions/35516840/what-does-the-use-of-a-colon-between-symbols-in-a-parameter-in-a-haskell-functio>.
29. MOO. What does the : infix operator do in Haskell? Disponível em: <https://stackoverflow.com/questions/1696751/what-does-the-infix-operator-do-in-haskell>.
30. GEEKSFORGEEKS. HTML input Tag. Disponível em: <https://www.geeksforgeeks.org/html/html-input-tag/>.
31. W3SCHOOLS. CSS Tutorial. Disponível em: <https://www.w3schools.com/css/>.
32. Juan Pedro Villa Isaza. STACK BUILDERS. Getting started with Haskell projects using Scotty. Disponível em: <https://www.stackbuilders.com/insights/getting-started-with-haskell-projects-using-scotty/>.
