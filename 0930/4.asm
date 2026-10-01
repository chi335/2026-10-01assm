; Copying a String (CopyStr.asm)
; This program copies a string.

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:dword

.data
source BYTE "This is the source string", 0
target BYTE SIZEOF source DUP(0)

.code
main PROC
    mov esi, 0             ; index register
    mov ecx, SIZEOF source ; loop counter (문자열 길이만큼 반복)
    
L1:
    mov al, source[esi]    ; get a character from source
    mov target[esi], al    ; store it in the target
    inc esi                ; move to next character
    loop L1                ; repeat for entire string

    invoke ExitProcess, 0
main ENDP
END main