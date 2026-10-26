#| 
    Axiomatic semantics

    Для Си модели памяти:
    var-loc(st, var_name) => "cell" - получить ячейку памяти по имени переменной
    loc-val(st, cell) => "constant" - получить значение по ячейке памяти
    tape-loc(st, tape_name, ind) => "cell" - получить ячейку памяти в ленте tape_name по индексу ind
    
    Для модели памяти как в Pascal:
    var-val(st, var_name) => "constant" - значение переменной
    tape-val(st, tape_name, ind) => "constant" - значение ленты name по индексу ind

    ":=" - функция присваивания, которая впоследствии преобразится в st1 = upd(st, var_name, new_value)
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
    (ob "fcall" ; loc-val(st, var-loc(st, i_variable))
        :av "name" "loc-val" ; получить значение по ячейке памяти
        :av "args" (list st 
                         (ob "fcall" :av "name" "var-loc" ; получить ячейку памяти по имени переменной
                                     :av "args" (list st (aget i "variable"))))))


(action "axsem::lvalue" "variable access" nil
    (:seq (:instance i) (:agent a) (:let st a "state"))
    (ob "fcall" ; var-loc(st, i_variable)
        :av "name" "var-loc" ; получить ячейку памяти по имени переменной
        :av "args" (list st (aget i "variable"))))


; Index expression | 1[2]
(action "axsem" "1[2]" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 2")))

(action "axsem" "1[2]" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2"))
    (:seq
        (update-push-action ac (:av "stage" "access"))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1[2]" "access" ; name1[v2]
    (:seq (:instance i) (:let name1 i "name") (:value v2) (:agent a) (:let st a "state"))
    (ob "fcall" ; loc-val(st, tape-loc(st, name1, v2))
        (:av "name" "loc-val")
        (:av "args" (list st
                    (ob "fcall" (:av "name" "tape-loc")
                                (:av "args" (list st name1 v2)))))))


(action "axsem::lvalue" "1[2]" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 2")))

(action "axsem::lvalue" "1[2]" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2"))
    (:seq
        (update-push-action ac (:av "stage" "access"))
        (clear-update-eval-action ac (:av "action" "axsem") (:av "instance" e2))))

(action "axsem::lvalue" "1[2]" "access" ; name1[v2]
    (:seq (:instance i) (:let name1 i "name") (:value v2) (:agent a) (:let st a "state"))
    (ob "fcall" ; tape-loc(st, name1, v2)
        (:av "name" "tape-loc")
        (:av "args" (list st name1 v2))))


; Increment expression | ++1
(action "axsem" "++1" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "++1" "execute 1" ; вычисляет терм - значение в переменной
    (:seq (:action ac) (:instance i) (:let name i "1"))
    (:seq
        (update-push-action ac (:av "stage" "increase"))
        (clear-update-eval-action ac 
            (:av "instance" (ob "variable access" (:av "variable" name))))))

(action "axsem" "++1" "increase" ; name := (v1 + 1)
    (:seq (:instance i) (:let name i "1") (:value v1))
    (ob "fcall" 
        (:av "name" ":=")
        (:av "args" (list name 
                          (ob "fcall" (:av "name" "+") 
                                      (:av "args" (list v1 1)))))))


; Multiplication expression | 1*2
(action "axsem" "1*2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1*2" "execute 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1*2" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "mul") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1*2" "mul" ; строит терм - значение выражения
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "*")
        (:av "args" (list v1 v2))))


; Addition expression | 1+2
(action "axsem" "1+2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1+2" "execute 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1+2" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "add") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1+2" "add" ; строит терм - значение выражения
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "+")
        (:av "args" (list v1 v2))))


; Less than expression | 1<2
(action "axsem" "1<2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1<2" "execute 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1<2" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "compare") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1<2" "compare" ; строит терм - значение выражения
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "<")
        (:av "args" (list v1 v2))))


; Assign expression | 1=2
(action "axsem" "1=2" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute 1")))

(action "axsem" "1=2" "execute 1" ; вычисляет терм - ячейка памяти первого аргумента
    (:seq (:action ac) (:instance i) (:let c1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute 2"))
        (clear-update-eval-action ac 
            (:av "action" "axsem::lvalue") ; нужен lvalue обработчик, про названия можно обсудить
            (:av "instance" c1))))

(action "axsem" "1=2" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value c1))
    (:seq
        (update-push-action ac (:av "stage" "assign") (:av "c1" c1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1=2" "assign" ; c1 := v2
    (:seq (:action ac) (:let c1 ac "c1") (:value v2))
    (ob "fcall" 
        (:av "name" ":=")
        (:av "args" (list c1 v2))))


; Assign plus expression | 1+=2
(action "axsem" "1+=2" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "execute  value 1")))

(action "axsem" "1<2" "execute value 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "execute cell 1"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1+=2" "execute 1" ; вычисляет терм - ячейка памяти первого аргумента
    (:seq (:action ac) (:instance i) (:let c1 i "1") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "execute 2") (:av "v1" v1))
        (clear-update-eval-action ac 
            (:av "action" "axsem::lvalue") ; нужен lvalue обработчик, про названия можно обсудить
            (:av "instance" c1))))

(action "axsem" "1+=2" "execute 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:let v1 ac "v1") (:instance i) (:let e2 i "2") (:value c1))
    (:seq
        (update-push-action ac (:av "stage" "assign") (:av "v1" v1) (:av "c1" c1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1+=2" "assign" ; c1 := v1 + v2
    (:seq (:action ac) (:let v1 ac "v1") (:let c1 ac "c1") (:value v2))
    (ob "fcall" 
        (:av "name" ":=")
        (:av "args" (list c1 
                          (ob "fcall" (:av "name" "+") 
                                      (:av "args" (list v1 v2)))))))
