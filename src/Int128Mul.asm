include BigBadInt128.inc

_text SEGMENT

public Int128Mul
extern UInt128Mul:proc

; Int128Mul
; ---------
; RCX - QWORD - PTR to Int256 (result)
; RDX - QWORD - PTR to Int128 (input1)
; R8  - QWORD - PTR to Int128 (input2)
; R9  - unused
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; Int256 Int128Mul(Int128* const input1, Int128* const input2)
;----------
; source remains unchanged
; memory pointed to by RCX will be changed.
; RAX will return with the input RCX
; all original inputs are destroyed
Int128Mul PROC result:PTR, input1:PTR, input2:PTR
   LOCAL sign:BYTE
   LOCAL absoluteinput1:UInt128
   LOCAL absoluteinput2:UInt128
   LOCAL absoluteresult:UInt256

   mov result, RCX
   mov input1, RDX
   mov input2, R8

   mov al, 0
   mov r10, (Int128 PTR [RDX]).loQWORD
   mov r11, (Int128 PTR [RDX]).hiQWORD
   test r11, r11
   jns positive_input1

   not r10
   not r11
   inc r10
   adc r11, 0
   mov al, 1

positive_input1:
   lea rdx, absoluteinput1
   mov (UInt128 PTR [RDX]).loQWORD, r10
   mov (UInt128 PTR [RDX]).hiQWORD, r11

   mov r10, (Int128 PTR [R8]).loQWORD
   mov r11, (Int128 PTR [R8]).hiQWORD
   test r11, r11
   jns positive_input2

   not r10
   not r11
   inc r10
   adc r11, 0
   xor al, 1

positive_input2:
   lea r8, absoluteinput2
   mov (UInt128 PTR [R8]).loQWORD, r10
   mov (UInt128 PTR [R8]).hiQWORD, r11

   mov sign, al

   lea rcx, absoluteresult
   sub rsp, 20h
   call UInt128Mul
   add rsp, 20h

   mov r10, (UInt256 PTR [RAX]).myQWORD0
   mov r11, (UInt256 PTR [RAX]).myQWORD1
   mov rcx, (UInt256 PTR [RAX]).myQWORD2
   mov rdx, (UInt256 PTR [RAX]).myQWORD3   
   cmp sign, 0
   je  positive_result

   not r10
   not r11
   not rcx
   not rdx
   inc r10
   adc r11, 0
   adc rcx, 0
   adc rdx, 0

positive_result:
   mov rax, result
   mov (Int256 PTR [rax]).myQWORD0, r10
   mov (Int256 PTR [rax]).myQWORD1, r11
   mov (Int256 PTR [rax]).myQWORD2, rcx
   mov (Int256 PTR [rax]).myQWORD3, rdx
   ret
Int128Mul ENDP  
_text ENDS  
END