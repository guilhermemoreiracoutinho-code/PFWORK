module Inventory where
 
import Model
 
procurarPecas :: String -> [Peca] -> [Peca]
procurarPecas _ [] = []
procurarPecas codigo (peca:resto)
  | codigo == codigoArtigo (artigo peca) =
      peca : procurarPecas codigo resto
  | otherwise = procurarPecas codigo resto
 
-- Procura a peca com o codigo, tamanho e cor indicados e aplica a operacao.
-- Devolve True e o inventario atualizado se a operacao for aceite,
-- ou False e o inventario igual se for recusada.
alterarStock
  :: (Int -> Peca -> Maybe Peca)
  -> String -> Tamanho -> Cor -> Int -> [Peca] -> (Bool, [Peca])
alterarStock _ _ _ _ _ [] = (False, [])
alterarStock operacao codigo tam corEscolhida unidades (peca:resto)
  | codigo == codigoArtigo (artigo peca)
    && tam == tamanho peca
    && corEscolhida == cor peca =
      case operacao unidades peca of
        Just nova -> (True, nova : resto)
        Nothing -> (False, peca : resto)
  | otherwise =
      let (aceite, novoResto) =
            alterarStock operacao codigo tam corEscolhida unidades resto
      in (aceite, peca : novoResto)
 
registarVenda :: String -> Tamanho -> Cor -> Int -> [Peca] -> (Bool, [Peca])
registarVenda = alterarStock $ \unidades peca ->
  if unidades > 0 && stockDisponivel peca >= unidades
    then Just peca { stockDisponivel = stockDisponivel peca - unidades }
    else Nothing
 
registarReposicao :: String -> Tamanho -> Cor -> Int -> [Peca] -> (Bool, [Peca])
registarReposicao = alterarStock $ \unidades peca ->
  if unidades > 0
    then Just peca { stockDisponivel = stockDisponivel peca + unidades }
    else Nothing
 