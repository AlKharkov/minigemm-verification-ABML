; __mm256 _mm256_setzero_ps(void);
(mo "func decl" 
    :av "return type" "_mm256 type" 
    :av "parameters" (list)
    :av "body" nil
    :av "specification" (mo "specification" 
        :av "pre condition" (list)
        :av "assigns" (list)
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == 0.0;
        :av "post condition" (mo "forall12" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]"  ; ?
                    :av 2 0.0))))
)

; __mm256 _mm256_set1_ps(float v);
(mo "func decl" 
    :av "return type" "_mm256 type" 
    :av "parameters" (list (mo "parameter" :av "type" "float type" :av "name" "v"))
    :av "body" nil
    :av "specification" (mo "specification" 
        :av "pre condition" (listt)
        :av "assigns" (list)
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == v;
        :av "post condition" (mo "forall12" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]" ; ?
                    :av 2 "v"))))
)

; void _mm256_storeu_ps(float* mem_addr, __mm256 a);
(mo "func decl" 
    :av "return type" "void" 
    :av "parameters" (list 
        (mo "parameter" :av "type" "float* type" :av "name" "mem_addr") 
        (mo "parameter" :av "type" "__mm256 type" :av "name" "a"))
    :av "body" nil
    :av "specification" (mo "specification" 
        ; requires \valid(mem_addr + (0 .. 7));
        :av "pre condition" (listt (mo "valid" :av 1 (mo "range" :av 1 "mem_addr" :av 2 0 :av 3 7)))
        :av "assigns" (list (mo "range" :av 1 "mem_addr" :av 2 0 :av 3 7))
        ; ensures ∀integer i; 0≤i≤7 ⇒ mem_addr[i] == a.e[i];
        :av "post condition" (mo "forall12" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 (mo "pointer access" :av 1 "mem_addr" :av 2 "i")
                    :av 2 "v"))))
)
