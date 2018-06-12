_text SEGMENT  

public UInt128Parse

; UInt128Parse
; ---------
; RCX - QWORD - PTR to String (input)
; RDX - QWORD - PTR to Int128 (result)
; R8  - unused
; R9  - unused
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; DWORD UInt128Parse(wchar* lpwszString, _int128* result )
;----------
; input lpwszString remains unchanged
; result the pointer's contents are updated
; ---------
; returns 0 sucess
; returns 1 overflow
; returns 2 invalid format
; ---------
; 
UInt128Parse PROC FRAME  
   push rbp  
.pushreg rbp 
   push rdx  
.pushreg rdx
   push rbx
.pushreg rbx
   push r12
.pushreg r12 
   sub rsp, 030h  
.allocstack 030h  
   mov rbp, rsp  
.setframe rbp, 0  
.endprolog  
   mov r12, rdx

   xor r11, r11 ; keep r11 zero
   mov QWORD PTR [rbp+8], r11
   mov QWORD PTR [rbp+16], r11
   mov QWORD PTR [rbp+24], r11
   
   xor r10, r10 ; move to the begining of the string
   jmp start_loop

keep_looping:
   mov rbx, 10
   mov rax, [rbp+8]
   mul rbx
   mov QWORD PTR [rbp+32], rdx
   mov QWORD PTR [rbp+8], rax
   mov rax, QWORD PTR [rbp+16]
   mul rbx

   add rax, QWORD PTR [rbp+32]
   adc rdx, r11                ; add with carry and zero
   mov QWORD PTR [rbp+16], rax
   mov QWORD PTR [rbp+24], rdx
   cmp rdx, r11
   jne overflow

start_loop:
   mov dx, WORD PTR [rcx+r10] ; r10 is the string offset
   cmp dx, '0'
   jb  invalid_character

   cmp dx, '9'
   ja  invalid_character

   sub dx, '0'
   xor rax, rax
   mov ax, dx

   add QWORD PTR [rbp+8], rax
   adc QWORD PTR [rbp+16], r11 ; add with carry and zero
   adc QWORD PTR [rbp+24], r11 ; add with carry and zero

   cmp QWORD PTR [rbp+24], r11 ; compare to zero
   jne overflow
   
   add r10, 2
   mov dx, WORD PTR [rcx+10]
   cmp dx, 0
   je  done   
   jmp keep_looping


done:
   mov rax, QWORD PTR [rbp+8]
   mov rdx, QWORD PTR [rbp+16]
   mov QWORD PTR [r12], rax
   mov QWORD PTR [r12+8], rdx

   xor eax, eax
   jmp method_exit

overflow:
   mov eax, 1
   jmp method_exit

invalid_character:
   mov eax, 2

method_exit:

   ; epilog  
   add rsp, 030h
   pop r12
   pop rbx
   pop rdx
   pop rbp  
   ret  
UInt128Parse ENDP  
_text ENDS  
END