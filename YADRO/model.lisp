;;;; ABML model of the small C fragment employed by gemm_v0, gemm_v1, and gemm_v2.
;;;; As close to ISO/IEC 9899:2017 (a draft of C17) as possible.

;;; Expressions

(typedef "postfix expression"
         (uniont "primary expression"
                 "1[2]"))

(mot "1[2]"
     ;; Array subscripting.
     :at 1 "postfix expression"
     :at 2 "expression")

(typedef "unary expression"
         (uniont "postfix expression"
                 "++1"))

(mot "++1"
     :at 1 "unary expression")

(typedef "cast expression"
         (uniont "unary expression"))

(typedef "multiplicative expression"
         (uniont "cast expression"
                 "1 * 2"))

(mot "1 * 2"
     :at 1 "multiplicative expression"
     :at 2 "cast expression")

(typedef "additive expression"
         (uniont "multiplicative expression"
                 "1 + 2"))

(mot "1 + 2"
     :at 1 "additive expression"
     :at 2 "multiplicative expression")

(typedef "shift expression"
         (uniont "additive expression"))

(typedef "relational expression"
         (uniont "shift expression"
                 "1 < 2"))

(mot "1 < 2"
     :at 1 "relational expression"
     :at 2 "shift expression")

(typedef "equality-expression"
         (uniont "relational expression"))

(typedef "AND expression"
         (uniont "equality expression"))

(typedef "exclusive OR expression"
         (uniont "AND expression"))

(typedef "inclusive OR expression"
         (uniont "exlcusive OR expression"))

(typedef "logical AND expression"
         (uniont "inclusive OR expression"))

(typedef "logical OR expression"
         (unionit "logical AND expression"))

(typedef "conditional expression"
         (uniont "logical OR expression"))

(typedef "assignment expression"
         (uniont "conditional expression"
                 "1 = 2"
                 "1 += 2"))

(mot "1 = 2"
     :at 1 "unary expression"
     :at 2 "assignment expression")

(mot "1 += 2"
     :at 1 "unary expression"
     :at 2 "assignment expression")

(typedef "expression"
         (listt "assignment expression"))

;;; Declarations

(typedef "declaration"
         (uniont "<declaration specifiers> <init declarator list>"))

(mot "<declaration specifiers> <init declarator list>"
     :at 1 "declaration specifiers"
     :at 2 "init declarator list")

(typedef "declaration specifiers"
         (listt "declaration specifier"))

(typedef "declaration specifier"
         (uniont "type specifier"
                 "type qualifier"))

(typedef "init declarator list"
         (listt "init declarator"))

(typedef "type qualifier"
         (enumt "const"))

(typedef "type specifier"
         (enumt "void"
                "int"
                "float"
                "__m256"))

(typedef "init declarator"
         (uniont "declarator"
                 "<declarator> = <initializer>"))

(mot "declarator"
     :at 1 "pointer"
     :at 2 "direct declarator")

(typedef "direct declarator"
         (uniont "identifier"
                 "<direct declarator> ( <parameter type list> )"))

(mot "<direct declarator> ( <parameter type list> )"
     ;; Function definition.
     :at 1 "direct declarator"
     :at 2 "parameter type list")

(typedef "parameter type list"
         (uniont "parameter list"))

(typedef "parameter list"
         (listt "parameter declaration"))

(typedef "parameter declaration"
         (uniont "<declaration specifiers> <declarator>"))

(mot "<declaration specifiers> <declarator>"
     :at 1 "declaration specifiers"
     :at 2 "declarator")

(typedef "pointer"
         (uniont "* <type qualifier list>"))

(mot "* <type qualifier list>"
     :at 1 "type qualifier list")

(typedef "type qualifier list"
         (listt "type qualifier"))

(mot "<declarator> = <initializer>"
     :at 1 "declarator"
     :at 2 "initializer")

(typedef "initializer"
         (uniont "assignment expression"))

;;; Statements

(typedef "statement"
         (uniont "iteration statement"
                 "compound statement"
                 "expression statement"))

(typedef "expression statement"
         (uniont "expression"))

(typedef "compound statement"
         (uniont "block item list"))

(typedef "block item list"
         (listt "block item"))

(typedef "block item"
         (uniont "declaration"
                 "statement"))

(typedef "iteration statement"
         (uniont "for (1; 2; 3) 4"))

(mot "for (1; 2; 3) 4"
     :at 1 "declaration"
     :at 2 "expression"
     :at 3 "expression"
     :at 4 "statement")
