.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 0, 2, 5, 9, 10
ArraySize = ($ - array) / TYPE array
sum DWORD ?

.code
main PROC
    mov ecx, ArraySize - 1
    mov esi, 0
    mov eax, 0

L1:
    mov edx, array[esi + TYPE array]
    sub edx, array[esi]
    add eax, edx

    add esi, TYPE array
    loop L1

    mov sum, eax

    INVOKE ExitProcess, 0
main ENDP
END main