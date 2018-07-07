include BigBadInt128.inc

_text SEGMENT  

public UInt128Add


; UInt128Add
; -------------------------------------
; Unsigned add.
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
; UInt128 UInt128Add(UInt128* input1, UInt128* input2)
;--------------------------------------
; C# type (without full implementation here):
; public struct UInt128
; {
;    private UInt64 loQWORD;
;    private UInt64 hiQWORD; 
;    [DllImport("BigBadInt128.dll")]
;    private static extern UInt128 UInt128Add(ref UInt128 input1, ref UInt128 input2);
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
UInt128Add PROC
   mov r10, (UInt128 PTR [rdx]).loQWORD
   mov r11, (UInt128 PTR [rdx]).hiQWORD
   add r10, (UInt128 PTR [r8]).loQWORD
   adc r11, (UInt128 PTR [r8]).hiQWORD
   mov (UInt128 PTR [rcx]).loQWORD, r10
   mov (UInt128 PTR [rcx]).hiQWORD, r11
   mov rax, rcx
   ret  
UInt128Add ENDP  

_text ENDS  
END