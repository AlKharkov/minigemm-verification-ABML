# пример построения аксиоматической семантики на ABML

функции ABML для задания аксиоматической семантики 



https://telemost.yandex.ru/j/69429847130158 



Пусть F - фрагмент языка Си, включающий все конструкции следующего C-кода:

```
{
	int x = 0;
	int y;
	int *p = &x;
	if (*p == 0) y = 2;
}
```

Онтологическая модель этого C-кода

```
(mo "{1}" :av 1 (list
(mo "variable declaration" :av "type" "int" :av "name" "x" :av "initializer" 0)
(mo "variable declaration" :av "type" "int" :av "name" "y")
(mo "variable declaration" :av "type" (mo "pointer type1" :av 1 "int")
	:av "name" "p" :av "initializer" (mo "&1" :av 1 "x"))
(mo "if12" :av 1 (mo "1==2" :av 1 (mo "*1" :av 1 "p") :av 2 0)
	:av 2 (mo "1;" :av 1 (mo "1=2" :av 1 "y" :av 2 2)))))
```

Онтология имен:

```
(typedef "name" (uniont symbol string))

(typedef "variable" "name")
	
(typedef "constant" int)
	
(typedef "type" (uniont "int type" "pointer type"))
	
(typedef "int type" (enumt "int"))
	
(mot "pointer type1" :at 1 "type")
```

Онтология выражений:

```
(mot "varAcc1" :at 1 "variable")

(mot "&1" :at 1 "variable")
	
(mot "*1" :at 1 "variable")
	
(mot "1=2" :at 1 "variable" :at 2 "expression")
	
(mot "1==2" :at 1 "expression" :at 2 "expression")
	
(mot "expression" :union ("varAcc1" "constant" "&1" "*1" "1=2" "1==2"))
```

Онтология операторов:

```
(mot "1;" :at "expression" "expression")
	
(mot "{1}" :at 1 (listt "statement"))
	
(mot "if12" :at 1 "expression" :at 2 "statement")

(mot "while12" :at 1 "expression" :at 2 "statement" :at "inv" "formula")
	
(mot "variable declaration" :at "type" "type" :at "name" "name"
	:at "initializer" "expression")
	
(typedef "statement" (uniont "1;" "{1}" "if12" "variable declaration"))
```

Атрибуты, которые задают аннотации к программе или отдельным ее конструкциям, называются *аннотирующими атрибутами*. 

Например, "inv" - аннотирующий атрибут, связываемый с онтологическими моделями циклов и задающий инвариант цикла.

Дополнительные конструкции, которые добавляются в язык и задают аннотации в точках, в которых они рамещаются, называются *аннотирующими инструкциями*.

Онтология формул:

```
(cot "and1" :at 1 (listt formula))
(cot "or1" :at 1 (listt formula))
(cot "not1" :at 1 formula)
(cot "exists12" :at 1 "variable" :at 2 formula)
(cot "forall12" :at 1 "variable" :at 2 formula)
(cot "pcall12" :at 1 "name" :at 2 (listt "term"))
(typedef "formula" (uniont "and1;" "or1" "not1" "exists1" "forall12" "pcall12"))
```

Список предикатов, образующих элементарные формулы:

- (<= A B) сравнивает два числа A и B;

Онтология термов:

```
(cot "fcall12" :at 1 name :at 2 (listt term))
(typedef "term" (uniont "fcall12" "constant" "varAcc1"))
 
```

Список функций, образующих термы:

- (varLoc A B) возвращает ячейку памяти, связанную с переменной A в области памяти B;
- (locVal A) возвращает значение, которое хранится в ячейке A;



Список сущностей состояния программы:

- var-addr - отображение из имен переменных в ячейки памяти
- addr-val - отображение из ячеек памяти в значения
- (upd f p v)
- (acc f p)
- {x == 2} x = x + 1; {x == 3}
- {acc(addr-val, acc(var-addr, x)) == 2} x = 1; {acc(addr-val, acc(var-addr, x)) == 1}
- {acc(addr-val_1, acc(var-addr, x)) == 2 && addr-val == upd(addr-val_1, acc(var-addr, x), 1)} {acc(addr-val, acc(var-addr, x)) == 1}



(m, len) - область памяти от 0 до len-1

(m, n), где 0 ≤ n < len - код ячейки памяти

int x; → m = 1, len = 1

int y; → m = 2, len = 1

int z[3]; → m = 3, len = 3

p = &x;

*p



уровни памяти

память для простых переменных

память для массивов

память для регистров



простые переменные x1, …, xn









```
acc(addr-val, acc(var-addr, x))
```

Пример онтологической модели формулы:

```
(co "pcall" :av 1 "<=" :av 2 (list (co "varAcc1" :at 1 "x") 2))
; x <= 2 
```

Окружение:

```
(mot "env" :at "vcs" (listt formula))
```

Агенты:

```
(mot "agent"
	:at "precondition" (listt formula) ; конъюнкция формул
	:at "value" "term")
```



{x == 3} x = x + 1; x = x + 2; {x == 6}

{x_1 == 3 & x = x_1 + 1} x = x + 2; {x == 6}

{x_1 == 3 & x_2 == x_1 + 1 & x == x_2 + 2} {x == 6}

x_1 == 3 & x_2 == x_1 + 1 & x == x_2 + 2 ⇒ x == 6 

x_2 == 3 + 1 & x == x_2 + 2 ⇒ x == 6

x_2 == 4 & x == x_2 + 2 ⇒ x == 6

x == 4 + 2 ⇒ x == 6

x == 6 ⇒ x == 6

true



var-version : Variables → Nat 

var-version(x) = m ⇒ переменные вида x_m, x_m+1, … мы не использовали

{x == 3} x = x + 1; x = x + 2; {x == 6}

var-version(x) = 5

{x == 3 & x5 == x + 1} x = x + 2; {x == 6}

var-version(x) := 5 + 1 = 6

{x == 3 & x5 == x + 1 && x6 = x5 + 2}  {x == 6}

x == 3 & x5 == x + 1 && x6 = x5 + 2 ⇒ x6 == 6

x := x1, x2, x3, … правило для переменной уточнить

x + 2

x → x5

2



Аксиоматическая семантика доступа к значению переменной



```
(aspect "axsem" :type "varAcc1" :context ac :instance i
	:do (co "fcall12" 
		:av 1 "locval" 
		:av 2 (list (co "fcall12" :av 1 "varLoc" :av 2 (list (aget i 1)))))))
```

Аксиоматическая семантика присваивания значения простой переменной:

```
(aspect "axsem" :type "1=2" :stage nil ":context ac :instance i :agent ag
	...)
```

Аксиоматическая семантика условного оператора:

```
(aspect "axsem" :context ac :type "if12" i :instance i :agent ag
	...)
```
