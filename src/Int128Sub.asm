include BigBadInt128.inc

_text SEGMENT  

public Int128Sub

; Int128Sub
; ---------
; RCX - PTR to Int128 (result)
; RDX - PTR to Int128 (input1)
; R8  - PTR to Int128 (input2)
; R9  - unused
; ---------
; RAX - returns RCX
; R10 volatile
; R11 volatile
;----------
; C Header
; Int128 Int128Sub(Int128* const input1, Int128* const input2)
;----------
; source remains unchanged
; Memory pointed to by RCX is modified
Int128Sub PROC
   mov r10, (Int128 PTR [rdx]).loQWORD
   mov r11, (Int128 PTR [rdx]).hiQWORD
   sub r10, (Int128 PTR [r8]).loQWORD
   sbb r11, (Int128 PTR [r8]).hiQWORD
   mov (Int128 PTR [rcx]).loQWORD, r10
   mov (Int128 PTR [rcx]).hiQWORD, r11
   mov rax, rcx
   ret
Int128Sub ENDP  
_text ENDS  
END