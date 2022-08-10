#!/usr/bin/env runhaskell
-- behead.hs
import Text.Pandoc.JSON
import Data.Text

main :: IO ()
main = toJSONFilter press

press :: Inline -> Inline
-- press (Span (a,(y:ys),c) xs) | y == pack "math-tex" = (Span (a,ys,c) (ass xs))
press (Span (a,(y:ys),c) xs) | y == pack "math-tex" = Prelude.head (ass xs)
press x = x

ass :: [Inline] -> [Inline]
ass ((Str x):xs) = [Math InlineMath (Data.Text.dropEnd 2 (Data.Text.drop 2 x))]
ass xs = xs

-- hole :: Inline -> Inline
-- hole ((Str x):xs) = [Math InlineMath  x]
-- hole xs = xs


-- (a,(y:ys),c)     (a,ys,c)

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