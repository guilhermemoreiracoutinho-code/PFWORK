PFWORK

Objetivo

O programa permite gerir o stock de uma loja de roupa.

Cada peça do inventário contém as seguintes informações:
 Código do artigo;
 Nome do artigo;
 Tamanho;
 Cor;
 Stock disponível;
 Stock mínimo;
 Stock alvo;
 Vendas recentes.

O programa permite realizar as seguintes operações:
 Consultar todas as peças do inventário;
 Pesquisar peças pelo código do artigo;
 Vender uma peça, reduzindo o stock;
 Repor uma peça, aumentando o stock;
 Terminar o programa.

## Como executar o programa ##

Na pasta principal do projeto, executar o comando:

cabal run inventario-loja

Depois de iniciar, o programa apresenta o menu e aguarda que o utilizador escreva um comando e carregue em Enter.

Comandos: ver | recomendar | pesquisar | vender | repor | sair
Opcao:

## Dados a introduzir ##

Durante a utilização do programa, podem ser solicitados os seguintes dados:

 Campo       Formato             Exemplo 
 Código      Código do artigo    CAM-01 
 Tamanho     XS, S, M ou L       M 
 Cor         Preta ou Branca     Preta 
 Quantidade  Número inteiro      2 

O programa distingue letras maiúsculas de minúsculas. Deve escrever os valores exatamente como indicado.

## Comandos disponíveis ##

## Ver inventário — ver ##

Apresenta todas as peças existentes no inventário.

Formato apresentado:

Codigo | Nome do artigo | Tamanho | Cor | Stock | Minimo | Alvo

Exemplo:

CAM-01 | Camisola Basica | M | Preta | Stock: 4 | Minimo: 2 | Alvo: 6

## Recomendar — `recomendar` ##

Indica a quantidade a repor para atingir o stock alvo


## Pesquisar artigo — `pesquisar` ##

Procura todas as peças associadas a um determinado código de artigo, independentemente do tamanho ou da cor.

Pede o código do artigo.

Exemplo:

Codigo do artigo: CAM-01

Resultado: Apresenta todas as peças encontradas com esse código, utilizando o mesmo formato do comando ver.

Caso não exista nenhuma peça com esse código, não apresenta resultados.

## Vender artigo — `vender` ##

Vende uma determinada peça/peças escolhida.

Pede os seguintes dados, introduzidos individualmente:
. Código do artigo;
. Tamanho (XS, S, M ou L);
. Cor (Preta ou Branca);
. Quantidade a vender.

Exemplo:


Codigo: CAM-01
Tamanho (XS, S, M ou L): M
Cor (Preta ou Branca): Preta
Quantidade: 2
True

True: A venda foi aceite e o stock foi reduzido.
False: A venda foi recusada e o stock permaneceu igual.

A venda é recusada quando:
A quantidade é superior ao stock disponível;
A quantidade é zero ou negativa;
A peça não existe no inventário.

### Repor stock — `repor` ##

Reposição de stock disponível de uma determinada peça.

Pede oss mesmos dados solicitados no comando vender:
. Código do artigo;
. Tamanho;
. Cor;
. Quantidade a repor.

Resultados possíveis:
True: A reposição foi aceite e o stock aumentou.
False: A reposição foi recusada e o stock permaneceu igual.

A reposição é recusada quando:
A quantidade é zero ou negativa;
A peça não existe no inventário.
 
### Sair — `sair` ##

O que faz: Termina a execução do programa.

### Tamanho ou cor inválidos ##

Se for introduzido um tamanho ou uma cor inválidos, por exemplo XL ou preta, o programa termina com um erro "tamanho invalido" ou "cor invalida"

### Quantidade inválida ##

A quantidade deve ser introduzida como um número inteiro.

Se for introduzido texto ou outro valor que não corresponda a um número inteiro, o programa termina com um erro.

### Peças fixas ##

Não é possível adicionar ou remover peças através do menu.

Todas as peças disponíveis são definidas previamente no ficheiro src/Examples.hs.

## Estrutura do projeto ##

O projeto encontra-se organizado da seguinte forma:

inventario-loja/
│
├── app/
│   └── Main.hs
│
├── src/
│   ├── Model.hs
│   ├── Inventory.hs
│   └── Examples.hs
│
├── cabal.project
│
└── inventario-loja.cabal

Descrição dos ficheiros


 Main.hs  Apresenta o menu, lê os comandos e gere a interação com o utilizador. 
 Model.hs  Define os tipos de dados, incluindo Tamanho, Cor, Artigo e Peca. 
 Inventory.hs  Implementa as operações de pesquisa, venda e reposição de stock. 
 Examples.hs  Contém as peças e os dados iniciais utilizados para demonstrar o funcionamento do programa. 
 cabal.project  Configuração geral do projeto Cabal. 
 inventario-loja.cabal  Define a configuração, dependências e componentes do projeto. 