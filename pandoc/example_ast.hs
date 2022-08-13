-- EXAMPLE INPUT PANDOC AST

Pandoc
  Meta { unMeta = fromList [] }
  [ Para
      [ Span
          ( "" , [ "math-tex" ] , [] )
          [ Str "\\(\\alpha^2+*c\\alpha+*d\\beta^2+*e\\beta\\)" ]
      ]
  , BulletList
      [ [ Plain
            [ Span
                ( "" , [ "math-tex" ] , [] )
                [ Str
                    "\\(\\left(\\alpha+*f\\beta\\right)\\left(\\alpha+*g\\beta+*h\\right)\\)"
                ]
            ]
        ]
      ]
  , Para [ Str "\160" ]
  ]
