module Model where

import Data.Char (isDigit)

data Tamanho = XS | S | M | L
  deriving (Show, Eq)

data Cor = Preta | Branca
  deriving (Show, Eq)

data Artigo = Artigo
  { codigoArtigo :: String
  , nomeArtigo   :: String
  } deriving (Show, Eq)

data Peca = Peca
  { artigo          :: Artigo
  , tamanho         :: Tamanho
  , cor             :: Cor
  , stockDisponivel :: Int
  , stockMinimo     :: Int
  , stockAlvo       :: Int
  , vendasRecentes  :: [Int]
  } deriving (Show, Eq)

-- Só devem ser chamadas depois de tamanhoValido / corValida.
lerTamanho :: String -> Tamanho
lerTamanho "XS" = XS
lerTamanho "S" = S
lerTamanho "M" = M
lerTamanho "L" = L
lerTamanho _ = error "tamanho invalido"

lerCor :: String -> Cor
lerCor "Preta" = Preta
lerCor "Branca" = Branca
lerCor _ = error "cor invalida"

tamanhoValido :: String -> Bool
tamanhoValido "XS" = True
tamanhoValido "S"  = True
tamanhoValido "M"  = True
tamanhoValido "L"  = True
tamanhoValido _    = False

corValida :: String -> Bool
corValida "Preta"  = True
corValida "Branca" = True
corValida _        = False

-- Aceita um inteiro
quantidadeValida :: String -> Bool
quantidadeValida digitos       = soDigitos digitos

-- True se a string não for vazia e tiver apenas dígitos (recursivo).
soDigitos :: String -> Bool
soDigitos []     = False
soDigitos [c]    = isDigit c
soDigitos (c:cs) = isDigit c && soDigitos cs

-- Formato: CAM-01 | Camisola Basica | M | Preta | Stock: 4 | Minimo: 2 | Alvo: 6
formatarPeca :: Peca -> String
formatarPeca peca =
  codigoArtigo (artigo peca) ++ " | "
    ++ nomeArtigo (artigo peca) ++ " | "
    ++ show (tamanho peca) ++ " | "
    ++ show (cor peca) ++ " | "
    ++ "Stock: " ++ show (stockDisponivel peca) ++ " | "
    ++ "Minimo: " ++ show (stockMinimo peca) ++ " | "
    ++ "Alvo: " ++ show (stockAlvo peca)