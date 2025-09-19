# Identificação:
Nome: Adrian Bellé Secretti <br>
Curso: Sistemas de Informação

# Tema:
Este projeto se trata de um sistema para converter um número em uma determinada base para seu equivalente em outra base. <br>
Também implementei um sistema de codificação e decodificação de código morse. <br>
O sistema suporta números nas bases 2 até 64. Os caracteres aceitos são (0-9), (A-Z), (a-z), '+' e '/'. <br>
A menor base possível é 2 (sistema binário) porque não seria possível uma base 1. <br>
A maior base é 64 porque há um limite de caracteres reconhecidos como dígitos. <br>
Por enquanto, não há suporte para números com vírgula. <br>

# Desenvolvimento:
Decidi usar como base o sistema Base64, que usa os caracteres (0-9), (A-Z), (a-z), '+' e '/', como mencionado acima. <br>
Para converter de base X para base Y, é necessário primeiro converter base X para base 10 e depois base 10 para base Y. <br>
Para a conversão de código morse, apenas separei cada letra do texto usei um sistema com switch-case para a conversão. <br>
<br> <br>
![image](https://images.sampletemplates.com/wp-content/uploads/2015/05/12144219/Morse-Code-Chart-to-Download.jpg)

## Para converter de base X para base 10, se usa a seguinte fórmula:
```soma(base ^ peso * dígito; do dígito menos significativo ao mais significativo)```
<br> <br>
![image](https://wikimedia.org/api/rest_v1/media/math/render/svg/ed875ba981decb322a05335f7efdb5490244d67f)

## Para converter de base 10 para base Y, se usa o método das divisões sucessivas, que se trata de:
1. Dividir o número por Y e pegar os restos até chegar a 0.
2. Os restos serão o número na base Y.

<br> <br>
![image](https://homework.study.com/cimages/multimages/16/capture14204776639827140608.png)

# Execução:
Deixei dois arquivos de teste, um para testar as funções de conversão de bases e outro para o conversor de morse, ambos usando o IO padrão do haskell. <br>
O site em si está no arquivo scotty.hs, que abre em servidor na porta 3000. <br>
Para executar, acessar os seguintes links:
1. http://localhost:3000/morse/encode
2. http://localhost:3000/morse/decode

# Referências:
1. https://en.wikipedia.org/wiki/Base64
2. https://www.mathsisfun.com/numbers/bases.html
3. https://www.geeksforgeeks.org/digital-logic/number-system-and-base-conversions/
4. https://en.wikipedia.org/wiki/Numeral_system
5. https://math.ucr.edu/~jbritton/BaseConversionGuide.pdf
6. https://stackoverflow.com/questions/3261236/how-to-get-the-ascii-value-of-a-character-in-haskell
7. https://www.britannica.com/topic/International-Morse-Code
