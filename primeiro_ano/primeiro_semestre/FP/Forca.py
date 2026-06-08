import secrets
import unicodedata

def letra_acentuada(palavra_aleatoria, tentativa):
    
    # Itinerar sobre a palavra
    for letra in palavra_aleatoria:

        # Mostrar acentos
        letra_normalizada = unicodedata.normalize('NFD', letra)
        
        # Existe acento
        if len(letra_normalizada) > 1:
            letra_base = letra_normalizada[0]      
                    
            # Verificar tentativa com acento
            if letra_base == tentativa:  
                return True, letra 
    return False, None

def finalizar():    # Função de finilizar o jogo
    
    finalizar = input("Deseja continuar? (sim, nao) ")
    if finalizar == "sim":
        main()
    elif finalizar == "nao":
        print("Obrigado por jogares!")
        exit()
    else:
        print("Opção inválida.")
        finalizar()

    return None

def jogo(palavra_aleatoria, tentativa, palavra_mostrada, letras_usadas):     # Função geral (chama outras)

    tentativa_original = tentativa

    # Letras acentuadas
    tem_acento, letra_com_acento = letra_acentuada(palavra_aleatoria, tentativa)
    if tem_acento:
        tentativa = letra_com_acento

    # Verificar se a letra foi usada
    if tentativa in letras_usadas or tentativa in palavra_mostrada:
        return "repetido", palavra_mostrada, letras_usadas, tentativa

    # Atualizar lista com tentativa (não repetida)
    letras_usadas.append(tentativa)

    # Verificar se a letra não esta na palavra
    if tentativa not in palavra_aleatoria:
        return "errado", palavra_mostrada, letras_usadas, tentativa
        
    # Atualizar letras na palavra_mostrada
    letras_descobertas_atualizadas = [
        letra if (letra == tentativa or letra == tentativa_original or letra in palavra_mostrada) else "_" 
        for letra in palavra_aleatoria    
    ]

    # Print do jogo
    palavra_mostrada = "".join(letras_descobertas_atualizadas)
    print(palavra_mostrada)

    return "acertou", palavra_mostrada, letras_usadas, tentativa
    
def desenhar_boneco(contador):      # Função de desenho do boneco

    print("...")

    return None

def main():

    letras_usadas = []
    contador = 0
    print("Bem vindo ao jogo da forca!")
    
    # Leitura do ficheiro
    with open("secret.txt", "r", encoding="utf-8") as ficheiro:     
        lista_palavras = ficheiro.read().split()                                  
    
    palavra_aleatoria = secrets.choice(lista_palavras)                      # Modulo secrest para escolher uma palavra
    palavra_mostrada = "_" * len(palavra_aleatoria)
    palavra_aleatoria = palavra_aleatoria.lower()
    while True:
        # Proteção em maiusculas
        tentativa = input("Digite sua tentativa: ").lower().strip()         

        # Proteção números e tamanho
        if len(tentativa) != 1 or not tentativa.isalpha():
            print("Por favor, digite apenas uma letra.")
            continue

        status, palavra_mostrada, letras_usadas, tentativa = jogo(palavra_aleatoria, tentativa, palavra_mostrada, letras_usadas)
           
        # Verificar tentativa
        match status:
            
            # Letra descoberta    
            case "acertou":
                
                # Validação para evitar contagem errada em acentuações
                palavra_limpa = unicodedata.normalize('NFD', palavra_aleatoria).encode('ascii', 'ignore').decode('utf-8')   # Palavra sem acento
                letra_limpa = unicodedata.normalize('NFD', tentativa).encode('ascii', 'ignore').decode('utf-8')             # Letra sem acento
                print("Parabéns! A letra '{}' existe '{}' vezes!".format(letra_limpa, palavra_limpa.count(letra_limpa)))

            # Verificar se o jogador ganhou
                if "_" not in palavra_mostrada:
                    print("\nParabéns! Descobriste a palavra: {}!".format(palavra_aleatoria))
                    finalizar()
                    break
            
            # Letra repitida
            case "repetido":
                print("Letra já utilizada! Tente novamente!")
                print("Letras usadas: {}".format(letras_usadas))
                print("Jogo: {}" .format(palavra_mostrada))
            
            # Letra errada
            case "errado":
                contador += 1
                desenhar_boneco(contador)
                
                # Finalização
                if contador == 7:
                    print("\nInfelizmente erraste, a palavra era: {}!".format(palavra_aleatoria))
                    finalizar()
    
if __name__ == "__main__":
    main()