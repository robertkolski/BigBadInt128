_text SEGMENT  

public Int128ToString

; Int128ToString
; ---------
; RCX - QWORD - PTR to Int128 (input)
; RDX - QWORD - PTR to String (result)
; R8  - unused
; R9  - unused
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; void Int128ToString(_m128* input, wchar* lpwszBuffer )
;----------
; input remains unchanged
; lpwszBuffer the unicode string buffer, it should be 82 or more bytes long
Int128ToString PROC FRAME  
   push rbp  
.pushreg rbp 
   push rdx  
.pushreg rdx 
   sub rsp, 010h  
.allocstack 010h  
   mov rbp, rsp  
.setframe rbp, 0  
.endprolog  
   mov rax, QWORD PTR [rcx]
   mov QWORD PTR [rbp], rax
   mov rax, QWORD PTR [rcx+8]
   mov QWORD PTR [rbp+8], rax

   mov r10, rdx
   mov r11, 10

keep_looping:
   xor rdx, rdx ; rdx = 0
   mov rax, QWORD PTR [rbp+8]
   div r11

   mov QWORD PTR [rbp+8], rax
   
   mov rax, QWORD PTR [rbp]
   div r11

   add dx, '0'
   mov WORD PTR [r10], dx
   inc r10
   mov QWORD PTR [rbp], rax

   xor rax, rax
   cmp [rbp+8], rax
   jne keep_looping
   cmp [rbp], rax
   jne keep_looping

   mov dx, 0
   mov WORD PTR [rdi], dx

   ; epilog  
   add rsp, 010h  
   pop rdx
   pop rbp  
   ret  
Int128ToString ENDP  
_text ENDS  
END