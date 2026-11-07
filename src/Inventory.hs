module Inventory where
 
import Model
 
procurarPecas :: String -> [Peca] -> [Peca]
procurarPecas codigo = filter ((== codigo) . codigoArtigo . artigo)
 
-- Procura a peca com o codigo, tamanho e cor indicados e aplica a operacao.
-- Devolve True e o inventario atualizado se a operacao for aceite,
-- ou False e o inventario igual se for recusada.
alterarStock
  :: (Int -> Peca -> Maybe Peca)
  -> String -> Tamanho -> Cor -> Int -> [Peca] -> (Bool, [Peca])
alterarStock operacao codigo tam corEscolhida unidades pecas =
  case break coincide pecas of
    (antes, peca : depois) ->
      maybe (False, pecas)
            (\nova -> (True, antes ++ nova : depois))
            (operacao unidades peca)
    _ -> (False, pecas)
  where
    coincide peca =
      codigo == codigoArtigo (artigo peca)
        && tam == tamanho peca
        && corEscolhida == cor peca
 
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
 