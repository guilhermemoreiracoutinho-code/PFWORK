module Main where

import System.IO
import Model
import Inventory
import Examples

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
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


pedirOperacao :: Int -> [Peca] -> IO [Peca]
pedirOperacao sinal inventario = do
  putStr "Codigo: "
  codigo <- getLine
  putStr "Tamanho (XS, S, M ou L): "
  textoTamanho <- getLine
  putStr "Cor (Preta ou Branca): "
  textoCor <- getLine
  putStr "Quantidade: "
  textoUnidades <- getLine

  if not (tamanhoValido textoTamanho) then do
    putStrLn "Tamanho invalido."
    return inventario
  else if not (corValida textoCor) then do
    putStrLn "Cor invalida."
    return inventario
  else if not (quantidadeValida textoUnidades) then do
    putStrLn "Quantidade invalida."
    return inventario
  else do
    let unidades = read textoUnidades
        (aceite, novoInventario) =
          alterarStock sinal codigo (lerTamanho textoTamanho)
            (lerCor textoCor) unidades inventario
    print aceite
    return novoInventario