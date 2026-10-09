; __mm256 _mm256_setzero_ps(void);
(mo "func decl" 
    :av "return type" "__mm256 type" 
    :av "parameters" (list)
    :av "specification" (mo "specification" 
        :av "pre condition" (list)
        :av "assigns" (list)
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == 0.0;
        :av "post condition" (mo "forall" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]"  ; \result.e[i]"?
                    :av 2 0.0)))))


; __mm256 _mm256_set1_ps(float v);
(mo "func decl" 
    :av "return type" "__mm256 type" 
    :av "parameters" (list (mo "parameter" :av "type" "float type" :av "name" "v"))
    :av "specification" (mo "specification" 
        :av "pre condition" (list)
        :av "assigns" (list)
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == v;
        :av "post condition" (mo "forall" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]"  ; \result.e[i]"?
                    :av 2 "v")))))


; __mm256 _mm256_loadu_ps(const float* a);
(mo "func decl" 
    :av "return type" "__mm256 type" 
    :av "parameters" (list (mo "parameter" :av "type" "const float* type" :av "name" "a"))
    :av "specification" (mo "specification" 
        :av "pre condition" (list (mo "valid read" :at 1 (mo "range" :av 1 "a" :av 2 0 :av 3 7)))  ; valid_read?
        :av "assigns" (list)
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == a[i];
        :av "post condition" (mo "forall" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]" ; ?
                    :av 2 (mo "pointer access" :av 1 "a" :av 2 "i"))))))

; void _mm256_storeu_ps(float* mem_addr, __mm256 a);
(mo "func decl" 
    :av "return type" "void" 
    :av "parameters" (list 
        (mo "parameter" :av "type" "float* type" :av "name" "mem_addr") 
        (mo "parameter" :av "type" "__mm256 type" :av "name" "a"))
    :av "specification" (mo "specification" 
        ; requires \valid(mem_addr + (0 .. 7));
        :av "pre condition" (list (mo "valid" :av 1 (mo "range" :av 1 "mem_addr" :av 2 0 :av 3 7)))
        :av "assigns" (list (mo "range" :av 1 "mem_addr" :av 2 0 :av 3 7))
        ; ensures ∀integer i; 0≤i≤7 ⇒ mem_addr[i] == a.e[i];
        :av "post condition" (mo "forall" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 (mo "pointer access" :av 1 "mem_addr" :av 2 "i")
                    :av 2 "v")))))


; __mm256 _mm256_fmadd_ps(__mm256 a, __mm256 b, __mm256 c);
(mo "func decl" 
    :av "return type" "__mm256 type" 
    :av "parameters" (list (mo "parameter" :av "type" "__mm256 type" :av "name" "a")
                           (mo "parameter" :av "type" "__mm256 type" :av "name" "b")
                           (mo "parameter" :av "type" "__mm256 type" :av "name" "c"))
    :av "specification" (mo "specification" 
        :av "pre condition" (list)
        :av "assigns" (list)
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == a.e[i] * b.e[i] + c.e[i];
        :av "post condition" (mo "forall" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]"  ; \result.e[i]"?
                    :av 2 (mo "1+2" :av 1 (mo "1*2" :av 1 "a.e[i]" :av 2 "b.e[i]")
                                    :av 2 "c.e[i]"))))))  ; a.e[i]?
