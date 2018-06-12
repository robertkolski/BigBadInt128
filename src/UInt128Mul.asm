_text SEGMENT  

public UInt128Mul

; UInt128Mul
; ---------
; RCX - QWORD - PTR to Int128 (input1)
; RDX - QWORD - PTR to Int128 (input2)
; R8  - QWORD - PTR to Int256 (result)
; R9  - unused
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; void UInt128Mul(_int128* const input1, _int128* const input2, _int256* result )
;----------
; source remains unchanged
; performs *R8 = *RCX * *RDX in 128 bit mode resulting in 256 bits
UInt128Mul PROC FRAME  
   push rbp  
.pushreg rbp
   push rdx
.pushreg rdx  
   sub rsp, 050h  
.allocstack 050h  
   mov rbp, rsp  
.setframe rbp, 0  
.endprolog  
;  _int256 temp1 = 20h bytes rbp,    rbp+8,  rbp+16, rbp+24
;  _int256 temp2 = 20h bytes rbp+32, rbp+40, rbp+48, rbp+56
;  _int128 input2 shadow = 16 bytes (10h) rbp+64, rbp+72
   
   ; temp1 = temp2 = 0
   xor rax, rax
   mov QWORD PTR [rbp], rax
   mov QWORD PTR [rbp+8], rax
   mov QWORD PTR [rbp+16], rax
   mov QWORD PTR [rbp+24], rax
   mov QWORD PTR [rbp+32], rax
   mov QWORD PTR [rbp+40], rax
   mov QWORD PTR [rbp+48], rax
   mov QWORD PTR [rbp+56], rax

   ; input2 shadow = *input2
   mov rax, QWORD PTR [rdx]
   mov QWORD PTR [rbp+64], rax
   mov rax, QWORD PTR [rdx+8]
   mov QWORD PTR [rbp+72], rax

   mov rax, QWORD PTR [rcx]
   mov rdx, QWORD PTR [rbp+64]
   mul rdx
   mov QWORD PTR [rbp], rax
   mov QWORD PTR [rbp+8], rdx

   mov rax, QWORD PTR [rcx+8]
   mov rdx, QWORD PTR [rbp+64]
   mul rdx
   mov QWORD PTR [rbp+32], rax
   mov QWORD PTR [rbp+40], rdx
   call add_temp

   mov rax, QWORD PTR [rcx]
   mov rdx, QWORD PTR [rbp+72]
   mul rdx
   mov QWORD PTR [rbp+32], rax
   mov QWORD PTR [rbp+40], rdx
   call add_temp

   mov rax, QWORD PTR [rcx+8]
   mov rdx, QWORD PTR [rbp+72]
   mul rdx
   mov QWORD PTR [rbp+40], rax
   mov QWORD PTR [rbp+48], rdx
   xor rax, rax
   mov QWORD PTR [rbp+32], rax
   call add_temp

   mov rax, QWORD PTR [rbp]
   mov rdx, QWORD PTR [rbp+8]
   mov r10, QWORD PTR [rbp+16]
   mov r11, QWORD PTR [rbp+24]
   mov QWORD PTR [r8], rax
   mov QWORD PTR [r8+8], rdx
   mov QWORD PTR [r8+16], r10
   mov QWORD PTR [r8+24], r11

   ; epilog  
   add rsp, 050h
   pop rdx  
   pop rbp  
   ret  

add_temp:
   mov rax, QWORD PTR [rbp]
   add rax, QWORD PTR [rbp+32]
   mov QWORD PTR [rbp], rax

   mov rax, QWORD PTR [rbp+8]
   adc rax, QWORD PTR [rbp+40]
   mov QWORD PTR [rbp+8], rax

   mov rax, QWORD PTR [rbp+16]
   adc rax, QWORD PTR [rbp+48]
   mov QWORD PTR [rbp+16], rax

   mov rax, QWORD PTR [rbp+24]
   adc rax, QWORD PTR [rbp+56]
   mov QWORD PTR [rbp+24], rax
   
   ret
UInt128Mul ENDP  
_text ENDS  
END