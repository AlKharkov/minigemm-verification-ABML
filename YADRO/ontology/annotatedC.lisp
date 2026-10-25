#| 
     C language fragment model with annotations
     A fragment of the C language sufficient for the gemm_v0 and gemm_v1

     ABML model of the small C fragment employed by gemm_v0, gemm_v1, and gemm_v2.
     Used to be as close to ISO/IEC 9899:2017 (a draft of C17) as possible.
     Currently a little less pedantic.
|#


;;; ================================
;;; Names
;;; ================================
(typedef "name" string)

(typedef "variable name" "name")

(typedef "function name" "name")

(typedef "parameter name" "name")


;;; ================================
;;; Types
;;; ================================
(otype "type"
    (:at "qualifier" (:enum "const"))
    (:at "specifier" (:enum "void"
                            "int"
                            "float"
                            "__m256"))
    (:at "pointer" (:enum "*")))


;;; ================================
;;; Function definition
;;; ================================
(otype "function definition"
    (:at "type" "type")
    (:at "name" "function name")
    (:at "args" (:list "parameter"))
    (:at "body" (:list "statement"))
    ;; annotating attribute
    (:at "specification" "specification"))

(otype "parameter"
    (:at "type" "type")
    (:at "name" "parameter name"))


;;; ================================
;;; Expressions
;;; ================================
(typedef "expression" (:union "constant"
                              "variable access"
                              "1[2]" 
                              "1*2"
                              "1+2"
                              "1<2"
                              "1=2"
                              "1+=2"
                              "++1"
                              "1(2)"))

(typedef "constant" (:union int 
                            real))

(otype "variable access"
    (:at "variable" "variable name"))

(otype "1[2]"
    (:at "1" "expression") 
    (:at "2" "expression"))

(otype "++1" 
    (:at "1" "expression"))

(otype "1*2"
    (:at "1" "expression")
    (:at "2" "expression"))

(otype "1+2"
    (:at "1" "expression")
    (:at "2" "expression"))

(otype "1<2"
    (:at "1" "expression")
    (:at "2" "expression"))

(otype "1=2"
    (:at "1" "expression")
    (:at "2" "expression"))

(otype "1+=2"
    (:at "1" "expression")
    (:at "2" "expression"))

(otype "1(2)"
    (:at "1" "function name")
    (:at "2" (:list "expression")))


;;; ================================
;;; Declarations
;;; ================================
(otype "variable declaration"
    (:at "type" "type")
    (:at "name" "variable name")
    (:at "initializer" "expression"))


;;; ================================
;;; Statements
;;; ================================
(typedef "statement" (:union "for (1; 2; 3) 4"
                             "variable declaration"
                             "expression"
                             "annotating statements"))

(otype "for (1; 2; 3) 4"
    (:at "1" "variable declaration")
    (:at "2" "expression")
    (:at "3" "expression")
    (:at "4" (:list "statement")))


;;; ================================
;;; Memory
;;; ================================
(otype "memory" 
    (:at "single" (:map "variable name" "cell")) ; для отдельных ячеек памяти (число, строка, ссылка)
    (:at "tape"   (:map "variable name" (:list "cell")))) ; для последовательных участков памяти (массив, структура)

(otype "cell" 
    (:at "value" "constant"))


;;; ================================
;;; Annotating constructions
;;; ================================
(otype "specification" 
    (:at "precondition" (:list "formula"))
    ;:at "assigns" (:list (:union "variable name" "range")) ; вернуться после создания модели памяти
    (:at "postcondition" "formula"))

(typedef "annotating statements" (:union "assume" 
                                         "assert" 
                                         "inv" 
                                         "inv-loop"))

(otype "assume" 
    (:at "1" "formula"))

(otype "assert" 
    (:at "1" "formula"))

(otype "inv" 
    (:at "1" "formula"))

(otype "inv-loop" 
    (:at "1" "formula"))
