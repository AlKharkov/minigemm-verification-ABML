;;;; Logical language L

;;; Касательно термов: это зависит от того, в какой логике будем работать. Если в первого порядка, то отдельная сущность терм. Если высшего - "formula" менять на "term".
;;; Но при этом некоторые доказатели работают в логике первого порядка (и не всегда в обычной), а некоторые в логике высшего порядка (интерактивные).
;;; То есть придётся писать в одном, и если что поднимать или опускать.
;;; Подъём до логики высшего порядка как процедура звучит проще. Но при этом если мы перейдём на верхний уровень, то лучше писать в логике высшего порядка.
;;; Есть третий вариант. Как в ACL2. Если терм nil, то false, если не nil, то true.


;;; Names
(typedef "logical function name"  "name")

(typedef "logical predicate name" "name")


;;; Terms
(typedef "term"
         (uniont "constant"
                 "variable name"
                 "fcall"))

(cot "fcall"
     :at "name" "logical function name"
     :at "args" (listt "term"))


;;; Formulas
(typedef "formula" (uniont "logical constant" ; Возможно, понадобятся импликации (if, iff).
                           "and"
                           "or"
                           "not"
                           "log1==2"
                           "=>"
                           "variable name"
                           "exists"
                           "forall"
                           "pcall"))

(typedef "logical constant"
         (enumt "true"
                "false"))

(cot "and" :at 1 (listt "formula"))

(cot "or" :at 1 (listt "formula"))

(cot "not" :at 1 "formula")

(cot "log1==2" 
     :at 1 "formula"
     :at 2 "formula")

(cot "=>"
     :at 1 "formula"
     :at 2 "formula")

(cot "exists"
     :at 1 "variable name"
     :at 2 "formula")

(cot "forall"
     :at 1 "variable name"
     :at 2 "formula")

(cot "pcall"
     :at "name" "logical predicate name"
     :at "args" (listt "term"))
