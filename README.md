# 4. Data Transfers, Addressing, and Arithmetic

<a id="top"></a>

어셈블리 언어의 데이터 전송, 주소 지정 방식, 산술 연산 및 제어 구조 정리 문서입니다.

---

## 📌 목차 (Table of Contents)
1. [데이터 전송 명령 (Data Transfer Instructions)](#1-데이터-전송-명령-data-transfer-instructions)
2. [산술 연산 및 상태 플래그 (Addition, Subtraction & Flags)](#2-산술-연산-및-상태-플래그-addition-subtraction--flags)
3. [데이터 관련 연산자 및 지시자 (Operators & Directives)](#3-데이터-관련-연산자-및-지시자-operators--directives)
4. [간접 어드레싱 및 포인터 (Indirect Addressing & Pointers)](#4-간접-어드레싱-및-포인터-indirect-addressing--pointers)
5. [분기 및 반복문 (JMP and LOOP Instructions)](#5-분기-및-반복문-jmp-and-loop-instructions)

---

<a id="1-데이터-전송-명령-data-transfer-instructions"></a>
## 1. 데이터 전송 명령 (Data Transfer Instructions)

데이터를 레지스터나 메모리로 이동 및 교환하는 명령어 세트입니다.

### 피연산자 (Operand) 유형
- **Immediate**: 리터럴 상수값 (예: `10`, `0FFFFh`)
- **Register**: CPU 레지스터 (예: `EAX`, `BX`, `AL`)
- **Memory**: 메모리 위치 참조 (예: `var1`, `[ESI]`)

### MOV 명령어 규칙
- **메모리 간 직접 이동 불가**: Memory to Memory 직접 전달은 불가능합니다.
- **특수 레지스터 제한**: `CS`, `IP/EIP` 레지스터는 목적지(Destination) 피연산자가 될 수 없습니다.
- **크기 일치**: 두 피연산자의 크기(Byte, Word, DWORD 등)가 일치해야 합니다.

### 부호 확장 및 Zero 확장 명령어
- **`MOVZX` (Move with Zero-Extend)**: 작은 크기의 피연산자를 큰 레지스터로 복사할 때, 상위 비트를 `0`으로 채웁니다. (무부호 정수용)
- **`MOVSX` (Move with Sign-Extend)**: 작은 크기의 피연산자를 큰 레지스터로 복사할 때, 상위 비트를 최상위 부호 비트(MSB)로 채웁니다. (부호 있는 정수용)

### 기타 주요 명령어
- **`LAHF` / `SAHF`**: EFLAGS 레지스터의 하위 바이트를 `AH` 레지스터에 로드하거나(`LAHF`), `AH`의 값을 EFLAGS 하위 바이트에 저장(`SAHF`).
- **`XCHG` (Exchange)**: 두 피연산자의 값을 서로 교환합니다. (메모리 간 직접 교환은 불가하며 레지스터를 거쳐야 함)
- **Direct-Offset Addressing**: 배열의 기준 주소에 오프셋을 더해 메모리 요소에 직접 접근합니다. (예: `[arrayB + 1]`, `[arrayW + 2]`)

[⬆ 맨 위로 이동](#top)

---

<a id="2-산술-연산-및-상태-플래그-addition-subtraction--flags"></a>
## 2. 산술 연산 및 상태 플래그 (Addition, Subtraction & Flags)

정수 데이터의 기본 산술 연산과 연산 결과에 따른 상태 플래그 변화를 다룹니다.

### 기본 산술 명령어
- **`INC` / `DEC`**: 피연산자의 값을 1 증가 / 1 감소.
- **`ADD` / `SUB`**: 두 피연산자를 더함 / 뺌.

### 상태 플래그 (Status Flags)
- **CF (Carry Flag)**: 무부호(Unsigned) 정수 연산 시 올림/내림이 발생한 경우 설정.
- **OF (Overflow Flag)**: 부호 있는(Signed) 정수 연산 시 결과가 표현 범위를 벗어난 경우 설정.
- **SF (Sign Flag)**: 연산 결과가 음수(최상위 비트가 1)인 경우 설정.
- **ZF (Zero Flag)**: 연산 결과가 0인 경우 설정.

[⬆ 맨 위로 이동](#top)

---

<a id="3-데이터-관련-연산자-및-지시자-operators--directives"></a>
## 3. 데이터 관련 연산자 및 지시자 (Operators & Directives)

메모리 주소 계산 및 데이터 크기 지정을 위한 연산자와 지시자입니다.

| 연산자 / 지시자 | 설명 |
| :--- | :--- |
| **`OFFSET`** | 데이터 레이블의 메모리 세그먼트 시작 지점으로부터의 오프셋(바이트 거리)을 반환 |
| **`ALIGN`** | CPU의 메모리 접근 속도 향상을 위해 변수를 2, 4, 8바이트 등의 경계에 맞춰 정렬 |
| **`PTR`** | 피연산자의 기본 선언 크기를 재정의 (예: `WORD PTR myDouble`) |
| **`TYPE`** | 데이터 요소 1개의 크기(바이트)를 반환 (BYTE=1, WORD=2, DWORD=4, QWORD=8) |
| **`LENGTHOF`** | 한 줄에 정의된 배열 요소의 개수를 반환 |
| **`SIZEOF`** | 배열 전체의 바이트 크기를 반환 ($\text{LENGTHOF} \times \text{TYPE}$) |
| **`LABEL`** | 메모리를 추가로 할당하지 않고 기존 위치에 새로운 크기 속성을 가진 레이블을 부여 |

[⬆ 맨 위로 이동](#top)

---

<a id="4-간접-어드레싱-및-포인터-indirect-addressing--pointers"></a>
## 4. 간접 어드레싱 및 포인터 (Indirect Addressing & Pointers)

메모리 주소를 담고 있는 레지스터를 활용한 간접 참조 기법입니다.

- **간접 피연산자 (Indirect Operands)**: 레지스터(예: `ESI`, `EDI`)에 메모리 주소를 저장한 후 `[esi]` 형태로 데이터를 참조합니다.
- **배열 순회 (Array Traversal)**:
  - 요소 크기(1, 2, 4바이트 등)에 맞게 `ESI` 주소값을 증가시키며 배열을 순회합니다.
  - 인덱스 방식 접근: `arrayW[ESI]` 또는 `[ESI + 2]` 형태로 인덱스/변위(Displacement)를 사용합니다.
- **포인터 변수 및 `TYPEDEF`**:
  - `TYPEDEF`를 사용해 포인터 타입을 정의할 수 있습니다. (예: `PBYTE TYPEDEF PTR BYTE`)
  - 주소값을 포인터 변수에 저장하여 동적으로 메모리에 접근합니다.

[⬆ 맨 위로 이동](#top)

---

<a id="5-분기-및-반복문-jmp-and-loop-instructions"></a>
## 5. 분기 및 반복문 (JMP and LOOP Instructions)

프로그램의 실행 흐름을 제어하는 명령어입니다.

- **`JMP` (Unconditional Jump)**: 조건 없이 지정된 코드 레이블 위치로 이동합니다.
- **`LOOP` (Loop According to ECX)**:
  - `ECX` 레지스터를 카운터로 자동 사용합니다.
  - `LOOP` 실행 시마다 `ECX`가 1 감소하며, `ECX != 0`인 동안 지정된 레이블로 반복 이동합니다.
- **중첩 루프 (Nested Loops)**:
  - 바깥 루프와 안쪽 루프 모두 `ECX`를 사용하므로, 안쪽 루프 진입 전 바깥 루프의 `ECX` 값을 변수나 스택에 보존해야 합니다.

[⬆ 맨 위로 이동](#top)
