_text SEGMENT  

public DllMain

; DllMain
; ---------
; RCX - hInstance (QWORD) HANDLE to INSTANCE
; RDX - fdwREason (DWORD) - (EDX)
; R8  - lpvReserved (QWORD) PTR VOID
; R9  - unused
; ---------
; RAX (EAX) BOOL return value, volatile internally
; R10 volatile
; R11 volatile
DllMain PROC FRAME  
   push rbp  
.pushreg rbp  
   sub rsp, 010h  
.allocstack 010h  
   mov rbp, rsp  
.setframe rbp, 0  
.endprolog  
   cmp edx, 0
   je  dll_process_detach
   cmp edx, 1
   je  dll_process_attach
   cmp edx, 2
   je  dll_thread_attach
   cmp edx, 3
   je  dll_thread_detach
   jmp exit_dll_main

dll_process_detach:
   jmp exit_dll_main

dll_process_attach:
   jmp exit_dll_main

dll_thread_attach:
   jmp exit_dll_main

dll_thread_detach:
   jmp exit_dll_main

exit_dll_main:
   mov eax, 1 ; TRUE = 1, assume 32 bits is enough, otherwise change to RAX.
   ; epilog  
   add rsp, 010h  
   pop rbp  
   ret  
DllMain ENDP  
_text ENDS  
END