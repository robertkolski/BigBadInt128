_text SEGMENT  

public BigBadAdd128

; BigBadAdd128
; ---------
; RCX - QWORD - PTR to Int128 (dest)
; RDX - QWORD - PTR to Int128 (source)
; R8  - unused
; R9  - unused
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; void BigBadAdd128(_m128* dest, _m128* const source )
;----------
; source remains unchanged
; performs *RCX = *RCX + *RDX in 128 bit mode
BigBadAdd128 PROC FRAME  
   push rbp  
.pushreg rbp  
   sub rsp, 010h  
.allocstack 010h  
   mov rbp, rsp  
.setframe rbp, 0  
.endprolog  
   mov rax, QWORD PTR [rcx]
   mov r10, QWORD PTR [rcx+8]
   add rax, QWORD PTR [rdx]
   adc r10, QWORD PTR [rdx+8]
   mov QWORD PTR [rcx], rax
   mov QWORD PTR [rcx+8], r10

   ; epilog  
   add rsp, 010h  
   pop rbp  
   ret  
BigBadAdd128 ENDP  
_text ENDS  
END