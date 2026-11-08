module Main where

import Model
import Inventory
import Examples

main :: IO ()
main = do
  putStrLn "=== INVENTARIO DA LOJA ==="
  executar inventarioExemplo

executar :: [Peca] -> IO ()
executar inventario = do
  putStrLn "\nComandos: ver | recomendar | pesquisar | vender | repor | sair"
  putStr "Opcao: "
  comando <- getLine

  case comando of
    "ver" -> do
      mostrarPecas inventario
      executar inventario

    "recomendar" -> do
      mostrarRecomendacoes (recomendacoes inventario)
      executar inventario

    "pesquisar" -> do
      putStr "Codigo do artigo: "
      codigo <- getLine
      mostrarPecas (procurarPecas codigo inventario)
      executar inventario

    "vender" -> do
      novoInventario <- pedirOperacao (-1) inventario
      executar novoInventario

    "repor" -> do
      novoInventario <- pedirOperacao 1 inventario
      executar novoInventario

    "sair" ->
      putStrLn "Programa terminado."

    _ -> do
      putStrLn "Comando nao reconhecido."
      executar inventario

mostrarPecas :: [Peca] -> IO ()
mostrarPecas [] = return ()
mostrarPecas (peca:resto) = do
  putStrLn (formatarPeca peca)
  mostrarPecas resto

mostrarRecomendacoes :: [(Peca, Int)] -> IO ()
mostrarRecomendacoes [] = return ()
mostrarRecomendacoes ((peca, n):resto) = do
  putStrLn (formatarPeca peca ++ " | Repor: " ++ show n)
  mostrarRecomendacoes resto

-- sinal: -1 para vender (tira stock), 1 para repor (acrescenta stock)
pedirOperacao :: Int -> [Peca] -> IO [Peca]
pedirOperacao sinal inventario = do
  putStr "Codigo: "
  codigo <- getLine
  putStr "Tamanho (XS, S, M ou L): "
  textoTamanho <- getLine
  putStr "Cor (Preta ou Branca): "
  textoCor <- getLine
  putStr "Quantidade: "
  unidades <- readLn

  let (aceite, novoInventario) =
        alterarStock sinal codigo (lerTamanho textoTamanho) (lerCor textoCor)
          unidades inventario
  print aceite
  return novoInventario