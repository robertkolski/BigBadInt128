include BigBadInt128.inc

_text SEGMENT  

public UInt128Sub

; UInt128Sub
; ---------
; RCX - PTR to UInt128 (result)
; RDX - PTR to UInt128 (input1)
; R8  - PTR to UInt128 (input2)
; R9  - unused
; ---------
; RAX - returns RCX
; R10 volatile
; R11 volatile
;----------
; C Header
; UInt128 UInt128Sub(UInt128* const input1, UInt128* const input2)
;----------
; source remains unchanged
; Memory pointed to by RCX is modified
UInt128Sub PROC
   mov r10, (UInt128 PTR [rdx]).loQWORD
   mov r11, (UInt128 PTR [rdx]).hiQWORD
   sub r10, (UInt128 PTR [r8]).loQWORD
   sbb r11, (UInt128 PTR [r8]).hiQWORD
   mov (UInt128 PTR [rcx]).loQWORD, r10
   mov (UInt128 PTR [rcx]).hiQWORD, r11
   mov rax, rcx
   ret
UInt128Sub ENDP  
_text ENDS  
END