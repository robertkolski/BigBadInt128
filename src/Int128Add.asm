_text SEGMENT  

public Int128Add

; Int128Add
; ---------
; RCX - QWORD - PTR to Int128 (input1)
; RDX - QWORD - PTR to Int128 (input2)
; R8  - QWORD - PTR to Int128 (result)
; R9  - unused
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; void Int128Add(_m128* const input1, _m128* const input2, _m128* result )
;----------
; source remains unchanged
; performs *R8 = *RCX + *RDX in 128 bit mode
Int128Add PROC FRAME  
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
   mov QWORD PTR [r8], rax
   mov QWORD PTR [r8+8], r10

   ; epilog  
   add rsp, 010h  
   pop rbp  
   ret  
Int128Add ENDP  
_text ENDS  
END