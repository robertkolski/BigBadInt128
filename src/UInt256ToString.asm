include BigBadInt128.inc

_text SEGMENT  

public UInt256ToString

; UInt256ToString
; ---------
; RCX - QWORD - PTR to UInt256 (input)
; RDX - QWORD - PTR to String (result)
; R8  - unused (volatile)
; R9  - unused (volatile)
; ---------
; RAX volatile
; R10 volatile
; R11 volatile
;----------
; C Header
; wchar* Int128ToString(Int256* input, wchar* lpwszBuffer )
;----------
; input remains unchanged
; lpwszBuffer the unicode string buffer, it should be 162 or more bytes long
; ---------
; returns begining of string as a calculated pointer in rax
; ---------
; the string is written backwards in the buffer and might not begin in the place assumed
UInt256ToString PROC input:PTR, result:PTR  
   LOCAL temp:Int256

   mov input, rcx
   mov result, rdx

   lea r8, temp
   mov rax, (Int256 PTR [rcx]).myQWORD0
   mov (Int256 PTR [r8]).myQWORD0, rax
   mov r9, (Int256 PTR [rcx]).myQWORD1
   mov (Int256 PTR [r8]).myQWORD1, r9
   mov r10, (Int256 PTR [rcx]).myQWORD2
   mov (Int256 PTR [r8]).myQWORD2, r10
   mov r11, (Int256 PTR [rcx]).myQWORD3
   mov (Int256 PTR [r8]).myQWORD3, r11
   
   mov r10, result                  ; r10 becomes a pointer here
   add r10, 160
   mov r11, 10
   mov dx, 0
   mov WORD PTR [r10], dx

keep_looping:
   xor rdx, rdx ; rdx = 0
   mov rax, (Int256 PTR [r8]).myQWORD3
   div r11
   mov (Int256 PTR [r8]).myQWORD3, rax
   mov rax, (Int256 PTR [r8]).myQWORD2
   div r11
   mov (Int256 PTR [r8]).myQWORD2, rax
   mov rax, (Int256 PTR [r8]).myQWORD1
   div r11
   mov (Int256 PTR [r8]).myQWORD1, rax
   mov rax, (Int256 PTR [r8]).myQWORD0
   div r11
   mov (Int256 PTR [r8]).myQWORD0, rax

   add dx, '0'
   sub r10, 2
   mov WORD PTR [r10], dx

   xor rax, rax
   cmp (Int256 PTR [r8]).myQWORD3, rax
   jne keep_looping
   mov (Int256 PTR [r8]).myQWORD2, rax
   jne keep_looping
   mov (Int256 PTR [r8]).myQWORD1, rax
   jne keep_looping
   mov (Int256 PTR [r8]).myQWORD0, rax
   jne keep_looping

   mov rax, r10
   ret  
UInt256ToString ENDP  
_text ENDS  
END