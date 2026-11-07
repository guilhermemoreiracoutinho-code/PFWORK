module Examples (inventarioExemplo) where

import Model

camisola, tShirt :: Artigo
camisola = Artigo "CAM-01" "Camisola Basica"
tShirt   = Artigo "TSH-02" "T-shirt Classica"

-- Dez peças de demonstração. Cada lista contém as vendas de sete dias.
inventarioExemplo :: [Peca]
inventarioExemplo =
  [ Peca camisola S Preta   1 2 6 [2,1,2,3,1,2,2]
  , Peca camisola S Branca  2 2 5 [0,1,0,1,0,1,0]
  , Peca camisola M Preta   4 2 6 [1,2,1,1,2,1,2]
  , Peca camisola M Branca  0 1 4 [3,2,4,3,2,3,4]
  , Peca camisola L Preta   3 2 5 [0,1,0,0,1,0,0]
  , Peca camisola L Branca  1 3 5 [1,1,2,1,2,1,1]
  , Peca tShirt S Preta     2 3 7 [4,3,5,4,4,3,5]
  , Peca tShirt S Branca    5 2 6 [1,1,0,1,1,0,1]
  , Peca tShirt M Preta     1 2 5 [2,2,3,2,3,2,3]
  , Peca tShirt M Branca    2 2 5 [0,0,1,0,1,0,0]
  ]
 