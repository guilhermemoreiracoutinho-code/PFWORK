module Main where

import Model
import Inventory
import Examples
import Data.List (intercalate)

main :: IO ()
main = do
  putStrLn "=== INVENTARIO DA LOJA ==="
  executar inventarioExemplo

executar :: [Peca] -> IO ()
executar inventario = do
  putStrLn "\nComandos: ver | pesquisar | vender | repor | sair"
  putStr "Opcao: "
  comando <- getLine

  case comando of
    "ver" -> do
      mapM_ (putStrLn . formatarPeca) inventario
      executar inventario

    "pesquisar" -> do
      putStr "Codigo do artigo: "
      codigo <- getLine
      mapM_ (putStrLn . formatarPeca) (procurarPecas codigo inventario)
      executar inventario

    "vender" -> do
      novoInventario <- pedirOperacao registarVenda inventario
      executar novoInventario

    "repor" -> do
      novoInventario <- pedirOperacao registarReposicao inventario
      executar novoInventario

    "sair" ->
      putStrLn "Programa terminado."

    _ -> do
      putStrLn "Comando nao reconhecido."
      executar inventario

-- Pede codigo, tamanho, cor e quantidade e aplica a operacao (venda ou reposicao).
pedirOperacao
  :: (String -> Tamanho -> Cor -> Int -> [Peca] -> (Bool, [Peca]))
  -> [Peca] -> IO [Peca]
pedirOperacao operacao inventario = do
  putStr "Codigo: "
  codigo <- getLine
  putStr "Tamanho (S, M ou L): "
  textoTamanho <- getLine
  putStr "Cor (Preta ou Branca): "
  textoCor <- getLine
  putStr "Quantidade: "
  unidades <- readLn

  let (aceite, novoInventario) =
        operacao codigo (lerTamanho textoTamanho) (lerCor textoCor)
          unidades inventario
  print aceite
  return novoInventario

lerTamanho :: String -> Tamanho
lerTamanho "S" = S
lerTamanho "M" = M
lerTamanho "L" = L
lerTamanho _ = S

lerCor :: String -> Cor
lerCor "Preta" = Preta
lerCor "Branca" = Branca
lerCor _ = Preta

-- Formato: CAM-01 | Camisola Basica | M | Preta | Stock: 4 | Minimo: 2 | Alvo: 6
formatarPeca :: Peca -> String
formatarPeca peca =
  intercalate " | "
    [ codigoArtigo (artigo peca)
    , nomeArtigo (artigo peca)
    , show (tamanho peca)
    , show (cor peca)
    , "Stock: " ++ show (stockDisponivel peca)
    , "Minimo: " ++ show (stockMinimo peca)
    , "Alvo: " ++ show (stockAlvo peca)
    ]
 