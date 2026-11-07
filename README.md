# Inventario de Loja - Fase 1

## Objetivo

O programa gere o stock de uma loja de roupa. Cada peca tem artigo, tamanho, cor, stock disponivel, stock minimo, stock alvo e vendas recentes. O sistema permite ver o inventario, pesquisar por codigo, vender, repor e consultar recomendacoes de reposicao.

Uma recomendacao aparece apenas quando o stock esta abaixo do minimo. A quantidade sugerida permite atingir o stock alvo. A media de vendas dos ultimos sete dias ajuda a definir a prioridade.

## Executar

Na pasta do projeto, execute:

```powershell
cabal run inventario-loja
```

## Comandos

- `ver` mostra todas as pecas.
- `recomendar` mostra as pecas abaixo do stock minimo.
- `pesquisar` procura todas as pecas de um codigo, por exemplo `CAM-01`.
- `vender` reduz o stock de uma peca, se existir quantidade suficiente.
- `repor` aumenta o stock de uma peca.
- `sair` termina o programa.

Para os tamanhos, escreva `S`, `M` ou `L`. Para as cores, escreva `Preta` ou `Branca`.

