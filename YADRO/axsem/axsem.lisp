#| 
    Axiomatic semantics

    loc-val = :amap "cell" "constant" = отношение ячеек памяти в их значения
    var-loc = :amap "variable name" "cell" = отношение имен переменных в ячейки памяти, на которые они ссылкаются
|#


;;; ================================
;;; Expressions
;;; ================================
;; Constant
(aspect "axsem" :type "constant" :instance i :do i)

;; Variable access
(aspect "axsem" :type "variable access" :instance i 
    :agent a :ap a "state" st :do 
    (mo "fcall" 
        :av "name" "loc-val"
        :av "args" (list st 
                         (mo "fcall" :av "name" "var-loc" 
                                     :av "args" (list st (aget i "variable")))))
)

