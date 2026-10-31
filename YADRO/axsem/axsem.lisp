#| 
    Axiomatic semantics

    Для Си модели памяти:
    loc-val(stC, cell) => "constant" - получить значение по ячейке памяти
    var-loc(stC, var_name) => "cell" - получить ячейку памяти по имени переменной
    tape-loc(stC, tape_name, ind) => "cell" - получить ячейку памяти в ленте tape_name по индексу ind
    
    Для модели памяти как в Pascal:
    var-val(stM, var_name) => "constant" - значение переменной
    tape-val(stM, tape_name, ind) => "constant" - значение ленты name по индексу ind

    Для регистров:
    var-reg(stR, var_name) => "register" = (:list "constant") - [8]float32

    :=(mem_type, var_name, new_value) - функция присваивания, которая впоследствии преобразится в st1 = upd(st, var_name, new_value)
    set-indirect(mem_type, var_name, index, new_value) - присваивает значение элементу ленты по индексу???

    Аксиомы функций get и upd:
    x != y => get(upd(f, x, v), y) == get(f, y)
    x == y => get(upd(f, x, v), y) == v
|#


;;; ================================
;;; Macros
;;; ================================
; Преобразует (fcall "f_name" e1 e2 ...) в (ob "fcall" (:av "name" "f_name") (:av "args" (list e1 e2 ...)))
(defmacro fcall (name &rest args)
  `(ob "fcall"
       (:av "name" ,name)
       (:av "args" (list ,@args))))


;;; ================================
;;; Expressions
;;; ================================

;; Constant
(action "axsem" "constant" nil 
    (:seq (:instance i)) 
    i)


;; Variable access
(action "axsem" "variable access C" nil
    (:seq (:instance i) (:agent a) (:let stC a "stateC"))
    ; loc-val(stC, var-loc(stC, i_variable))
    (fcall "loc-val" stC 
                     (fcall "var-loc" stC (aget i "variable"))))


(action "axsem" "variable access math" nil
    (:seq (:instance i) (:agent a) (:let stM a "stateM"))
    ; var-val(stM, var_name)
    (fcall "var-val" stM (aget i "variable")))


(action "axsem" "variable access reg" nil
    (:seq (:instance i) (:agent a) (:let stR a "stateR"))
    ; var-reg(stR, var_name)
    (fcall "var-reg" stR (aget i "variable")))


; Array indirection | 1[2] - 3 вида
(action "axsem" "1[2]" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "eval 2")))

(action "axsem" "1[2]" "eval 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2"))
    (:seq
        (update-push-action ac (:av "stage" "access"))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1[2]" "access" ; name1[v2]
    (:seq (:instance i) (:let name1 i "name") (:value v2) (:agent a) (:let st a "state"))
    (ob "fcall" ; loc-val(st, tape-loc(stC, name1, v2))
        (:av "name" "loc-val")
        (:av "args" (list st
                    (ob "fcall" (:av "name" "tape-loc")
                                (:av "args" (list st name1 v2)))))))


; Increment expression | ++1
; (action "axsem" "++1" nil
;     (:seq (:action ac))
;     (update-push-action ac (:av "stage" "eval 1")))

; (action "axsem" "++1" "eval 1" ; вычисляет терм - значение в переменной
;     (:seq (:action ac) (:instance i) (:let name i "1"))
;     (:seq
;         (update-push-action ac (:av "stage" "increase"))
;         (clear-update-eval-action ac 
;             (:av "instance" (ob "variable access" (:av "variable" name))))))

; (action "axsem" "++1" "increase" ; name := (v1 + 1)
;     (:seq (:instance i) (:let name i "1") (:value v1))
;     (ob "fcall" 
;         (:av "name" ":=")
;         (:av "args" (list name 
;                           (ob "fcall" (:av "name" "+") 
;                                       (:av "args" (list v1 1)))))))
; Rewrite to Pascal`s


; Multiplication expression | 1*2
(action "axsem" "1*2" nil 
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "eval 1")))

(action "axsem" "1*2" "eval 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "eval 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1*2" "eval 2" ; вычисляет терм - значение второго аргумента
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
    (update-push-action ac (:av "stage" "eval 1")))

(action "axsem" "1+2" "eval 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "eval 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1+2" "eval 2" ; вычисляет терм - значение второго аргумента
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
    (update-push-action ac (:av "stage" "eval 1")))

(action "axsem" "1<2" "eval 1" ; вычисляет терм - значение первого аргумента
    (:seq (:action ac) (:instance i) (:let e1 i "1"))
    (:seq
        (update-push-action ac (:av "stage" "eval 2"))
        (clear-update-eval-action ac (:av "instance" e1))))

(action "axsem" "1<2" "eval 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v1))
    (:seq
        (update-push-action ac (:av "stage" "compare") (:av "v1" v1))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1<2" "compare" ; строит терм - значение выражения
    (:seq (:action ac) (:let v1 ac "v1") (:value v2))
    (ob "fcall"
        (:av "name" "<")
        (:av "args" (list v1 v2))))


; Assign expression | varname=2
(action "axsem" "varname=2" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "eval 2")))

(action "axsem" "varname=2" "eval 2" ; вычисляет терм - значение второго аргумента
    (:seq (:action ac) (:instance i) (:let e2 i "2"))
    (:seq
        (update-push-action ac (:av "stage" "assign"))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "varname=2" "assign" ; var_name := v2
    (:seq (:instance i) (:let var_name i "1" "variable") 
        (:let mem_type i "1" "memory type") (:value v2)) ; mem_type = "C" or "math" or "register"
    (fcall ":=" mem_type var_name v2))


; Array indirection assign | 1[2]=3
(action "axsem" "1[2]=3" nil
    (:seq (:action ac))
    (update-push-action ac (:av "stage" "eval 3")))

(action "axsem" "1[2]=3" "eval 3"
    (:seq (:action ac) (:instance i) (:let e3 i "3"))
    (:seq 
        (update-push-action ac (:av "stage" "eval 2"))
        (clear-update-eval-action ac (:av "instance" e3))))

(action "axsem" "1[2]=3" "eval 2"
    (:seq (:action ac) (:instance i) (:let e2 i "2") (:value v3))
    (:seq 
        (update-push-action ac (:av "stage" "assign") (:av "v3" v3))
        (clear-update-eval-action ac (:av "instance" e2))))

(action "axsem" "1[2]=3" "assign"
    (:seq (:action ac) (:let v3 ac "v3") (:value v2) (:instance i)
        (:let var_name i "1" "variable") (:let mem_type i "1" "memory type"))
    (fcall ":=" mem_type var_name v2 v3))


; Assign plus expression | 1+=2
; (action "axsem" "1+=2" nil
;     (:seq (:action ac))
;     (update-push-action ac (:av "stage" "eval  value 1")))

; (action "axsem" "1<2" "eval value 1" ; вычисляет терм - значение первого аргумента
;     (:seq (:action ac) (:instance i) (:let e1 i "1"))
;     (:seq
;         (update-push-action ac (:av "stage" "eval cell 1"))
;         (clear-update-eval-action ac (:av "instance" e1))))

; (action "axsem" "1+=2" "eval 1" ; вычисляет терм - ячейка памяти первого аргумента
;     (:seq (:action ac) (:instance i) (:let c1 i "1") (:value v1))
;     (:seq
;         (update-push-action ac (:av "stage" "eval 2") (:av "v1" v1))
;         (clear-update-eval-action ac 
;             (:av "action" "axsem::lvalue") ; нужен lvalue обработчик, про названия можно обсудить
;             (:av "instance" c1))))

; (action "axsem" "1+=2" "eval 2" ; вычисляет терм - значение второго аргумента
;     (:seq (:action ac) (:let v1 ac "v1") (:instance i) (:let e2 i "2") (:value c1))
;     (:seq
;         (update-push-action ac (:av "stage" "assign") (:av "v1" v1) (:av "c1" c1))
;         (clear-update-eval-action ac (:av "instance" e2))))

; (action "axsem" "1+=2" "assign" ; c1 := v1 + v2
;     (:seq (:action ac) (:let v1 ac "v1") (:let c1 ac "c1") (:value v2))
;     (ob "fcall" 
;         (:av "name" ":=")
;         (:av "args" (list c1 
;                           (ob "fcall" (:av "name" "+") 
;                                       (:av "args" (list v1 v2)))))))
