#!/usr/bin/env runhaskell
-- Filter.hs
import Text.Pandoc.JSON
import Data.Text

main :: IO ()
main = toJSONFilter press

press :: Inline -> Inline
press (Span (_,x:_,_) l) | x == pack "math-tex" = convert l
press x = x

convert :: [Inline] -> Inline
convert l = Math InlineMath (Data.Text.dropEnd 2 (Data.Text.drop 2 (fixdegree (myconcat l)))) 

myconcat :: [Inline] -> Text
myconcat l = (pack (Prelude.foldl (\ y (Str x) -> y++(unpack x)) "" (Prelude.map stringify l)))

stringify :: Inline -> Inline
stringify x@(Str _) = x
stringify Space = Str (pack " ")

fixdegree :: Text -> Text
fixdegree x = replace (pack "\\degree") (pack "°") x

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
