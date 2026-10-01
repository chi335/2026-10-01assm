.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
bigEndian    BYTE  12h, 34h, 56h, 78h
littleEndian DWORD ?

.code
main PROC
    ; bigEndian의 바이트를 역순으로 읽어 littleEndian에 저장
    mov al, [bigEndian + 3]
    mov BYTE PTR [littleEndian + 0], al

    mov al, [bigEndian + 2]
    mov BYTE PTR [littleEndian + 1], al

    mov al, [bigEndian + 1]
    mov BYTE PTR [littleEndian + 2], al

    mov al, [bigEndian + 0]
    mov BYTE PTR [littleEndian + 3], al

    ; 검증용: EAX 레지스터에 12345678h가 저장됨
    mov eax, littleEndian

    INVOKE ExitProcess, 0
main ENDP
END main