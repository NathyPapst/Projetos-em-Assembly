#Nathalia do Valle Papst
#3D
#31919928

.data 

Palavra:.asciiz "OrGaNiZaCaO"
Troca:.space 128 # Cria um espaço para a palavra que será invertida

.text

la $s1,Palavra # Carrega o endereço da palavra no registrador $s1
la $s2,Troca # Carrega o endereço do espaço livre para a palavra invertida no registrador $s2

addi $s0,$zero,0 # Criação de um registrador com o valor 0 para ser o contador

# Inverte o tamanho da letra (de maiúscula para minúscula e vice-versa)
tamLetra:
 lb $t0,0($s1) # Carrega o valor de $s1 no registrador $t0
 beq $t0,$zero,ultimo # Condicional para caso o valor de $t0 seja igual a 0, se sim pulará para 'ultimo'
  bgt $t0,'Z', min # Caso não entre na condicional de cima haverá outra concional para caso o valor de $t0 seja maior que a letra Z maiúscula na tabela ascii, se sim pulará para 'min'
   addi $t0,$t0,32 # Caso não entre na condicional de cima será adicionado 32 ao valor de $t0, isso fará com que a letra que antes era maiúscula se torne minúscula

# Pega a próxima letra da palavra
proxLetra:
 sb $t0,0($s1) # Carrega pra $s1 o valor de $t0
 addi $s1,$s1,1 # Incrementa uma posição da palavra, isso é, vai para a próxima letra
 addi $s0,$s0,1 # Incrementa o contador
 j tamLetra # Volta para 'tamLetra' para mudar o tamanho da próxima letra 

# Transforam a letra de minúscula para maiúscula  
min:
 sub $t0,$t0,32 # Subtrairá 32 do valor de $t0, assim transformando a letra que antes era minúscula para maiúscula 
 j proxLetra # Volta para 'proxLetra' para repetir o processo de mudar o tamanho das letras

# Chega ao fim da palavra    
ultimo:
 subi $s1,$s1,1 # Subtrai 1 do valor de $s1, porque se chegou aqui significa que $s1 tem um valor nulo que representa o fim da palavra 

# Inverte a palavra  
invPalavra:
 lb $t0,0($s1) # Carrega em $t0 o que está na atual posição de $s1
 sb $t0,0($s2) # Carrega pra $s2(espaço para a palavra invertida) o que está em $t0, isso é, o valor que estava em $s1
 beq $s0,$zero,result # Condicional para caso $s0(contador) seja igual a 0, se sim pulará para 'result'
  subi $s1,$s1,1 # Caso não entre na condicional acima será subtraido 1 de $s1(palavra original)
  addi $s2,$s2,1 # adicionará 1 a $s2(espaço para a palavra invertida)
  subi $s0,$s0,1 # Subtrairá 1 de $s0(contador)
  j invPalavra # Volta para 'invPalavra' para continuar invertendo a palavra
 
 #Imprime a palavra invertida
 result:
  li $v0,4
  la $a0,Troca
  syscall
