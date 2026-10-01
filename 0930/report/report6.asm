.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; 데이터 타입(DWORD, WORD 등) 및 크기가 바뀌어도 아래 연산자들 덕분에 코드가 자동 조정됩니다.
array DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9

.code
main PROC
    mov ecx, LENGTHOF array / 2         ; 루프 횟수 = 배열 길이 / 2
    mov esi, 0                          ; 첫 번째 요소 오프셋
    mov edi, SIZEOF array - TYPE array  ; 마지막 요소 오프셋

L1:
    ; 1. 양 끝의 두 값을 레지스터로 읽어서 교환 (In-place Swap)
    mov eax, array[esi]
    mov ebx, array[edi]
    mov array[esi], ebx
    mov array[edi], eax

    ; 2. 인덱스 포인터 이동 (TYPE array 연산자 사용)
    add esi, TYPE array                 ; ESI는 앞에서 뒤로 이동
    sub edi, TYPE array                 ; EDI는 뒤에서 앞으로 이동
    loop L1

    INVOKE ExitProcess, 0
main ENDP
END main