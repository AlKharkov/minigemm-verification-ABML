#| 
    Context-carrying Verification Conditions Language (CVCL)
|#

; lemmas and thories
; save proofs (sertificates, cache)

;;; ================================
;;; Declarations
;;; ================================
(otype "logical function declaration"
    (:at "name"   "logical function name")
    (:at "args"   (:list "variable name"))
    (:at "result" "term"))

(otype "predicate declaration"
    (:at "name"   "logical predicate name")
    (:at "args"   (:list "variable name"))
    (:at "result" "formula"))


;;; ================================
;;; CVC
;;; ================================
(otype "cvc" 
    (:at "predicates" (:list "predicate declaration")) ; список всех деклараций предикатов в данном контексте
    (:at "functions"  (:list "logical function declaration"))
    (:at "verification condition" "formula")) ; порожденное условие корректности


;;; ================================
;;; Agents and environments
;;; ================================
; В логическом мире переопределение запрещено.
(otype "env" 
    (:at "agents"     (:list "agent")) ; все агенты над этим окружением
    (:at "predicates" (:list "predicate declaration")) ; список деклараций всех предикатов в этом окружении
    (:at "functions"  (:list "logical function declaration"))
    (:at "cvcs"       (:list "cvc"))) ; список порожденных условий корректности
    (:at "agent actions" (:map "agent" (:list "action")))

(typedef "action" obtype)

(otype "agent" 
    ; (:at "memory" "memory") ; модель памяти, меняющаяся в процессе исполнения программы - нужно для операционной, не аксиоматической
    (:at "value"  "term") ; вычисленное на данный момент этим агентом значение
    (:at "state"  "variable name")
    (:at "precondition" (:list "formula")))
