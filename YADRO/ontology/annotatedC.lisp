;;;; C language fragment model with annotations
;;;; A fragment of the C language sufficient for the gemm_v0 and gemm_v1

;;;; ABML model of the small C fragment employed by gemm_v0, gemm_v1, and gemm_v2.
;;;; Used to be as close to ISO/IEC 9899:2017 (a draft of C17) as possible.
;;;; Currently a little less pedantic.


;;; Names
(typedef "name" string)

(typedef "variable name" "name")

(typedef "function name" "name")

(typedef "parameter name" "name")


;;; Types
(cot "type"
     :at "qualifier" (enumt "const")
     :at "specifier" (enumt "void"
                            "int"
                            "float"
                            "__m256")
     :at "pointer" (enumt "*"))


;;; Function definition
(mot "function definition"
     :at "type" "type"
     :at "name" "function name"
     :at "args" (listt "parameter")
     :at "body" (listt "statement")
     ;; annotating attribute
     :at "specification" "specification")

(mot "parameter"
     :at "type" "type"
     :at "name" "parameter name")


;;; Expressions
(typedef "expression" (uniont "constant"
                              "variable access"
                              "1[2]" 
                              "1*2"
                              "1+2"
                              "1<2"
                              "1=2"
                              "1+=2"
                              "++1"
                              "1(2)"))

(typedef "constant" (uniont int 
                            real))

(mot "variable access"
     :at "variable" "variable name")

(mot "1[2]"
     :at 1 "expression" :at 2 "expression")

(mot "++1" :at 1 "expression")

(mot "1*2"
     :at 1 "expression" :at 2 "expression")

(mot "1+2"
     :at 1 "expression" :at 2 "expression")

(mot "1<2"
     :at 1 "expression" :at 2 "expression")

(mot "1=2"
     :at 1 "expression" :at 2 "expression")

(mot "1+=2"
     :at 1 "expression" :at 2 "expression")

(mot "1(2)"
     :at 1 "function name"
     :at 2 (listt "expression"))


;;; Declarations
(mot "variable declaration"
     :at "type" "type"
     :at "name" "variable name"
     :at "initializer" "expression")


;;; Statements
(typedef "statement" (uniont "for (1; 2; 3) 4"
                             "variable declaration"
                             "expression"))

(mot "for (1; 2; 3) 4"
     :at 1 "variable declaration"
     :at 2 "expression"
     :at 3 "expression"
     :at 4 (listt "statement"))


;;; Annotating constructions
(cot "specification" 
     :at "precondition" (listt "formula") 
     ;:at "assigns" (listt (uniont "variable name" "range")) ; вернуться после создания модели памяти
     :at "postcondition" "formula")
