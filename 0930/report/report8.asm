.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
array DWORD 10, 20, 30, 40
ArraySize = ($ - array) / TYPE array

.code
main PROC
    ; 1. 배열의 마지막 요소를 EAX 레지스터에 임시 저장
    mov eax, array[SIZEOF array - TYPE array]

    ; 2. 루프 설정 (뒤에서부터 이동하므로 반복 횟수는 전체 크기 - 1)
    mov ecx, ArraySize - 1
    mov esi, SIZEOF array - TYPE array  ; ESI = 마지막 요소의 바이트 오프셋

L1:
    ; 이전 요소의 값을 현재 위치로 덮어씀
    mov ebx, array[esi - TYPE array]
    mov array[esi], ebx

    sub esi, TYPE array                 ; 인덱스를 이전 요소 위치로 이동 (4바이트 감소)
    loop L1

    ; 3. 백업해둔 마지막 값을 배열의 맨 첫 번째 요소(array[0])에 저장
    mov array[0], eax

    INVOKE ExitProcess, 0
main ENDP
END main