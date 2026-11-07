module Model where

data Tamanho = S | M | L
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
 