#!/usr/bin/env runhaskell
-- Filter.hs
import Text.Pandoc.JSON
import Data.Text
import Data.List

main :: IO ()
main = toJSONFilter press

press :: Inline -> Inline
press (Span (_,x:_,_) l) | x == pack "math-tex" = convert l
press x = x

convert :: [Inline] -> Inline
convert l = Math InlineMath (wrapalign ((Data.Text.dropEnd 2 (Data.Text.drop 2 (katex2latex (myconcat l))))))

myconcat :: [Inline] -> Text
myconcat l = (pack (Prelude.foldl (\ y (Str x) -> y++(unpack x)) "" (Prelude.map stringify l)))

stringify :: Inline -> Inline
stringify x@(Str _) = x
stringify Space = Str (pack " ")
stringify x = Str (pack " ")

katex2latex :: Text -> Text
katex2latex = fixweirdcharacters . fixnotequal . fixdegree

fixnotequal :: Text -> Text
fixnotequal = replace (pack "\\cancel=") (pack "\\neq")  . replace (pack "\\cancel{=}") (pack "\\neq")

-- zero width space
fixweirdcharacters :: Text -> Text
fixweirdcharacters = replace (pack "\x200B") (pack " ")

fixdegree :: Text -> Text
fixdegree = replace (pack "\\degree") (pack "^\\circ")

-- wrap align
wrapalign :: Text -> Text
wrapalign x = if (Data.Text.isInfixOf (pack "\\begin{aligned}") x) then x else (pack("\\begin{aligned}") <> x <> pack("\\end{aligned}"))