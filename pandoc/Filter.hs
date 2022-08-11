#!/usr/bin/env runhaskell
-- Filter.hs
import Text.Pandoc.JSON
import Data.Text

main :: IO ()
main = toJSONFilter press

press :: Inline -> Inline
press (Span (a,(y:ys),c) xs) | y == pack "math-tex" = Prelude.head (convert xs)
press x = x

convert :: [Inline] -> [Inline]
convert ((Str x):xs) = [Math InlineMath (Data.Text.dropEnd 2 (Data.Text.drop 2 x))]
convert xs = xs

-- EXAMPLE INPUT PANDOC AST
-- 
-- Pandoc
--   Meta { unMeta = fromList [] }
--   [ Para
--       [ Span
--           ( "" , [ "math-tex" ] , [] )
--           [ Str "\\(\\alpha^2+*c\\alpha+*d\\beta^2+*e\\beta\\)" ]
--       ]
--   , BulletList
--       [ [ Plain
--             [ Span
--                 ( "" , [ "math-tex" ] , [] )
--                 [ Str
--                     "\\(\\left(\\alpha+*f\\beta\\right)\\left(\\alpha+*g\\beta+*h\\right)\\)"
--                 ]
--             ]
--         ]
--       ]
--   , Para [ Str "\160" ]
--   ]
-- 
