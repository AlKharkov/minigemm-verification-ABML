; Names
(typedef "name" string)
(typedef "variable name" string)
(typedef "function name" string)
(typedef "parameter name" string)


; Types
(typedef "type" (uniont "int type" "float* type" "const float* type" "void" "__m256 type"))
(cot "int type")
(cot "float* type")
(cot "const float* type")
(cot "void")
(cot "__m256 type")


; Expressions
(typedef "expression" (uniont "C value" "variable acces" "1<2" "1+2" "1*2"))
(typedef "C value" (uniont bool int real))
(mot "variable acces" :at 1 "variable name")
(mot "1<2" :at 1 "expression" :at 2 "expression")
(mot "1+2" :at 1 "expression" :at 2 "expression")
(mot "1*2" :at 1 "expression" :at 2 "expression")
(mot "pointer access" :at 1 "variable name" :at 2 "expression")


; Declarations
(typedef "declaration" (uniont "var decl" "func decl"))
(mot "var decl" :at "type" "type" :at "name" "variable name" :at "value" "expression")
(mot "func decl" :at "return type" "type" 
                 :at "parameters" (listt "parameter") 
                 :at "body" "block"
                 :at "specification" "specification")  ; annotatiting attribute
(mot "parameter" :at "type" "type" :at "name" "parameter name")
(mot "block" :at "sts" (listt "statement"))


; Statements
(typedef "statement" (uniont "++1" "for stmt" "var decl" "1=2" "1+=2"))
(cot "++1" :at 1 "variable name")
(mot "for stmt" :at "init" "statement" :at "condition" "expression" :at "post" "statement" :at "body" "block")
(mot "1=2" :at 1 "expression" :at 2 "expression")
(mot "1+=2" :at 1 "expression" :at 2 "expression")


; Annotating constructions
; Может убрать из имени "formula" типов позиционную нотацию (например, "forall12" -> "forall")?
(typedef "formula" (uniont "and" "or" "not" "exists" "forall" "pcall"))
(cot "and" :at 1 (listt "formula"))
(cot "or" :at 1 (listt "formula"))
(cot "not" :at 1 "formula")
(cot "exists" :at 1 "variable name" :at 2 "formula")
(cot "forall" :at 1 "variable name" :at 2 "formula")
(cot "pcall" :at 1 "name" :at 2 (listt "term"))

(cot "range" :at 1 "variable name" :at 2 "expression" :at 3 "expression") ; mem_addr + (0 .. 7)

(cot "specification" 
    :at "pre condition" (listt "formula") 
    :at "assigns" (listt (uniont "variable name" "range")) 
    :at "post condition" "formula")
