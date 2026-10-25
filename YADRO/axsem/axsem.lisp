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

; 1[2]

; 1++

; 1*2
(action "axsem" "1*2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1*2" "execute 1"
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1*2" "execute 2"
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "mul") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1*2" "mul"
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "*")
        (:av "args" (list v1 v2))))

; 1+2
(action "axsem" "1+2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1+2" "execute 1"
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1+2" "execute 2"
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "add") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1+2" "add"
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "+")
        (:av "args" (list v1 v2))))

; 1<2
(action "axsem" "1<2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1<2" "execute 1"
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1<2" "execute 2"
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "compare") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1<2" "compare"
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "<")
        (:av "args" (list v1 v2))))

; 1=2

; 1+=2
