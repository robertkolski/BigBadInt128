_text SEGMENT  

public UInt128Mul

UInt128 STRUCT 
    loQWORD QWORD ?
    hiQWORD QWORD ?
UInt128 ENDS

UInt256 STRUCT 
    myQWORD0 QWORD ?
    myQWORD1 QWORD ?
    myQWORD2 QWORD ?
    myQWORD3 QWORD ?
UInt256 ENDS

; UInt128Mul
; ---------
; RCX - WORD - PTR to UInt256 (result)
; RDX - WORD - PTR to UInt128 (input1)
; R8  - WORD - PTR to UInt128 (input2)
; R9  - volatile, not used for parameter passing
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header - variant 1
; UInt128 UInt128Mul(UInt128* const input1, UInt128* const input2);
; C Header - variant 2
; void UInt128Mul(UInt256* result, UInt128* const input1, UInt128* const input2);
;----------
; source remains unchanged
; performs *R8 = *RCX * *RDX in 128 bit mode resulting in 256 bits
UInt128Mul PROC result:PTR UInt128, input1:PTR UInt128, input2:PTR UInt128
   ; no need to save shadow space yet
   cmp (UInt128 PTR [rdx]).hiQWORD, 0
   jne long_math
   cmp (UInt128 PTR [r8]).hiQWORD, 0
   jne long_math

   mov rax, (UInt128 PTR [rdx]).loQWORD
   mov r10, (UInt128 PTR [r8]).loQWORD
   mul r10
   mov (UInt256 PTR [rcx]).myQWORD0, rax
   mov (UInt256 PTR [rcx]).myQWORD1, rdx
   mov (UInt256 PTR [rcx]).myQWORD2, 0
   mov (UInt256 PTR [rcx]).myQWORD3, 0
   mov rax, rcx
   ret

long_math:
   ; save shadow space
   mov result, rcx ; this saved shadow parameter is actually used
   mov input1, rdx ; saved but not used
   mov input2, r8  ; saved but not used

   push r12
   push r13
   push r14
   push r15
   xor r14, r14 ; make r14 and r15 zero because they will start as carries
   xor r15, r15
   
   mov rax, (UInt128 PTR [rdx]).loQWORD ; rdx is a pointer to input1
   mov r10, (UInt128 PTR [r8]).loQWORD  ; r8 is a pointer to input2
   mov rcx, (UInt128 PTR [rdx]).hiQWORD
   mov r11, (UInt128 PTR [r8]).hiQWORD
   mov r8, rax
   mul r10         ; input1.loQWORD * input2.loQWORD ==> rdx : rax
   mov r12, rax    ; this is the result.myQWORD0 (final result)
   mov r13, rdx    ; this is the result.myQWORD1 (temp)
   mov rax, r8    
   mul r11         ; input1.loQWORD * input2.hiQWORD ==> rdx : rax
   add r13, rax    ; update result.myQWORD1 (still temp) by adding
   adc r14, rdx    ; result.myQWORD2 (temp) add with carry
   mov rax, rcx
   mul r10         ; input1.hiQWORD * input2.loQWORD ==> rdx : rax
   add r13, rax    ; update result.myQWORD1 (final result) by adding
   adc r14, rdx    ; update result.myQWORD2 (temp) by adding with carry
   adc r15, 0      ; begin using result.myQWORD3 (temp) in case of carry
   mov rax, rcx
   mul r11         ; input1.hiQWORD * input2.hiQWORD ==> rdx : rax
   add r14, rax    ; update result.myQWORD2 (final result) by adding
   adc r15, rdx    ; update result.myQWORD3 (final result) by adding with carry
   mov rax, result ; load result pointer into rax to begin storing in memory
   mov (UInt256 PTR [rax]).myQWORD0, r12
   mov (UInt256 PTR [rax]).myQWORD1, r13
   mov (UInt256 PTR [rax]).myQWORD1, r14
   mov (UInt256 PTR [rax]).myQWORD1, r15
   pop r15
   pop r14
   pop r13
   pop r12
   ret
UInt128Mul ENDP  
_text ENDS  
END