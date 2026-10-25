#| 
    Axiomatic semantics

    loc-val = :amap "cell" "constant" = отношение ячеек памяти в их значения
    var-loc = :amap "variable name" "cell" = отношение имен переменных в ячейки памяти, на которые они ссылкаются
|#


;;; ================================
;;; Expressions
;;; ================================
;; Constant
(action "axsem" "constant" nil 
    (:seq (:instance i)) 
    i)

;; Variable access
(action "axsem" "variable access" nil
    (:seq (:instance i) (:agent a) (:let st a "state"))
    (ob "fcall" 
        :av "name" "loc-val"
        :av "args" (list st 
                         (ob "fcall" :av "name" "var-loc" 
                                     :av "args" (list st (aget i "variable"))))))
