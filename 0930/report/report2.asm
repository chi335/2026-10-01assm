.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 10h, 20h, 30h, 40h, 50h, 60h, 70h, 80h
ArraySize = ($ - array) / TYPE array

.code
main PROC
    mov ecx, ArraySize / 2
    mov esi, 0

L1:
    mov eax, array[esi]
    mov ebx, array[esi + 4]

    mov array[esi], ebx
    mov array[esi + 4], eax

    add esi, TYPE array * 2
    loop L1

    INVOKE ExitProcess, 0
main ENDP
END main