#| 
    Context-carrying Verification Conditions Language (CVCL)
|#

; lemmas and thories
; save proofs (sertificates, cache)

;;; ================================
;;; Declarations
;;; ================================
(cot "logical function declaration"
     :at "name"   "logical function name"
     :at "args"   (listt "variable name")
     :at "result" "term")

(cot "predicate declaration"
     :at "name"   "logical predicate name"
     :at "args"   (listt "variable name")
     :at "result" "formula")


;;; ================================
;;; CVC
;;; ================================
(mot "cvc" 
     :at "predicates" (listt "predicate declaration") ; список всех деклараций предикатов в данном контексте
     :at "functions"  (listt "logical function declaration")
     :at "verification condition" "formula") ; порожденное условие корректности


;;; ================================
;;; Agents and environments
;;; ================================
; В логическом мире переопределение запрещено.
(mot "env" 
     :at "agents"     (listt "agent") ; все агенты над этим окружением
     :at "predicates" (listt "predicate declaration") ; список деклараций всех предикатов в этом окружении
     :at "functions"  (listt "logical function declaration")
     :at "acontexts"  :amap "agent" (listt "acontext")
     :at "cvcs"       (listt "cvc")) ; список порожденных условий корректности

(mot "agent" 
     :at "memory" "memory" ; модель памяти, меняющаяся в процессе исполнения программы
     :at "value"  "term" ; вычисленное на данный момент этим агентом значение
     :at "state"  "variable name"
     :at "precondition" (listt "formula"))

; (typedef "acontext" cot) ; что это должно делать?
