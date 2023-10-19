## **Grupo O**
# Gabriel Salmoria 23100466
# Gustavo Nunes Viana 23100479

- demux1para4
#Descrição:
Dadas entradas f e sel, o demux 1-4 seleciona qual das saidas a, b, c, d recebe o sinal f.
Isso ocorre, por meio da estrutra de seleção when/else.

#Simulação:
Testa-se as quatro possibilidades de sel ascendentemente, cada uma levando 40 ns.
E entre 0 e 20 ns o f permanece zerado e posteriormente alterna de 40 em 40 ns.
Esse quebra de 0 a 20 ns gera um contratempo que evita problemas e facilita a visualiacao caso sel e f mudassem ao mesmo tempo.
Assim todas as possibilidades sao testadas.

- mux4para1
#Descrição: 
O Mux 4-1, com tamanho variável devido ao uso do generic, define para a saida y qual das entradas ela vai receber dependo do sel.
Implementação utilizando with/select.

#Simulação:
A chave cresce comecando do 0, mudando, por exemplo, para 1 em 60 ns, e enquanto isso,
as entradas a, b, c, d também variam.
Esse arquivo de estímulo tem como saída y, 0 1 0 1 1, apenas uma exemplificação, esses valores, obviamente, devem ter fomato de onda.

- BCD para Display de 7 segmentos
#Descrição: 
Dada uma entrada BCD(binary coded decimal) o dispositivo deve retornar a representação do número de 1 a 9 de maneira que,
quando exposto em um display de 7 segmentos, tal algarismo apareça visualmente.
Exemplo: entrada:0000 saida 0000001 onde 0 significa led acesso e 1 led desligado, ou seja, retorna o algarismo 0.

#Simulação:
Alterna pelo intervalo de 20 ns, entre os numeros 0, 4, 12, 1, 5, 6 e 8, em binario.
Obs: caso a entrada seja maior que 9 retorna-se 1111111, tudo apagado, como 12 no exemplo acima.

   - decodificadorBCD7Seg-case
        Decodificador BCD para Display de 7 segmentos usando process que "escuta" a entrada,
        e seleciona a saida utilizando case e 11 testes.

    
   - decodificadorBCD7Seg-logica
        Decodificador BCD para Display de 7 segmentos, para cada bit de saida foi necessaria uma expressão lógica única, 
        obtida através das propriedades de álgebra booleana, principalmente das portas lógicas and, or e not.

#Diferenças:
Usufruindo dos mecanismos process e case a construção do código foi fácil e intuitiva.
Já o decodificador lógico exigiu maior complexidade de resolução, devido a difícil confecção das expressōes lógicas.
