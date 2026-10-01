.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
wArray WORD 1000h, 2000h, 3000h, 4000h, 5000h
ArraySize = ($ - wArray) / TYPE wArray
dwArray DWORD ArraySize DUP(?)

.code
main PROC
    mov ecx, ArraySize
    mov esi, 0
    mov edi, 0

L1:
    movzx eax, wArray[esi]
    mov dwArray[edi], eax

    add esi, TYPE wArray
    add edi, TYPE dwArray
    loop L1

    INVOKE ExitProcess, 0
main ENDP
END main