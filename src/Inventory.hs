module Inventory where
 
import Model
 
procurarPecas :: String -> [Peca] -> [Peca]
procurarPecas _ [] = []
procurarPecas codigo (peca:resto)
  | codigo == codigoArtigo (artigo peca) =
      peca : procurarPecas codigo resto
  | otherwise = procurarPecas codigo resto
 
-- sinal: -1 para vender (tira stock), 1 para repor (acrescenta stock).
-- Devolve True e o inventario atualizado se a operacao for aceite,
-- ou False e o inventario igual se for recusada.
alterarStock :: Int -> String -> Tamanho -> Cor -> Int -> [Peca] -> (Bool, [Peca])
alterarStock _ _ _ _ _ [] = (False, [])
alterarStock sinal codigo tam corEscolhida unidades (peca:resto)
  | codigo == codigoArtigo (artigo peca)
    && tam == tamanho peca
    && corEscolhida == cor peca =
      if unidades > 0 && novoStock >= 0
      then (True, peca { stockDisponivel = novoStock } : resto)
      else (False, peca : resto)
  | otherwise =
      let (aceite, novoResto) =
            alterarStock sinal codigo tam corEscolhida unidades resto
      in (aceite, peca : novoResto)
  where
    novoStock = stockDisponivel peca + sinal * unidades
 