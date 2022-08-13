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
convert = Math InlineMath . fixorphannewline . Data.Text.dropEnd 2 . Data.Text.drop 2 . katex2latex . myconcat

myconcat :: [Inline] -> Text
myconcat l = (pack (Prelude.foldl (\ y (Str x) -> y++(unpack x)) "" (Prelude.map stringify l)))

stringify :: Inline -> Inline
stringify x@(Str _) = x
stringify Space = Str (pack " ")
stringify x = Str (pack " ")

katex2latex :: Text -> Text
katex2latex = fixweirdcharacters . fixnotequal . fixdegree . fixnewline

fixnotequal :: Text -> Text
fixnotequal = replace (pack "\\cancel=") (pack "\\neq") . replace (pack "\\cancel{=}") (pack "\\neq")

fixweirdcharacters :: Text -> Text
fixweirdcharacters = fixzerowidthspace . fixextraspace

fixzerowidthspace :: Text -> Text
fixzerowidthspace = replace (pack "\x200B") (pack " ")

fixextraspace :: Text -> Text
fixextraspace = replace (pack "\\end {") (pack "\\end{") . replace (pack "\\begin {") (pack "\\begin{")

fixdegree :: Text -> Text
fixdegree = replace (pack "\\degree") (pack "^\\circ")

fixnewline :: Text -> Text
fixnewline = replace (pack "\\newline") (pack "")

fixorphannewline :: Text -> Text
fixorphannewline x = if (Data.Text.isInfixOf (pack "\\begin{aligned") x)
    then wrapalign x
    else wrapalign x

wrapalign :: Text -> Text
wrapalign x = (pack("\\begin{aligned}") <> x <> pack("\\end{aligned}"))

-- here I assume all pairs of \begin{aligned} and \end{aligned} are balanced
