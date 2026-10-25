#| 
     Logical language L

     Касательно термов: это зависит от того, в какой логике будем работать. Если в первого порядка, то отдельная сущность терм. Если высшего - "formula" менять на "term".
     Но при этом некоторые доказатели работают в логике первого порядка (и не всегда в обычной), а некоторые в логике высшего порядка (интерактивные).
     То есть придётся писать в одном, и если что поднимать или опускать.
     Подъём до логики высшего порядка как процедура звучит проще. Но при этом если мы перейдём на верхний уровень, то лучше писать в логике высшего порядка.
     Есть третий вариант. Как в ACL2. Если терм nil, то false, если не nil, то true.
|#


;;; ================================
;;; Names
;;; ================================
(typedef "logical function name"  "name")

(typedef "logical predicate name" "name")


;;; ================================
;;; Terms
;;; ================================
(typedef "term" (:union "constant"
                        "variable name" 
                        "fcall"))

(otype "fcall"
    (:at "name" "logical function name")
    (:at "args" (:list "term")))


;;; ================================
;;; Formulas
;;; ================================
(typedef "formula" (:union "logical constant" ; Возможно, понадобятся импликации (if, iff).
                           "and"
                           "or"
                           "not"
                           "log1==2"
                           "=>"
                           "variable name"
                           "exists"
                           "forall"
                           "pcall"))

(typedef "logical constant" (:enum "true"
                                   "false"))

(otype "and" 
    (:at "1" (:list "formula")))

(otype "or" 
    (:at "1" (:list "formula")))

(otype "not" 
    (:at "1" "formula"))

(otype "log1==2" 
    (:at "1" "formula")
    (:at "2" "formula"))

(otype "=>"
    (:at "1" "formula")
    (:at "2" "formula"))

(otype "exists"
    (:at "1" "variable name")
    (:at "2" "formula"))

(otype "forall"
    (:at "1" "variable name")
    (:at "2" "formula"))

(otype "pcall"
    (:at "name" "logical predicate name")
    (:at "args" (:list "term")))
