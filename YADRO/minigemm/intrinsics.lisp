;;;; A model of the various Intel(R) AVX intrinsics used by gemm_v2 and later.


; __m256 _mm256_setzero_ps(void);
(mo "function definion" 
    :av "type" (co "type" :av "specifier" "__m256")
    :av "name" "_mm256_setzero_ps"
    :av "specification" (mo "specification"
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == 0.0;
        :av "postcondition" 
            (mo "forall" 
                :av 1 "i" 
                :av 2 (mo "=>" 
                    :av 1 (mo "and" 
                        :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                        :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                    :av 2 (mo "1==2" 
                        :av 1 "\\result.e[i]"  ; \result.e[i]"?
                        :av 2 0.0)))))


; __m256 _mm256_set1_ps(float v);
(mo "function definion" 
    :av "type" (co "type" :av "specifier" "__m256")
    :av "name" "_mm256_set1_ps"
    :av "args" (list 
        (mo "parameter" :av "type" (co "type" :av "specifier" "float") :av "name" "v"))
    :av "specification" (mo "specification" 
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == v;
        :av "postcondition" 
            (mo "forall" 
                :av 1 "i" 
                :av 2 (mo "=>" 
                    :av 1 (mo "and" 
                        :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                        :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                    :av 2 (mo "1==2" 
                        :av 1 "\\result.e[i]"  ; \result?
                        :av 2 "v")))))


; __m256 _mm256_loadu_ps(const float* a);
(mo "function definion" 
    :av "type" (co "type" :av "specifier" "__mm256")
    :av "name" "_mm256_loadu_ps"
    :av "args" (list 
        (mo "parameter" :av "type" (co "type" :av "qualifier" "const" :av "specifier" "float" :av "pointer" "*") :av "name" "a"))
    :av "specification" (mo "specification" 
        :av "pre condition" (list (mo "valid read" :at 1 (mo "range" :av 1 "a" :av 2 0 :av 3 7)))  ; valid_read?
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == a[i];
        :av "post condition" 
            (mo "forall" 
                :av 1 "i" 
                :av 2 (mo "=>" 
                    :av 1 (mo "and" 
                        :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                        :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                    :av 2 (mo "1==2" 
                        :av 1 "\\result.e[i]" ; ?
                        :av 2 (mo "1[2]" :av 1 "a" :av 2 "i"))))))


; void _mm256_storeu_ps(float* mem_addr, __m256 a);
(mo "function definion" 
    :av "type" (co "type" :av "specifier" "void")
    :av "name" "_mm256_storeu_ps"
    :av "args" (list 
        (mo "parameter" :av "type" (co "type" :av "specifier" "float" :av "pointer" "*") :av "name" "mem_addr") 
        (mo "parameter" :av "type" (co "type" :av "specifier" "__m256") :av "name" "a"))
    :av "specification" (mo "specification" 
        ; requires \valid(mem_addr + (0 .. 7));
        :av "pre condition" (list (mo "valid" :av 1 (mo "range" :av 1 "mem_addr" :av 2 0 :av 3 7)))
        :av "assigns" (list (mo "range" :av 1 "mem_addr" :av 2 0 :av 3 7))
        ; ensures ∀integer i; 0≤i≤7 ⇒ mem_addr[i] == a.e[i];
        :av "post condition" 
            (mo "forall" 
                :av 1 "i" 
                :av 2 (mo "=>" 
                    :av 1 (mo "and" 
                        :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                        :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                    :av 2 (mo "1==2" 
                        :av 1 (mo "1[2] " :av 1 "mem_addr" :av 2 "i")
                        :av 2 "v")))))


; __m256 _mm256_fmadd_ps(__m256 a, __m256 b, __m256 c);
(mo "function definion" 
    :av "type" (co "type" :av "specifier" "__m256")
    :av "name" "_mm256_storeu_ps"
    :av "args" (list 
        (mo "parameter" :av "type" (co "type" :av "specifier" "__mm256") :av "name" "a")
        (mo "parameter" :av "type" (co "type" :av "specifier" "__mm256") :av "name" "b")
        (mo "parameter" :av "type" (co "type" :av "specifier" "__mm256") :av "name" "c"))
    :av "specification" (mo "specification" 
        ; ensures ∀integer i; 0≤i≤7 ⇒ \result.e[i] == a.e[i] * b.e[i] + c.e[i];
        :av "post condition" (mo "forall" 
            :av 1 "i" 
            :av 2 (mo "=>" 
                :av 1 (mo "and" 
                    :av 1 (mo "1<=2" :av 1  0  :av 2 "i") 
                    :av 2 (mo "1<=2" :av 1 "i" :av 2  7)) 
                :av 2 (mo "1==2" 
                    :av 1 "\\result.e[i]"  ; \result?
                    :av 2 (mo "1+2" :av 1 (mo "1*2" :av 1 "a.e[i]" :av 2 "b.e[i]")
                                    :av 2 "c.e[i]"))))))  ; a.e[i]?
