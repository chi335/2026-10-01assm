.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
source BYTE "This is the source string", 0
target BYTE SIZEOF source DUP('#')

.code
main PROC
    mov ecx, SIZEOF source - 1                 ; 널 문자를 제외한 글자 수
    mov esi, OFFSET source + SIZEOF source - 2 ; source의 마지막 문자 ('g') 주소
    mov edi, OFFSET target                     ; target 시작 주소

L1:
    mov al, [esi]                              ; 간접 주소 지정으로 문자 읽기
    mov [edi], al                              ; target 위치에 문자 복사
    dec esi                                    ; source는 역방향으로 이동
    inc edi                                    ; target은 정방향으로 이동
    loop L1

    mov BYTE PTR [edi], 0                      ; target 문자열 끝에 널 문자(0) 삽입

    INVOKE ExitProcess, 0
main ENDP
END main