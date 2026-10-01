.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
; 첫 두 개의 값은 1, 1로 초기화하고 나머지 5개 공간을 0으로 생성
fib DWORD 1, 1, 5 DUP(?)
ArraySize = ($ - fib) / TYPE fib

.code
main PROC
    mov ecx, ArraySize - 2            ; 반복 횟수 = 7 - 2 = 5회
    mov esi, TYPE fib * 2             ; 3번째 요소(index 2, offset 8)부터 시작

L1:
    mov eax, fib[esi - TYPE fib * 2]  ; Fib(n-2) 값 읽기
    add eax, fib[esi - TYPE fib]      ; Fib(n-1) 값 더하기
    mov fib[esi], eax                 ; Fib(n)에 계산된 값 저장

    add esi, TYPE fib                 ; 다음 요소 위치(4바이트 이동)
    loop L1

    INVOKE ExitProcess, 0
main ENDP
END main