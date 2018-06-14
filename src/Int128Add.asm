_text SEGMENT  

public Int128Add

; Int128Add
; -------------------------------------
; Signed and unsigned add.
; RCX - PTR to OWORD (input1)
; RDX - PTR to OWORD (input2)
; R8  - PTR to OWORD (result)
; R9  - unused
; -------------------------------------
; RAX volatile - but not used
; R10 volatile
; R11 volatile
;--------------------------------------
; C Header - pseudocode prototype
; void Int128Add(_int128* input1, _int128* input2, _int128* result )
; assume that I have a C compiler that supports _int128 or it is a struct
;--------------------------------------
; C# types (without full implementation here):
; public struct Int128
; {
;    private Int64 loQWORD;
;    private Int64 hiQWORD;
;    [DllImport("BigBadInt128.dll")]
;    private static extern void Int128Add(IntPtr addend1, IntPtr addend2, IntPtr result);
;    // public methods not shown
; }
; public struct UInt128
; {
;    private UInt64 loQWORD;
;    private UInt64 hiQWORD; 
;    [DllImport("BigBadInt128.dll")]
;    private static extern void Int128Add(IntPtr addend1, IntPtr addend2, IntPtr result);
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
   mov r10, QWORD PTR [rcx]
   mov r11, QWORD PTR [rcx+8]
   add r10, QWORD PTR [rdx]
   adc r11, QWORD PTR [rdx+8]
   mov QWORD PTR [r8], r10
   mov QWORD PTR [r8+8], r11
   ret  
Int128Add ENDP  
_text ENDS  
END