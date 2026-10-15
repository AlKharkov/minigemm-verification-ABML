;;;; ABML model of the small C fragment employed by gemm_v0, gemm_v1, and gemm_v2.
;;;; Used to be as close to ISO/IEC 9899:2017 (a draft of C17) as possible.
;;;; Currently a little less pedantic.


;;; Names
(typedef "name" string)

(typedef "variable name" "name")

(typedef "function name" "name")

(typedef "parameter name" "name")

(typedef "constant" (uniont int 
                            real))


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
(typedef "expression" (uniont "variable access"
                              "constant"
                              "1[2]" 
                              "1*2"
                              "1+2"
                              "1<2"
                              "1=2"
                              "1+=2"
                              "++1"
                              "1(2)"))

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
(typedef "formula" (uniont ; Возможно, понадобятся импликации (if, implies, iff).
                    "and"
                    "or"
                    "not"
                    "exists"
                    "forall"
                    "pcall"
                    "logical constant"
                    "variable name"))

(typedef "logical constant"
         (enumt "true"
                "false"))

(cot "and" :at 1 (listt "formula"))

(cot "or" :at 1 (listt "formula"))

(cot "not" :at 1 "formula")

(cot "exists"
     :at 1 "variable name"
     :at 2 "formula")

(cot "forall"
     :at 1 "variable name"
     :at 2 "formula")

(cot "pcall"
     :at 1 "name"
     :at 2 (listt "term"))

; predicate decl

(cot "specification" 
     :at "precondition" (listt "formula") 
     #|:at "assigns" (listt (uniont "variable name"
                                  "range"))|#
     ;; Assign-clause вернём потом. Если понадобится. Пока не определились с моделью памяти
     :at "postcondition" "formula")

;;; Касательно термов: это зависит от того, в какой логике будем работать. Если в первого порядка, то отдельная сущность терм. Если высшего - "formula" менять на "term".
;;; Но при этом некоторые доказатели работают в логике первого порядка (и не всегда в обычной), а некоторые в логике высшего порядка (интерактивные).
;;; То есть придётся писать в одном, и если что поднимать или опускать.
;;; Подъём до логики высшего порядка как процедура звучит проще. Но при этом если мы перейдём на верхний уровень, то лучше писать в логике высшего порядка.
;;; Есть третий вариант. Как в ACL2. Если терм nil, то false, если не nil, то true.

;;; Terms
(typedef "term"
         (uniont "constant"
                 "variable name"
                 "fcall"))

(cot "fcall"
     :at "function" "function name"
     :at "args" (listt "term"))

; function decl
