include BigBadInt128.inc

_text SEGMENT  

public Int128Add


; Int128Add
; -------------------------------------
; Signed add.
; RCX - PTR to OWORD (return value buffer)
; RDX - PTR to OWORD (input1)
; R8  - PTR to OWORD (input2)
; R9  - unused
; -------------------------------------
; RAX - returns pointer to buffer
; R10 volatile
; R11 volatile
;--------------------------------------
; C Header - pseudocode prototype
; Int128 Int128Add(Int128* input1, Int128* input2)
;--------------------------------------
; C# types (without full implementation here):
; public struct Int128
; {
;    private Int64 loQWORD;
;    private Int64 hiQWORD;
;    [DllImport("BigBadInt128.dll")]
;    private static extern Int128 Int128Add(ref Int128 addend1, ref Int128 addend2);
;    // public methods not shown
; }
;--------------------------------------
; input1 and input2 remain unchanged
; the contents of the OWORD result is modified
;--------------------------------------
; Don't need FRAME and PROLOG because
; this is a leaf function
; it does not need any stack space
; -------------------------------------
Int128Add PROC
   mov r10, (Int128 PTR [rdx]).loQWORD
   mov r11, (Int128 PTR [rdx]).hiQWORD
   add r10, (Int128 PTR [r8]).loQWORD
   adc r11, (Int128 PTR [r8]).hiQWORD
   mov (Int128 PTR [rcx]).loQWORD, r10
   mov (Int128 PTR [rcx]).hiQWORD, r11
   mov rax, rcx
   ret  
Int128Add ENDP  

_text ENDS  
END