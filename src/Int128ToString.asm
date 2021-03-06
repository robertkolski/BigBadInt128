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
; wchar* Int128ToString(_m128* input, wchar* lpwszBuffer )
;----------
; input remains unchanged
; lpwszBuffer the unicode string buffer, it should be 82 or more bytes long
; ---------
; returns begining of string
; ---------
; the string is written backwards in the buffer and might not begin in the place assumed
Int128ToString PROC FRAME  
   push rbp  
.pushreg rbp 
   push rdx  
.pushreg rdx 
   sub rsp, 020h  
.allocstack 020h  
   mov rbp, rsp  
.setframe rbp, 0  
.endprolog  
   mov rax, QWORD PTR [rcx]
   mov QWORD PTR [rbp], rax
   mov r11, QWORD PTR [rcx+8]
   mov QWORD PTR [rbp+8], r11

   test r11, r11
   jns positive

   xor r10, r10                  ; temporarily r10 can be zero
   not rax                       ; 2's complement
   not r11
   inc rax
   adc r11, r10
   mov QWORD PTR [rbp], rax
   mov QWORD PTR [rbp+8], r11
   mov al, 1
   mov BYTE PTR [rbp+16], al
   jmp start

positive:
   mov al, 0
   mov BYTE PTR [rbp+16], al

start:
   mov r10, rdx                  ; r10 becomes a pointer here
   add r10, 80
   mov r11, 10
   mov dx, 0
   mov WORD PTR [r10], dx

keep_looping:
   xor rdx, rdx ; rdx = 0
   mov rax, QWORD PTR [rbp+8]
   div r11

   mov QWORD PTR [rbp+8], rax
   
   mov rax, QWORD PTR [rbp]
   div r11

   add dx, '0'
   sub r10, 2
   mov WORD PTR [r10], dx
   mov QWORD PTR [rbp], rax

   xor rax, rax
   cmp [rbp+8], rax
   jne keep_looping
   cmp [rbp], rax
   jne keep_looping

   mov al, BYTE PTR [rbp+16] ; check for negative
   cmp al, 1
   jne done                  ; not negative, do nothing

   mov dx, '-'               ; negative, so add the '-' minus sign.
   sub r10, 2
   mov WORD PTR [r10], dx

done:
   mov rax, r10

   ; epilog  
   add rsp, 020h  
   pop rdx
   pop rbp  
   ret  
Int128ToString ENDP  
_text ENDS  
END