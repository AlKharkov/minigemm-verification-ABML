; Names
(typedef "name" string)
(typedef "variable name" string)
(typedef "function name" string)


; Types
(typedef "type" (uniont "int type" "float* type" "const float* type" "void"))
(cot "int type")
(cot "float* type")
(cot "const float* type")
(cot "void")


; Expressions
(typedef "expression" (uniont "C value" "variable acces" "1<2" "1+2"))
(typedef "C value" (uniont bool int real))
(mot "variable acces" :at 1 "variable name")
(mot "1<2" :at 1 "expression" :at 2 "expression")
(mot "1+2" :at 1 "expression" :at 2 "expression")
(mot "pointer access" :at 1 "variable name" :at 2 "expression")


; Statements
(typedef "statement" (uniont "++1" "for stmt" "var decl" "1=2" "1+=2"))
(cot "++1" :at 1 "variable name")
(mot "for stmt" :at "init" "statement" :at "condition" "expression" :at "post" "statement" :at "body" "block")
(mot "block" :at "sts" (listt "statement"))
(mot "var decl" :at "type" "type" :at "name" "variable name" :at "value" "expression")
(mot "1=2" :at 1 "expression" :at 2 "expression")
(mot "1+=2" :at 1 "expression" :at 2 "expression")


; Annotating constructions
; Может убрать из имени "formula" типов позиционную нотацию (например, "forall12" -> "forall")?
(typedef "formula" (uniont "and1" "or1" "not1" "exists1" "forall12" "pcall12"))
(cot "and1" :at 1 (listt "formula"))
(cot "or1" :at 1 (listt "formula"))
(cot "not1" :at 1 "formula")
(cot "exists12" :at 1 "variable name" :at 2 "formula")
(cot "forall12" :at 1 "variable name" :at 2 "formula")
(cot "pcall12" :at 1 "name" :at 2 (listt "term"))

(cot "range" :at 1 "variable name" :at 2 "expression" :at 3 "expression") ; mem_addr + (0 .. 7)

(cot "specification" 
    :at "pre condition" (listt "formula") 
    :at "assigns" (listt (uniont "variable name" "range")) 
    :at "post condition" "formula")


; In development
(mot "cell" :at "type" "type" :at "value" "C value")
(mot "var addr" :at )
