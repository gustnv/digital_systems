import random
import numpy as np

# Par de memoria com 16 linhas e 32 bits por linhas, separado em 4 numeros de 8 bits(0 a 255)
mem_a = [0]*16
for i in range(16):
    mem_a[i] = [0]*4
mem_b = [0]*16
for i in range(16):
    mem_b[i] = [0]*4

def gerar_numero(mem_a, mem_b):
    for i in range(16):
       for j in range(4):
           mem_a[i][j] = random.randint(0, 255)
           mem_b[i][j] = random.randint(0, 255)
    return (mem_a, mem_b)

def sub(mem_a, mem_b):
    subtracao = 0
    for i in range(16):
        for j in range(4):
            subtracao += abs(mem_b[i][j] - mem_a [i][j])
    return subtracao

def binario(mem):
    for i in range(16):
        for j in range(4):
            mem[i][j] = format(mem[i][j], '08b')
    return mem

def concatena(mem):
    for i in range(16):
        resultado = ''
        for j in range(4):
            resultado += mem[i][j]
        mem[i] = resultado
    return mem

def salva(mem_a, mem_b, subtracao):
    with open("estimulos.dat", "a") as arquivo:
        for i in range(16):
            arquivo.write(f"{mem_a[i]} {mem_b[i]} ")
        arquivo.write(f"{subtracao} \n")


# Zerando o arquivo estimulo.dat
with open("estimulos.dat", "w") as arquivo:
    arquivo.write("")

# Criando os numeros, subtraindo, transformando pra binario e escrevendo no arquivo
for _ in range(50):
    mem_a = [0]*16
    for i in range(16):
        mem_a[i] = [0]*4
    mem_b = [0]*16
    for i in range(16):
        mem_b[i] = [0]*4
    mem_a, mem_b = gerar_numero(mem_a, mem_b)
    subtracao = int(sub(mem_a, mem_b))
    mem_a_bin = binario(mem_a)
    mem_b_bin = binario(mem_b)
    subtracao_bin = format(subtracao, '014b')
    mem_a_concatenado = concatena(mem_a_bin)
    mem_b_concatenado = concatena(mem_b_bin)
    salva(mem_a_concatenado, mem_b_concatenado, subtracao_bin)







