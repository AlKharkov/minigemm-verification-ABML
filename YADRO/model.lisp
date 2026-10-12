;;;; ABML model of the small C fragment employed by gemm_v0, gemm_v1, and gemm_v2.
;;;; Used to be as close to ISO/IEC 9899:2017 (a draft of C17) as possible.
;;;; Currently a little less pedantic.

;;; Function definition

; Квалификаторы типа const могут не понадобиться.

(mot "function definition"
     :at "type" "type specifier"
     :at "name" "function name"
     :at "args" (listt "formal argument")
     :at "body" "compound statement") ; Вместо compound statement здесь и дальше сделать listt "statement"

(mot "formal argument"
     :at "q" "type qualifier"
     :at "t" "type specifier"
     :at "p" "pointer"
     :at "v" "variable name") ; Пока не думаем о входной переменной вида x[n] (массив), но потом если что расширим.

;;; Expressions

(typedef "expression"
         (uniont "variable access"
                 "constant"
                 "1[2]"
                 "++1"
                 "1 * 2"
                 "1 + 2"
                 "1 < 2"
                 "1 = 2"
                 "1 += 2"))

(mot "variable access"
     :at "variable" "variable name")

(mot "1[2]"
     :at 1 "expression"
     :at 2 "expression")

(mot "++1"
     :at 1 "expression")

(mot "1 * 2"
     :at 1 "expression"
     :at 2 "expression")

(mot "1 + 2"
     :at 1 "expression"
     :at 2 "expression")

(mot "1 < 2"
     :at 1 "expression"
     :at 2 "expression")

(mot "1 = 2"
     :at 1 "expression"
     :at 2 "expression")

(mot "1 += 2"
     :at 1 "expression"
     :at 2 "expression")

;;; Declarations

(mot "variable declaration"
     :at "q" "type qualifier"
     :at "t" "type specifier"
     :at "p" "pointer"
     :at "v" "variable name"
     :at "e" "expression")

(typedef "type qualifier"
         (enumt "const"))

(typedef "type specifier"
         (enumt "void"
                "int"
                "float"
                "__m256"))

(typedef "pointer"
         (enumt "*"))

;;; Statements

(typedef "statement"
         (uniont "for (1; 2; 3) 4"
                 "compound statement"
                 "expression"))

(typedef "compound statement"
         (listt "block item"))

(typedef "block item"
         (uniont "variable declaration"
                 "statement"))

(typedef "iteration statement"
         (uniont "for (1; 2; 3) 4"))

(mot "for (1; 2; 3) 4"
     :at 1 "variable declaration"
     :at 2 "1 < 2"
     :at 3 "++1"
     :at 4 "statement")

;;; Annotating constructions
