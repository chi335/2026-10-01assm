### 1.[Question]
**What will be the value in EDX after each of the lines marked (a) and (b) execute?**
(표시된 (a)와 (b) 줄이 각각 실행된 후 EDX 레지스터에 들어있는 값은 무엇입니까?)

---

### [Answer]
* **(a) 실행 후 EDX의 값:** `FFFF8002h`
* **(b) 실행 후 EDX의 값:** `00004321h`

---

### [Explanation]
이 문제의 핵심은 **`MOVSX` (Move with Sign-Extend, 부호 확장 이동)** 명령어의 동작 방식을 이해하는 것입니다.

* `MOVSX` 명령어는 작은 크기의 데이터를 큰 크기의 레지스터로 복사할 때, **원본 데이터의 부호 비트(최상위 비트, MSB)**를 확인하여 남은 상위 공간을 부호 비트와 같은 값(0 또는 1)으로 채웁니다.

#### 1. (a) `movsx edx, one` 실행 후
* `one`의 값은 `8002h` (16비트 WORD)입니다.
* `8002h`를 2진수로 바꾸면 `1000 0000 0000 0010`이 되며, **최상위 비트(MSB)가 `1`**입니다. (음수)
* 32비트 레지스터인 `EDX`로 복사되면서 상위 16비트는 모두 `1`로 채워집니다 (`FFFFh`).
* 따라서 `EDX`의 값은 **`FFFF8002h`**가 됩니다.

#### 2. (b) `movsx edx, two` 실행 후
* `two`의 값은 `4321h` (16비트 WORD)입니다.
* `4321h`를 2진수로 바꾸면 `0100 0011 0010 0001`이 되며, **최상위 비트(MSB)가 `0`**입니다. (양수)
* 32비트 레지스터인 `EDX`로 복사되면서 상위 16비트는 모두 `0`으로 채워집니다 (`0000h`).
* 따라서 `EDX`의 값은 **`00004321h`**가 됩니다.
---


### 2.[문제 / Question]
What will be the value in EAX after the following lines execute?
(다음 줄들이 실행된 후 EAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
mov  eax,1002FFFFh
inc  ax
```

---

### [정답 / Answer]
* **`inc ax` 실행 후 EAX의 값:** `10020000h`

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **하위 레지스터(`AX`)의 연산이 전체 레지스터(`EAX`)의 상위 비트에 영향을 주는지 여부**를 이해하는 것입니다.

#### 1. `mov eax, 1002FFFFh` 실행 후
* 32비트 레지스터인 `EAX`에 `1002FFFFh` 값이 저장됩니다.
* 이때 `EAX`는 두 부분으로 나누어 볼 수 있습니다.
  * **상위 16비트:** `1002h`
  * **하위 16비트(`AX`):** `FFFFh`

#### 2. `inc ax` 실행 후
* `inc` 명령어는 값을 1 증가시킵니다. 하지만 대상이 `EAX`가 아닌 **16비트 하위 레지스터인 `AX`**입니다.
* `AX` 값인 `FFFFh`에 1을 더하면 `10000h`가 되지만, `AX`는 16비트 공간만 가지므로 자릿수 넘침(Overflow)이 발생하여 **`0000h`**가 됩니다.
* **중요:** 16비트 레지스터(`AX`) 연산에서 발생한 올림(Carry)은 `EAX`의 상위 16비트(`1002h`)로 전달되지 않고 **독립적으로 동작**합니다.
* 따라서 상위 16비트 `1002h`는 그대로 유지되고, 하위 16비트 `AX`만 `0000h`로 변경됩니다.

#### 3. 최종 결과
* 상위 16비트(`1002h`) + 하위 16비트(`0000h`) = **`10020000h`**

---
### 3.[문제 / Question]
What will be the value in EAX after the following lines execute?
(다음 줄들이 실행된 후 EAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
mov  eax,30020000h
dec  ax
```

---

### [정답 / Answer]
* **`dec ax` 실행 후 EAX의 값:** `3002FFFFh`

---

### [풀이 및 설명 / Explanation]
이 문제 역시 **하위 레지스터(`AX`)의 감소 연산이 전체 레지스터(`EAX`)의 상위 비트에 영향을 주지 않는다는 점**을 이해하는 것이 핵심입니다.

#### 1. `mov eax, 30020000h` 실행 후
* 32비트 레지스터인 `EAX`에 `30020000h` 값이 저장됩니다.
* 이때 `EAX`는 두 부분으로 나누어 볼 수 있습니다.
  * **상위 16비트:** `3002h`
  * **하위 16비트(`AX`):** `0000h`

#### 2. `dec ax` 실행 후
* `dec` 명령어는 값을 1 감소시킵니다. 대상은 16비트 하위 레지스터인 **`AX`**입니다.
* `AX` 값인 `0000h`에서 1을 빼면 언더플로우(Underflow)가 발생하여 **`FFFFh`**가 됩니다.
* **중요:** 16비트 레지스터(`AX`) 연산에서 발생한 빌림(Borrow)은 `EAX`의 상위 16비트(`3002h`)에 전달되지 않고 **독립적으로 동작**합니다.
* 따라서 상위 16비트 `3002h`는 그대로 유지되고, 하위 16비트 `AX`만 `FFFFh`로 변경됩니다.

#### 3. 최종 결과
* 상위 16비트(`3002h`) + 하위 16비트(`FFFFh`) = **`3002FFFFh`**

---


### 4.[문제 / Question]
What will be the value in EAX after the following lines execute?
(다음 줄들이 실행된 후 EAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
mov  eax,1002FFFFh
neg  ax
```

---

### [정답 / Answer]
* **`neg ax` 실행 후 EAX의 값:** `10020001h`

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **`NEG` 명령어의 동작 방식(2의 보수 취하기)**과 **하위 레지스터(`AX`) 연산이 전체 레지스터(`EAX`)의 상위 비트에 영향을 주지 않는다는 점**을 이해하는 것입니다.

#### 1. `mov eax, 1002FFFFh` 실행 후
* 32비트 레지스터인 `EAX`에 `1002FFFFh` 값이 저장됩니다.
* 이때 `EAX`는 두 부분으로 나누어 볼 수 있습니다.
  * **상위 16비트:** `1002h`
  * **하위 16비트(`AX`):** `FFFFh`

#### 2. `neg ax` 실행 후
* `NEG` 명령어는 대상의 부호를 반대로 바꾸는 연산으로, **2의 보수(2's complement)**를 구합니다.
  * **2의 보수 구하는 법:** 비트 반전(NOT) 후 1을 더함
* `AX` 값인 `FFFFh`의 비트를 반전하면 `0000h`가 되고, 여기에 1을 더하면 **`0001h`**가 됩니다.
* **중요:** 16비트 레지스터(`AX`) 연산은 `EAX`의 상위 16비트(`1002h`)에 전혀 영향을 주지 않습니다.
* 따라서 상위 16비트 `1002h`는 그대로 유지되고, 하위 16비트 `AX`만 `0001h`로 변경됩니다.

#### 3. 최종 결과
* 상위 16비트(`1002h`) + 하위 16비트(`0001h`) = **`10020001h`**

---

### 5.[문제 / Question]
What will be the value of the Parity flag after the following lines execute?
(다음 줄들이 실행된 후 패리티 플래그(Parity flag)의 값은 무엇입니까?)

```assembly
mov  al,1
add  al,3
```

---

### [정답 / Answer]
* **`add al, 3` 실행 후 패리티 플래그(PF)의 값:** `0` (Clear)

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **패리티 플래그(Parity Flag, PF)**가 언제 `1` 또는 `0`이 되는지 이해하는 것입니다.

#### 1. 코드 실행 과정
* `mov al, 1` : `AL` 레지스터에 `1`을 저장합니다.
* `add al, 3` : `AL` 레지스터의 값에 `3`을 더해 **`4`**가 됩니다.

#### 2. 패리티 플래그(PF)의 판별 기준
* 패리티 플래그는 연산 결과의 **하위 8비트에 포함된 `1`의 개수**를 확인합니다.
  * `1`의 개수가 **짝수(Even)**개이면 ➡️ **`PF = 1`**
  * `1`의 개수가 **홀수(Odd)**개이면 ➡️ **`PF = 0`**

#### 3. 결과값 분석
* 연산 결과인 `4`를 8비트 2진수로 변환하면 **`0000 0100b`**입니다.
* `0000 0100b`에서 비트 `1`의 개수를 세어보면 **총 1개**입니다.
* `1`이 1개(홀수)이므로 패리티 플래그는 **`0`**이 됩니다.

---

### 6.[문제 / Question]
What will be the value of EAX and the Sign flag after the following lines execute?
(다음 줄들이 실행된 후 EAX 레지스터와 부호 플래그(Sign flag)의 값은 무엇입니까?)

```assembly
mov  eax,5
sub  eax,6
```

---

### [정답 / Answer]
* **`EAX`의 값:** `FFFFFFFFh` (십진수 -1)
* **부호 플래그(SF)의 값:** `1` (Set, 음수를 나타냄)

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **음수의 32비트 표현방식(2의 보수)**과 **부호 플래그(Sign Flag, SF)**의 설정 조건을 이해하는 것입니다.

#### 1. 코드 실행 과정
* `mov eax, 5` : `EAX` 레지스터에 `5`를 저장합니다.
* `sub eax, 6` : `EAX` 레지스터의 값에서 `6`을 뺍니다. (`5 - 6 = -1`)

#### 2. EAX 레지스터 값 (`-1` 표현)
* 컴퓨터는 음수를 **2의 보수(2's complement)** 형태로 표현합니다.
* 32비트 레지스터인 `EAX`에서 `-1`은 비트가 모두 `1`로 채워진 **`FFFFFFFFh`**가 됩니다.

#### 3. 부호 플래그(SF) 판단 기준
* 부호 플래그는 연산 결과의 **최상위 비트(MSB, Most Significant Bit)** 값을 그대로 가져옵니다.
  * 결과가 **양수 (MSB = 0)** ➡️ **`SF = 0`**
  * 결과가 **음수 (MSB = 1)** ➡️ **`SF = 1`**
* `FFFFFFFFh`를 2진수로 바꾸면 `1111 1111 ... 1111`이 되어 **최상위 비트가 `1`**입니다.
* 따라서 부호 플래그(SF)의 값은 **`1`**이 됩니다.

---


### 7.[문제 / Question]
In the following code, the value in AL is intended to be a signed byte. Explain how the Overflow flag helps, or does not help you, to determine whether the final value in AL falls within a valid signed range.
(다음 코드에서 AL의 값은 부호 있는 바이트(signed byte)로 사용됩니다. 오버플로우 플래그(OF)가 AL의 최종 값이 유효한 부호 있는 범위 내에 있는지 판단하는 데 어떻게 도움이 되거나 도움이 되지 않는지 설명하시오.)

```assembly
mov  al,-1
add  al,130
```

---

### [정답 / Answer]
* **결론:** 오버플로우 플래그(OF)는 이 상황을 감지하는 데 **도움이 되지 않습니다 (`OF = 0`).**
* **이유:** 피연산자인 `130`이 이미 8비트 부호 있는 바이트의 표현 범위(`-128` ~ `+127`)를 벗어났기 때문에, CPU는 이를 **`-126`**으로 해석하여 정상 연산(`-1 + (-126) = -127`)으로 처리합니다.

---

### [풀이 및 설명 / Explanation]

#### 1. 부호 있는 바이트(Signed Byte)의 범위
* 8비트 부호 있는 정수의 유효 범위는 **`-128` ~ `+127`**입니다.
* 수학적으로 `-1 + 130 = 129`이므로, 결과인 `129`는 부호 있는 바이트 범위를 벗어납니다.

#### 2. 피연산자 `130`이 CPU에서 변환되는 방식
* `130`을 8비트 16진수로 표현하면 **`82h`** (`1000 0010b`)입니다.
* 하지만 부호 있는 정수(Signed) 관점에서 최상위 비트(MSB)가 `1`인 `82h`는 `+130`이 아니라 **`-126`**을 의미합니다.

#### 3. CPU의 실제 연산과 오버플로우 플래그(OF)
* CPU는 프로그래머의 의도와 달리 **`-1 + (-126)`** 연산을 수행합니다.
  * `-1` (`FFh`) + `-126` (`82h`) = **`-127` (`81h`)**
* 연산 결과인 **`-127`**은 부호 있는 바이트 범위(`-128` ~ `+127`) 내에 **정상적으로 존재하는 값**입니다.
* 음수와 음수를 더해서 음수가 나왔으므로, CPU 입장에선 오버플로우가 발생하지 않았다고 판단하여 **`OF = 0`** (Clear)으로 설정합니다.

#### 4. 결론
* 프로그래머의 의도 상 결과(`129`)는 범위를 초과했지만, 피연산자 `130` 자체가 이미 `-126`으로 잘못 잘려 들어갔기 때문에 **오버플로우 플래그(OF)는 `0`이 되며 범위를 벗어났음을 알려주지 못합니다.**

---

### 8.[문제 / Question]
What value will RAX contain after the following instruction executes?
(다음 명령어가 실행된 후 RAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
mov  rax,44445555h
```

---

### [정답 / Answer]
* **`mov rax, 44445555h` 실행 후 RAX의 값:** `0000000044445555h`

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **64비트 레지스터(`RAX`)의 크기**와 **32비트 즉시값(Immediate Value)이 지정되었을 때 상위 비트가 어떻게 처리되는지** 이해하는 것입니다.

#### 1. 레지스터 및 값의 크기
* **`RAX`:** 64비트(16진수 16자리) 크기의 레지스터입니다.
* **`44445555h`:** 32비트(16진수 8자리) 크기의 상수값입니다.

#### 2. 상위 32비트 처리 방식 (Zero Extension)
* x86-64 아키텍처에서는 32비트 상수를 64비트 레지스터에 대입할 때, **상위 32비트가 자동으로 `0`으로 채워집니다 (Zero-extension).**
* `44445555h`의 최상위 비트(MSB)가 `0`이므로 양수로 취급되어 상위 32비트는 모두 `0`으로 확장됩니다.

#### 3. 최종 결과
* **상위 32비트:** `00000000h`
* **하위 32비트:** `44445555h`
* **합쳐진 RAX 값:** **`0000000044445555h`**

---

### 9.[문제 / Question]
What value will RAX contain after the following instructions execute?
(다음 명령어들이 실행된 후 RAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
.data
dwordVal DWORD 84326732h

.code
mov  rax,0FFFFFFFF00000000h
mov  rax,dwordVal
```

---

### [정답 / Answer]
* **`mov rax, dwordVal` 실행 후 RAX의 값:** `0000000084326732h`

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **x86-64 아키텍처에서 32비트(DWORD) 값을 64비트 레지스터에 대입할 때 상위 32비트가 어떻게 변하는지** 이해하는 것입니다.

#### 1. 첫 번째 명령어 실행 (`mov rax, 0FFFFFFFF00000000h`)
* 64비트 레지스터 `RAX`에 `FFFFFFFF00000000h` 값이 저장됩니다.
  * **상위 32비트:** `FFFFFFFFh`
  * **하위 32비트:** `00000000h`

#### 2. 두 번째 명령어 실행 (`mov rax, dwordVal`)
* `dwordVal`은 32비트(DWORD) 크기의 변수로, 값은 `84326732h`입니다.
* 이 32비트 값을 `RAX` 레지스터로 이동시킵니다.

#### 3. x86-64의 영확장(Zero-Extension) 규칙
* x86-64 아키텍처에서는 **32비트 피연산자를 다루는 명령어가 실행될 때 64비트 레지스터의 상위 32비트를 자동으로 `0`으로 초기화(Zero-extension)**합니다.
* 따라서 기존 `RAX` 상위 32비트에 남아있던 `FFFFFFFFh`는 모두 지워지고 **`00000000h`**가 됩니다.

#### 4. 최종 결과
* 상위 32비트(`00000000h`) + 하위 32비트(`84326732h`) = **`0000000084326732h`**

---

### 10.[문제 / Question]
What value will EAX contain after the following instructions execute?
(다음 명령어들이 실행된 후 EAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
.data
dVal DWORD 12345678h

.code
mov  ax,3
mov  WORD PTR dVal+2,ax
mov  eax,dVal
```

---

### [정답 / Answer]
* **`mov eax, dVal` 실행 후 EAX의 값:** `00035678h`

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **리틀 엔디언(Little-Endian) 메모리 저장 방식**과 **메모리 오프셋 연산(`dVal+2`)**을 이해하는 것입니다.

#### 1. `dVal DWORD 12345678h` 메모리 저장 상태 (리틀 엔디언)
x86 시스템은 하위 바이트를 낮은 주소에 저장하는 **리틀 엔디언** 방식을 사용합니다.
* `dVal + 0` (1번째 바이트): `78h`
* `dVal + 1` (2번째 바이트): `56h`
* `dVal + 2` (3번째 바이트): `34h`
* `dVal + 3` (4번째 바이트): `12h`

이때 `dVal`을 WORD(16비트, 2바이트) 단위로 나눠서 보면:
* **하위 WORD (`dVal`):** `5678h`
* **상위 WORD (`dVal+2`):** `1234h`

#### 2. 명령어 실행과 메모리 변경 과정
1. `mov ax, 3`
   * `AX` 레지스터에 16비트 값 `0003h`를 저장합니다.

2. `mov WORD PTR dVal+2, ax`
   * `dVal` 메모리의 **상위 WORD 위치(`dVal+2`)**에 `AX` 값(`0003h`)을 덮어씁니다.
   * 기존 상위 WORD였던 `1234h`가 **`0003h`**로 변경됩니다.
   * (하위 WORD인 `5678h`는 그대로 유지됩니다.)

3. `mov eax, dVal`
   * 변경된 32비트 메모리 `dVal` 값을 `EAX`로 읽어옵니다.

#### 3. 최종 결과
* 상위 16비트(`0003h`) + 하위 16비트(`5678h`) = **`00035678h`**

---

### 11.[문제 / Question]
What will EAX contain after the following instructions execute?
(다음 명령어들이 실행된 후 EAX 레지스터에 들어있는 값은 무엇입니까?)

```assembly
.data
dVal DWORD ?

.code
mov  dVal,12345678h
mov  ax,WORD PTR dVal+2
add  ax,3
mov  WORD PTR dVal,ax
mov  eax,dVal
```

---

### [정답 / Answer]
* **`mov eax, dVal` 실행 후 EAX의 값:** `12341237h`

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **리틀 엔디언 메모리 구조에서 상위 WORD와 하위 WORD를 오프셋(`dVal`, `dVal+2`)으로 접근하는 연산 순서**를 추적하는 것입니다.

#### 1. `mov dVal, 12345678h`
* 32비트 변수 `dVal`에 `12345678h` 값이 저장됩니다.
* 리틀 엔디언 구조에 따른 WORD(16비트) 분할:
  * **하위 WORD (`dVal`):** `5678h`
  * **상위 WORD (`dVal+2`):** `1234h`

#### 2. `mov ax, WORD PTR dVal+2`
* `dVal+2` 위치의 값인 **상위 WORD(`1234h`)**를 읽어 와서 `AX` 레지스터에 저장합니다.
* `AX` = `1234h`

#### 3. `add ax, 3`
* `AX` 값에 `3`을 더합니다.
* `AX` = `1234h + 3` = **`1237h`**

#### 4. `mov WORD PTR dVal, ax`
* `AX` 값(`1237h`)을 `dVal` 메모리의 **하위 WORD 위치(`dVal`)**에 덮어씁니다.
* 이에 따라 기존 하위 WORD였던 `5678h`가 **`1237h`**로 변경됩니다.
* (상위 WORD `1234h`는 변함없이 그대로 유지됩니다.)

#### 5. `mov eax, dVal`
* 최종적으로 변경된 32비트 메모리 `dVal` 전체 값을 `EAX` 레지스터로 복사합니다.
* **상위 WORD (`1234h`) + 하위 WORD (`1237h`) = `12341237h`**

---

### 12.[문제 / Question]
(Yes/No): Is it possible to set the Overflow flag if you add a positive integer to a negative integer?
((예/아니오): 양의 정수와 음의 정수를 더할 때 오버플로우 플래그(Overflow flag)가 1로 설정되는 것이 가능합니까?)

---

### [정답 / Answer]
* **정답:** **No (불가능합니다)**

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **부호 있는 정수의 가산(Addition)에서 오버플로우가 발생하는 수학적/논리적 조건**을 이해하는 것입니다.

#### 1. 오버플로우 플래그(OF)의 발생 조건
오버플로우는 **연산 결과가 표현 가능한 부호 있는 범위를 벗어났을 때** 발생합니다.

* **양수 + 양수 = 음수**가 나온 경우 ➡️ **오버플로우 발생 (`OF = 1`)**
  * 예: `100 + 50 = 150` (8비트 범위인 `-128 ~ +127`을 초과하여 음수가 됨)
* **음수 + 음수 = 양수**가 나온 경우 ➡️ **오버플로우 발생 (`OF = 1`)**
  * 예: `-100 + (-50) = -150` (8비트 범위를 벗어나 양수가 됨)

#### 2. 양수 + 음수의 경우 (왜 오버플로우가 불가능한가?)
양수($A \ge 0$)와 음수($B < 0$)를 더할 때, 연산 결과($S = A + B$)는 항상 두 수 사이에 위치하게 됩니다.

$$B \le S \le A$$

* 피연산자 $A$와 $B$가 이미 해당 비트 수(예: 8비트, 32비트 등)의 **유효한 범위 내에 존재하는 값**이었다면, 그 사이에 위치하는 결과값 $S$ 역시 **무조건 유효한 범위 안에 들어오게 됩니다.**
* 따라서 양수와 음수를 더할 때는 절대로 표현 범위를 초과할 수 없으므로 **오버플로우 플래그(OF)는 항상 `0`**이 됩니다.

---

### 13.[문제 / Question]
(Yes/No): Will the Overflow flag be set if you add a negative integer to a negative integer and produce a positive result?
((예/아니오): 음의 정수와 음의 정수를 더하여 양수 결과가 나온 경우 오버플로우 플래그(Overflow flag)가 1로 설정됩니까?)

---

### [정답 / Answer]
* **정답:** **Yes (설정됩니다)**

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **부호 있는 연산에서 오버플로우(Overflow)가 발생하는 조건**을 이해하는 것입니다.

#### 1. 오버플로우 플래그(OF)의 정의
오버플로우 플래그(OF)는 **부호 있는 정수(Signed Integer) 연산의 결과가 지정된 비트 크기의 표현 범위를 벗어났을 때** `1`로 설정됩니다.

#### 2. 음수 + 음수 = 양수가 되는 원리
* **수학적 사실:** 두 음수를 더하면 반드시 결과도 음수가 되어야 합니다.
* **현상:** 하지만 두 음수의 합이 해당 비트로 표현할 수 있는 가장 작은 음수(예: 8비트 기준 `-128`)보다 더 작아지면(언더플로우 발생), 비트가 넘어가면서 **최상위 비트(부호 비트, MSB)가 `0`(양수)으로 뒤집히게 됩니다.**
* **예시 (8비트 부호 있는 정수):**
  * `-100` (`9Ch`) + `-50` (`CEh`) = `-150`
  * 8비트 표현 범위는 `-128 ~ +127`이므로 `-150`은 표현할 수 없습니다.
  * 실제 비트 연산 결과: `10110 1010b` ➡️ 8비트 잘림 ➡️ `0110 1010b` (`+106`)
  * 음수끼리 더했는데 결과의 부호 비트가 `0`(양수)이 되었습니다.

#### 3. 결론
* CPU는 **음수와 음수를 더했는데 양수가 나오는 모순된 결과**를 감지하여, 부호 있는 연산에 오류가 발생했음을 알리기 위해 **오버플로우 플래그(OF)를 `1`로 설정(Set)**합니다.

---

### 14.[문제 / Question]
(Yes/No): Is it possible for the NEG instruction to set the Overflow flag?
((예/아니오): NEG 명령어가 오버플로우 플래그(Overflow flag)를 1로 설정하는 것이 가능합니까?)

---

### [정답 / Answer]
* **정답:** **Yes (가능합니다)**

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **2의 보수(2's Complement) 표현 체계의 음수/양수 범위의 비대칭성**을 이해하는 것입니다.

#### 1. `NEG` 명령어의 동작 방식
* `NEG` 명령어는 피연산자의 부호를 반전시키는 연산으로, **2의 보수**를 구합니다 (비트 반전 후 +1).
* 즉, **`NEG x`는 `-x`**를 구하는 연산입니다.

#### 2. 오버플로우가 발생하는 예외 케이스
부호 있는 정수(Signed Integer)의 표현 범위는 항상 **음수 쪽이 1개 더 많습니다.**
* **8비트 범위:** `-128` ~ `+127`
* **16비트 범위:** `-32,768` ~ `+32,767`
* **32비트 범위:** `-2,147,483,648` ~ `+2,147,483,647`

여기서 **가장 작은 음수(최댓값의 absolute)**에 `NEG`를 취할 때 문제가 발생합니다.

#### 3. 예시 (8비트 레지스터 기준)
```assembly
mov al, -128 ; AL = 80h (1000 0000b)
neg al       ; -(-128) = +128 을 구하려 함
```
* 수학적으로 `-(-128)`의 결과는 **`+128`**이어야 합니다.
* 하지만 8비트 부호 있는 정수가 표현할 수 있는 최대 양수는 **`+127`**까지입니다.
* `80h`의 2의 보수를 실제로 계산해 보면:
  1. 비트 반전: `0111 1111b` (`7Fh`)
  2. 1 더하기: `1000 0000b` (`80h` = `-128`)
* 결과값이 `+128`이 되지 못하고 다시 `-128`이 되어버리므로, 표현할 수 있는 범위를 벗어났음을 알려주기 위해 **오버플로우 플래그가 `1`로 설정(`OF = 1`)**됩니다.

#### 4. 결론
* 각 데이터 타입에서 **표현 가능한 가장 작은 음수**(예: `80h`, `8000h`, `80000000h`)에 `NEG` 연산을 수행하면 **오버플로우 플래그(OF)가 `1`이 됩니다.**

---

### 15.[문제 / Question]
(Yes/No): Is it possible for both the Sign and Zero flags to be set at the same time?
((예/아니오): 부호 플래그(Sign flag)와 제로 플래그(Zero flag)가 동시에 1로 설정되는 것이 가능합니까?)

---

### [정답 / Answer]
* **정답:** **No (불가능합니다)**

---

### [풀이 및 설명 / Explanation]
이 문제의 핵심은 **부호 플래그(SF)**와 **제로 플래그(ZF)**가 설정되는 조건과 최상위 비트(MSB)의 관계를 이해하는 것입니다.

#### 1. 각 플래그의 설정 조건
* **제로 플래그 (Zero Flag, ZF):**
  * 연산 결과가 **완전히 `0`일 때**만 `1`로 설정됩니다 (`ZF = 1`).
  * 즉, 모든 비트가 `0`이어야 합니다. (예: 8비트 기준 `0000 0000b`)

* **부호 플래그 (Sign Flag, SF):**
  * 연산 결과의 **최상위 비트(MSB, Most Significant Bit)가 `1`일 때** `1`로 설정됩니다 (`SF = 1`).
  * 최상위 비트가 `1`이라는 것은 연산 결과가 **음수**임을 의미합니다.

#### 2. 두 플래그가 동시에 `1`이 될 수 없는 이유
* 결과가 `0`이 되어 **`ZF = 1`**이 되려면, 최상위 비트(MSB)를 포함한 모든 비트가 **`0`**이어야 합니다.
* 하지만 **`SF = 1`**이 되려면 최상위 비트(MSB)가 반드시 **`1`**이어야 합니다.
* 한 연산 결과의 최상위 비트가 **동시에 `0`이면서 `1`일 수는 없으므로**, 두 플래그가 동시에 `1`이 되는 것은 논리적으로 **불가능**합니다.

#### 3. 요약
* **`ZF = 1`이면:** MSB가 `0`이므로 **`SF`는 무조건 `0`**입니다.
* **`SF = 1`이면:** MSB가 `1`이므로 결과가 절대 `0`이 될 수 없어 **`ZF`는 무조건 `0`**입니다.

---


### 16.[문제 / Question]
For each of the following statements, state whether or not the instruction is valid:
(앞서 선언된 변수들을 바탕으로, 다음 각 명령어의 유효성(Valid / Invalid)을 판별하시오.)

**참고 변수 선언:**
* `var1 SBYTE -4,-2,3,1` (1바이트)
* `var2 WORD 1000h,2000h,3000h,4000h` (2바이트)
* `var3 SWORD -16,-42` (2바이트)
* `var4 DWORD 1,2,3,4,5` (4바이트)

---

### [정답 및 설명 / Answer & Explanation]

| 항목 | 명령어 | 유효 여부 | 이유 (Explanation) |
| :---: | :--- | :---: | :--- |
| **a** | `mov ax, var1` | **Invalid** | 피연산자의 크기 불일치 (`AX`는 16비트, `var1`은 8비트) |
| **b** | `mov ax, var2` | **Valid** | 두 피연산자의 크기가 16비트로 동일함 |
| **c** | `mov eax, var3` | **Invalid** | 피연산자의 크기 불일치 (`EAX`는 32비트, `var3`은 16비트) |
| **d** | `mov var2, var3` | **Invalid** | x86에서 메모리 간 직접 이동(`Memory to Memory`)은 불가능함 |
| **e** | `movzx ax, var2` | **Invalid** | `MOVZX`는 목적지가 원본보다 더 커야 함 (둘 다 16비트로 크기 동일) |
| **f** | `movzx var2, al` | **Invalid** | `MOVZX`의 목적지(Destination)는 반드시 레지스터여야 함 (메모리 불가능) |
| **g** | `mov ds, ax` | **Valid** | 일반 16비트 레지스터(`AX`)의 값을 세그먼트 레지스터(`DS`)로 복사 가능 |
| **h** | `mov ds, 1000h` | **Invalid** | 상수(Immediate Value)를 세그먼트 레지스터(`DS`)에 직접 대입 불가능 |

---

### [항목별 상세 설명]

* **a. `mov ax, var1` ➡️ Invalid**
  * `AX`는 16비트 레지스터지만, `var1`은 8비트(`SBYTE`) 변수입니다. `mov` 명령어는 두 피연산자의 크기가 반드시 일치해야 합니다.

* **b. `mov ax, var2` ➡️ Valid**
  * `AX`와 `var2`(`WORD`) 모두 16비트 크기이므로 올바른 명령어입니다.

* **c. `mov eax, var3` ➡️ Invalid**
  * `EAX`는 32비트 레지스터지만, `var3`은 16비트(`SWORD`) 변수입니다. 크기 불일치로 오류가 발생합니다. (크기를 확장하려면 `movsx` 사용 필요)

* **d. `mov var2, var3` ➡️ Invalid**
  * x86 아키텍처는 하나의 명령어 안에서 메모리에서 메모리로의 직접 데이터 이동을 허용하지 않습니다. (레지스터를 거쳐서 이동해야 함)

* **e. `movzx ax, var2` ➡️ Invalid**
  * `MOVZX` (Zero-Extend) 명령어는 작은 크기의 데이터를 더 큰 크기의 레지스터로 확장하며 복사할 때 사용합니다. `AX`와 `var2`는 모두 16비트로 크기가 같아 쓸 수 없습니다.

* **f. `movzx var2, al` ➡️ Invalid**
  * `MOVZX` 명령어의 목적지(첫 번째 피연산자)는 **반드시 범용 레지스터**여야 합니다. 메모리 변수인 `var2`에는 결과를 저장할 수 없습니다.

* **g. `mov ds, ax` ➡️ Valid**
  * 16비트 범용 레지스터(`AX`)의 값을 세그먼트 레지스터(`DS`)로 이동하는 것은 표준 x86 어셈블리 문법입니다.

* **h. `mov ds, 1000h` ➡️ Invalid**
  * x86 구조상 세그먼트 레지스터(`DS`, `CS`, `SS`, `ES` 등)에는 상수(즉시값, Immediate)를 직접 대입할 수 없습니다. 반드시 일반 레지스터를 거쳐서 대입해야 합니다.
 
---

### 17.[문제 / Question]
What will be the hexadecimal value of the destination operand after each of the following instructions execute in sequence?
(다음 명령어들이 순서대로 실행된 후, 목적지 피연산자(Destination Operand)의 16진수 값은 무엇입니까?)

**참고 변수 선언:**
* `var1 SBYTE -4,-2,3,1`

```assembly
mov  al,var1      ; a. AL = ?
mov  ah,[var1+3]  ; b. AH = ?
```

---

### [정답 / Answer]
* **a. `mov al, var1` 실행 후 AL의 값:** `FCh`
* **b. `mov ah, [var1+3]` 실행 후 AH의 값:** `01h`

---

### [풀이 및 설명 / Explanation]

`var1`은 **1바이트(SBYTE)** 크기의 부호 있는 정수 배열입니다. 각 요소의 위치(오프셋)와 16진수 변환 값은 다음과 같습니다.

* **`var1+0` (첫 번째 요소):** `-4` ➡️ 16진수로 **`FCh`** (2의 보수 표현)
* **`var1+1` (두 번째 요소):** `-2` ➡️ 16진수로 `FEh`
* **`var1+2` (세 번째 요소):** `3`  ➡️ 16진수로 `03h`
* **`var1+3` (네 번째 요소):** `1`  ➡️ 16진수로 **`01h`**

#### a. `mov al, var1`
* `var1` 배열의 첫 번째 값인 **`-4`**를 8비트 레지스터 `AL`에 복사합니다.
* `-4`를 8비트 2의 보수로 표현하면 `1111 1100b` = **`FCh`**가 됩니다.
* 따라서 **`AL = FCh`** 입니다.

#### b. `mov ah, [var1+3]`
* `var1` 시작 주소에서 3바이트 뒤에 있는 네 번째 요소의 값인 **`1`**을 `AH` 레지스터에 복사합니다.
* `1`을 16진수(8비트)로 표현하면 **`01h`**가 됩니다.
* 따라서 **`AH = 01h`** 입니다.

*(참고: 두 명령어 실행 후 16비트 레지스터 `AX` 전체의 값은 **`01FCh`**가 됩니다.)*


---

### 18.[문제 / Question]
What will be the value of the destination operand after each of the following instructions execute in sequence?
(다음 명령어들이 순서대로 실행된 후, 목적지 피연산자(AX)의 값은 무엇입니까?)

**참고 변수 선언:**
* `var1 SBYTE -4,-2,3,1` (4바이트)
* `var2 WORD 1000h,2000h,3000h,4000h` (8바이트)
* `var3 SWORD -16,-42` (4바이트)
* `var4 DWORD 1,2,3,4,5` (20바이트)

```assembly
mov  ax,var2      ; a. AX = ?
mov  ax,[var2+4]  ; b. AX = ?
mov  ax,var3      ; c. AX = ?
mov  ax,[var3-2]  ; d. AX = ?
```

---

### [정답 / Answer]
* **a. `mov ax, var2` 실행 후:** `1000h`
* **b. `mov ax, [var2+4]` 실행 후:** `3000h`
* **c. `mov ax, var3` 실행 후:** `FFF0h` (10진수로 -16)
* **d. `mov ax, [var3-2]` 실행 후:** `4000h`

---

### [풀이 및 설명 / Explanation]

#### a. `mov ax, var2`
* `var2`는 **WORD(2바이트)** 배열입니다.
* `var2`의 첫 번째 요소인 **`1000h`**가 `AX` 레지스터에 저장됩니다.
* **결과: `1000h`**

#### b. `mov ax, [var2+4]`
* `var2`는 2바이트 단위로 저장되어 있습니다.
  * `var2+0`: `1000h` (첫 번째 요소)
  * `var2+2`: `2000h` (두 번째 요소)
  * `var2+4`: `3000h` (세 번째 요소)
* 오프셋 `+4` 위치는 세 번째 요소인 **`3000h`**입니다.
* **결과: `3000h`**

#### c. `mov ax, var3`
* `var3`은 부호 있는 16비트 정수(`SWORD`) 배열입니다.
* 첫 번째 요소인 **`-16`**을 16비트 16진수(2의 보수)로 표현하면 **`FFF0h`**가 됩니다.
  * ($65536 - 16 = 65520 = \text{FFF0h}$)
* **결과: `FFF0h`**

#### d. `mov ax, [var3-2]`
* 메모리 배치상 `var3` 바로 앞에 `var2`가 정의되어 있습니다.
  * `var2`의 마지막 요소(`4000h`)는 `var2+6` 위치에 있으며, 이는 메모리상 **`var3`의 바로 앞(2바이트 전, `var3-2`)**입니다.
* 따라서 `var3-2` 위치의 값은 `var2` 배열의 마지막 값인 **`4000h`**가 됩니다.
* **결과: `4000h`**

---

### 19.[문제 / Question]
What will be the value of the destination operand after each of the following instructions execute in sequence?
(다음 명령어들이 순서대로 실행된 후, 목적지 피연산자(EDX)의 값은 무엇입니까?)

**참고 변수 선언:**
* `var1 SBYTE -4,-2,3,1` (1바이트)
* `var2 WORD 1000h,2000h,3000h,4000h` (2바이트)
* `var3 SWORD -16,-42` (2바이트)
* `var4 DWORD 1,2,3,4,5` (4바이트)

```assembly
mov    edx,var4      ; a. EDX = ?
movzx  edx,var2      ; b. EDX = ?
mov    edx,[var4+4]  ; c. EDX = ?
movsx  edx,var1      ; d. EDX = ?
```

---

### [정답 / Answer]
* **a. `mov edx, var4` 실행 후:** `00000001h` (1)
* **b. `movzx edx, var2` 실행 후:** `00001000h`
* **c. `mov edx, [var4+4]` 실행 후:** `00000002h` (2)
* **d. `movsx edx, var1` 실행 후:** `FFFFFFFCh` (10진수로 -4)

---

### [풀이 및 설명 / Explanation]

#### a. `mov edx, var4`
* `var4`는 **DWORD(4바이트, 32비트)** 배열입니다.
* `var4`의 첫 번째 요소인 **`1`**을 32비트 레지스터 `EDX`에 복사합니다.
* **결과: `00000001h`**

#### b. `movzx edx, var2`
* `MOVZX` (Zero-Extend) 명령어는 원본 데이터의 크기를 늘려 복사할 때 **상위 비트들을 `0`으로 채웁니다.**
* `var2`의 첫 번째 요소인 16비트 값 **`1000h`**를 가져와 상위 16비트를 `0`으로 채우고 `EDX`에 저합니다.
* **결과: `00001000h`**

#### c. `mov edx, [var4+4]`
* `var4`는 4바이트 크기의 요소들로 이루어져 있습니다.
  * `var4+0`: `1` (첫 번째 요소)
  * `var4+4`: `2` (두 번째 요소)
* 오프셋 `+4` 위치는 두 번째 요소인 **`2`**입니다.
* **결과: `00000002h`**

#### d. `movsx edx, var1`
* `MOVSX` (Sign-Extend) 명령어는 부호 있는 데이터를 확장할 때 **부호 비트(MSB)를 유지하도록 상위 비트들을 채웁니다.**
* `var1`의 첫 번째 요소는 **`-4`**이며, 8비트 16진수로 **`FCh`** (`1111 1100b`, 부호 비트 `1`)입니다.
* 부호 비트가 `1`(음수)이므로 상위 24비트를 모두 `1`(`F`)로 채워서 32비트로 확장합니다.
* **결과: `FFFFFFFCh`** (32비트 2의 보수로 표현된 -4)

---

### 1.[문제 / Question]
Write a sequence of MOV instructions that will exchange the upper and lower words in a doubleword variable named three.
(`three`라는 이름의 DWORD(32비트) 변수에서 상위 워드(Upper Word)와 하위 워드(Lower Word)의 위치를 `MOV` 명령어만 사용하여 서로 맞바꾸는 코드를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
; three 변수의 상위 워드와 하위 워드를 교환하는 MOV 명령어 시퀀스
mov ax, WORD PTR three          ; 하위 WORD(16비트)를 AX에 저장
mov bx, WORD PTR three + 2      ; 상위 WORD(16비트)를 BX에 저장
mov WORD PTR three, bx          ; 하위 WORD 위치에 기존 상위 WORD(BX) 복사
mov WORD PTR three + 2, ax      ; 상위 WORD 위치에 기존 하위 WORD(AX) 복사
```

---

### [풀이 및 설명 / Explanation]

#### 1. 개념 이해
* **DWORD(32비트) 변수 `three`의 구조:**
  * **하위 WORD (`three` 오프셋):** 하위 16비트
  * **상위 WORD (`three + 2` 오프셋):** 상위 16비트
* x86 아키텍처에서는 **메모리 간 직접 데이터 이동(`mov mem, mem`)이 불가능**하므로, 레지스터(`AX`, `BX` 등)를 임시 저장 공간으로 활용해야 합니다.

#### 2. 동작 과정 (예시: `three = 12345678h`)
1. **`mov ax, WORD PTR three`**
   * 하위 워드 값인 `5678h`를 `AX` 레지스터로 가져옵니다. (`AX = 5678h`)
2. **`mov bx, WORD PTR three + 2`**
   * 상위 워드 값인 `1234h`를 `BX` 레지스터로 가져옵니다. (`BX = 1234h`)
3. **`mov WORD PTR three, bx`**
   * `BX`에 보관해 둔 기존 상위 워드(`1234h`)를 하위 워드 위치(`three`)에 덮어씁니다.
4. **`mov WORD PTR three + 2, ax`**
   * `AX`에 보관해 둔 기존 하위 워드(`5678h`)를 상위 워드 위치(`three + 2`)에 덮어씁니다.

* **최종 결과:** `three` 메모리의 값이 `56781234h`로 바뀌어 상위/하위 워드가 성공적으로 교환됩니다.

---

### 2.[문제 / Question]
Using the XCHG instruction no more than three times, reorder the values in four 8-bit registers from the order A,B,C,D to B,C,D,A.
(8비트 레지스터 4개에 들어있는 값의 순서를 `A, B, C, D`에서 `B, C, D, A`로 바꾸는 코드를 `XCHG` 명령어를 **최대 3회 이하**만 사용하여 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
; 초기 상태: AL = A, BL = B, CL = C, DL = D
; 목표 상태: AL = B, BL = C, CL = D, DL = A

xchg al, bl      ; 1번째 교환: AL = B, BL = A
xchg bl, cl      ; 2번째 교환: BL = C, CL = A
xchg cl, dl      ; 3번째 교환: CL = D, DL = A
```

---

### [풀이 및 단계별 추적 / Explanation & Trace]

편의상 8비트 레지스터 4개를 **`AL`, `BL`, `CL`, `DL`**로 지정하고, 각각의 초기값을 `A, B, C, D`라고 정의합니다.

#### 단계별 레지스터 값 변화 (Trace)

| 실행 단계 | 명령어 | AL | BL | CL | DL | 설명 |
| :---: | :--- | :---: | :---: | :---: | :---: | :--- |
| **초기 상태** | - | **A** | **B** | **C** | **D** | 원래 순서 |
| **1단계** | `xchg al, bl` | **B** | **A** | C | D | `AL`과 `BL`의 값을 교환함 |
| **2단계** | `xchg bl, cl` | B | **C** | **A** | D | `BL`과 `CL`의 값을 교환함 |
| **3단계** | `xchg cl, dl` | B | C | **D** | **A** | `CL`과 `DL`의 값을 교환함 |

#### 💡 수학적 원리 (왜 3번이 최소일까?)
4개 요소의 순서를 한 칸씩 왼쪽으로 회전(Cyclic Shift)시키는 이항 교환(Transposition)은 **수학적으로 최소 3번의 교환($N-1$번)**이 필요합니다.

---


### 3.[문제 / Question]
Transmitted messages often include a parity bit whose value is combined with a data byte to produce an even number of 1 bits. Suppose a message byte in the AL register contains 01110101. Show how you could use the Parity flag combined with an arithmetic instruction to determine if this message byte has even or odd parity.

(전송되는 메시지는 1 비트의 개수를 짝수로 만들기 위해 패리티 비트를 포함하곤 합니다. `AL` 레지스터에 `01110101` 값이 들어있다고 가정할 때, 산술 명령어(Arithmetic Instruction)와 패리티 플래그(Parity Flag)를 조합하여 이 메시지 바이트가 짝수 패리티인지 홀수 패리티인지 확인하는 방법을 설명하고 코드를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov al, 01110101b    ; AL = 01110101b (1의 개수: 5개 = 홀수)

add al, 0            ; AL 값 변경 없이 산술 연산을 수행하여 플래그(PF) 갱신
jp  IsEven           ; PF = 1 이면 (짝수 패리티) IsEven으로 분기
jnp IsOdd            ; PF = 0 이면 (홀수 패리티) IsOdd로 분기
```

---

### [풀이 및 설명 / Explanation]

#### 1. x86 패리티 플래그(PF, Parity Flag)의 동작 원리
x86 CPU에서 패리티 플래그(PF)는 연산 결과 **하위 8비트에 포함된 `1` 비트의 개수**에 따라 다음과 같이 설정됩니다.
* **`PF = 1` (Set):** `1` 비트의 개수가 **짝수(Even)**개일 때
* **`PF = 0` (Clear):** `1` 비트의 개수가 **홀수(Odd)**개일 때

#### 2. 문제 적용 및 단계별 분석 (`AL = 01110101b`)
1. **`AL`의 비트 분석:**
   * `01110101b` 내의 `1`의 개수를 세어보면 총 **5개**입니다.
   * 5는 **홀수(Odd)**입니다.

2. **산술 명령어 실행 (`add al, 0`):**
   * `AL`에 `0`을 더하는 산술 연산을 수행하면 `AL`의 값 자체는 유지되면서 **패리티 플래그(PF)가 갱신**됩니다.
   * 결과값의 `1`의 개수가 5개(홀수)이므로 CPU는 **`PF = 0`**으로 설정합니다.

3. **조건문 분기 명령어로 확인:**
   * **`JP` (Jump if Parity / Even):** `PF = 1`일 때 이동
   * **`JNP` (Jump if No Parity / Odd):** `PF = 0`일 때 이동
   * 현재 `PF = 0`이므로 `JNP IsOdd` 조건이 만족되어 **홀수 패리티(Odd Parity)**임을 판별할 수 있습니다.
따라서 단 3번의 `XCHG` 명령어 사용으로 요구사항을 완벽히 만족할 수 있습니다.

---

### 4.[문제 / Question]
Write code using byte operands that adds two negative integers and causes the Overflow flag to be set.
(바이트(Byte, 8비트) 피연산자를 사용하여, 두 음수를 더했을 때 오버플로우 플래그(Overflow Flag)가 1로 설정되는 어셈블리 코드를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov al, -100        ; AL = -100 (8비트 16진수: 9Ch)
add al, -50         ; AL = -100 + (-50) = -150 -> 오버플로우 발생 (OF = 1)
```

---

### [풀이 및 설명 / Explanation]

#### 1. 바이트(8비트) 부호 있는 정수의 표현 범위
* 8비트 부호 있는 정수(Signed Byte)의 표현 범위는 **$-128$ ~ $+127$**입니다.
* 연산 결과가 이 범위를 벗어나면 **오버플로우 플래그(OF = 1)**가 설정됩니다.

#### 2. 예시 코드 분석
* 첫 번째 음수: **$-100$** (16진수 `9Ch`)
* 두 번째 음수: **$-50$** (16진수 `CEh`)
* 두 음수의 합: **$-100 + (-50) = -150$**

#### 3. 오버플로우가 발생하는 이유
1. 수학적 계산 결과는 **$-150$**이지만, 8비트가 표현할 수 있는 최솟값인 **$-128$보다 작습니다.**
2. 실제로 CPU에서 8비트 이진수 연산을 수행하면:
   * `9Ch` (`1001 1100b`) + `CEh` (`1100 1110b`) = `1 0110 1010b`
   * 8비트 레지스터 `AL`에는 하위 8비트인 **`0110 1010b` (`6Ah`, 10진수로 $+106$)**만 남게 됩니다.
3. **두 음수를 더했는데 결과가 양수($+106$)가 되는 모순**이 발생하므로, CPU는 잘못된 부호 연산임을 알리기 위해 **오버플로우 플래그를 `1`로 설정(`OF = 1`)**합니다.

---


### 5.[문제 / Question]
Write a sequence of two instructions that use addition to set the Zero and Carry flags at the same time.
(덧셈 연산을 사용하여 제로 플래그(Zero Flag)와 캐리 플래그(Carry Flag)가 동시에 1로 설정되도록 만드는 2줄의 명령어 시퀀스를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov al, 0FFh        ; AL 레지스터에 8비트 최댓값(255) 대입
add al, 1           ; AL = 0FFh + 1 = 100h -> AL에는 00h 저장, CF = 1, ZF = 1
```

---

### [풀이 및 설명 / Explanation]

#### 1. 두 플래그의 설정 조건
* **제로 플래그 (Zero Flag, ZF = 1):** 연산의 결과가 **`0`**일 때 설정됩니다.
* **캐리 플래그 (Carry Flag, CF = 1):** 부호 없는 정수 연산에서 **최상위 비트(MSB)를 넘어서는 자림올림(Carry)이 발생**했을 때 설정됩니다.

#### 2. 동작 과정 상세 분석 (`AL` 기준, 8비트)
1. **`mov al, 0FFh`**
   * `AL` 레지스터에 8비트 부호 없는 정수 최댓값인 **`FFh` (10진수 255)**를 넣어줍니다.

2. **`add al, 1`**
   * `FFh` (255)에 `1`을 더하면 결과는 **`100h` (256)**가 됩니다.
   * `AL`은 8비트 저장 공간이므로 하위 8비트인 **`00h`만 남게 됩니다.**
   * 최상위 비트(9번째 비트)인 `1`은 8비트 범위를 벗어났으므로 **자림올림(Carry)**으로 처리됩니다.

#### 3. 결과
* 결과값이 `00h`이므로 **`ZF = 1`** (Zero Flag Set)
* 범위를 넘어서는 올림수가 발생했으므로 **`CF = 1`** (Carry Flag Set)

따라서 단 2줄의 명령어만으로 제로 플래그와 캐리 플래그를 동시에 `1`로 만들 수 있습니다.

---

### 6.[문제 / Question]
Write a sequence of two instructions that set the Carry flag using subtraction.
(뺄셈 연산을 사용하여 캐리 플래그(Carry Flag)가 1로 설정되도록 만드는 2줄의 명령어 시퀀스를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov al, 1           ; AL 레지스터에 1 대입
sub al, 2           ; AL = 1 - 2 -> 작은 수에서 큰 수를 빼므로 빌림(Borrow) 발생 (CF = 1)
```

---

### [풀이 및 설명 / Explanation]

#### 1. 뺄셈 연산에서 캐리 플래그(CF)의 의미
* 뺄셈(`SUB`) 연산에서 캐리 플래그(CF)는 **빌림(Borrow) 플래그**의 역할을 합니다.
* **작은 수에서 큰 수를 뺄 때** 저장 공간이 부족하므로 외부에서 값을 빌려와야 하고, 이 때 **`CF = 1`**이 됩니다.

#### 2. 동작 과정 상세 분석
1. **`mov al, 1`**
   * `AL` 레지스터에 피연산자 **`1`**을 넣습니다.

2. **`sub al, 2`**
   * `1 - 2` 연산을 수행합니다.
   * 부호 없는 정수(Unsigned) 관점에서 `1`은 `2`보다 작기 때문에 **빌림(Borrow)이 발생**합니다.
   * 이에 따라 CPU는 **`CF = 1`**로 설정합니다.

*(참고: `mov al, 0` 후에 `sub al, 1`을 수행해도 동일하게 `CF = 1`이 됩니다.)*

---

### 7.[문제 / Question]
Implement the following arithmetic expression in assembly language:
$$\text{EAX} = -\text{val2} + 7 - \text{val3} + \text{val1}$$
Assume that `val1`, `val2`, and `val3` are 32-bit integer variables.

(`val1`, `val2`, `val3`가 32비트 정수 변수일 때, 수식 $\text{EAX} = -\text{val2} + 7 - \text{val3} + \text{val1}$ 을 어셈블리 언어로 구현하시오.)

---

### [정답 코드 / Solution]

```assembly
mov eax, val2       ; EAX = val2
neg eax             ; EAX = -val2 (부호 반전)
add eax, 7          ; EAX = -val2 + 7
sub eax, val3       ; EAX = -val2 + 7 - val3
add eax, val1       ; EAX = -val2 + 7 - val3 + val1
```

---

### [풀이 및 단계별 설명 / Explanation]

32비트 변수 간의 연산이므로 32비트 범용 레지스터인 `EAX`를 사용하여 순차적으로 연산을 수행합니다.

1. **`mov eax, val2`**
   * `val2`의 값을 `EAX` 레지스터로 읽어옵니다.

2. **`neg eax`**
   * `NEG` 명령어를 사용하여 `EAX`에 들어있는 값의 부호를 반전시킵니다. (`EAX = -val2`)

3. **`add eax, 7`**
   * `EAX`에 상수 `7`을 더합니다. (`EAX = -val2 + 7`)

4. **`sub eax, val3`**
   * `EAX`에서 `val3`의 값을 뺍니다. (`EAX = -val2 + 7 - val3`)

5. **`add eax, val1`**
   * `EAX`에 `val1`의 값을 더하여 최종 수식을 완성합니다. (`EAX = -val2 + 7 - val3 + val1`)

    ---

 ### 8.[문제 / Question]
Write a loop that iterates through a doubleword array and calculates the sum of its elements using a scale factor with indexed addressing.

(인덱스 지정 방식에 비율 인자(Scale Factor)를 사용하여, 더블워드(DWORD, 4바이트) 배열의 모든 요소를 순회하고 그 합을 계산하는 루프 코드를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
.data
array DWORD 10, 20, 30, 40, 50        ; 샘플 DWORD 배열
ARRAY_SIZE = ($ - array) / TYPE array ; 배열의 요소 개수 (5)

.code
mov esi, 0              ; 인덱스 레지스터(ESI) 0으로 초기화
mov ecx, ARRAY_SIZE     ; 루프 카운터(ECX)에 배열 크기 설정
mov eax, 0              ; 합계를 저장할 레지스터(EAX) 0으로 초기화

L1:
    add eax, array[esi * 4]   ; 비율 인자(*4)를 사용한 인덱스 주소 지정
    inc esi                   ; 인덱스 1 증가 (0, 1, 2, 3, 4)
    loop L1                   ; ECX가 0이 될 때까지 반복
```

---

### [풀이 및 단계별 설명 / Explanation]

#### 1. 비율 인자(Scale Factor)를 활용한 인덱스 주소 지정
* **DWORD(더블워드)** 타입은 요소 1개당 **4바이트**의 메모리 크기를 가집니다.
* `array[esi * 4]` 방식(또는 `[array + esi * 4]`)은 인덱스 레지스터 `ESI`가 `0, 1, 2, 3...`으로 1씩 증가하더라도, 비율 인자 `* 4`를 곱해줌으로써 자동으로 4바이트 단위(`0, 4, 8, 12...` 오프셋) 메모리 주소를 찾아갑니다.

#### 2. 코드 동작 과정
1. **초기화:**
   * `mov esi, 0`: 배열의 첫 번째 인덱스(`0`)부터 시작합니다.
   * `mov ecx, ARRAY_SIZE`: `LOOP` 명령어에 사용할 반복 횟수를 `ECX`에 저장합니다.
   * `mov eax, 0`: 합계를 누적할 `EAX` 레지스터를 `0`으로 비웁니다.

2. **루프 수행 (`L1`):**
   * **1회차 (`esi = 0`):** `array[0 * 4]` = `array[0]` (10) ➔ `EAX`에 추가
   * **2회차 (`esi = 1`):** `array[1 * 4]` = `array[4]` (20) ➔ `EAX`에 추가
   * **3회차 (`esi = 2`):** `array[2 * 4]` = `array[8]` (30) ➔ `EAX`에 추가
   * ...
   * `loop L1` 명령어가 실행될 때마다 `ECX`가 1씩 차감되며, `ECX = 0`이 되면 루프가 종료됩니다.

3. **최종 결과:** `EAX` 레지스터에 배열 요소들의 총합이 저장됩니다.


---

### 9.[문제 / Question]
Implement the following expression in assembly language:
$$\text{AX} = (\text{val2} + \text{BX}) - \text{val4}$$
Assume that `val2` and `val4` are 16-bit integer variables.

(`val2`와 `val4`가 16비트 정수 변수일 때, 수식 $\text{AX} = (\text{val2} + \text{BX}) - \text{val4}$ 를 어셈블리 언어로 구현하시오.)

---

### [정답 코드 / Solution]

```assembly
mov ax, val2        ; AX = val2
add ax, bx          ; AX = val2 + BX
sub ax, val4        ; AX = (val2 + BX) - val4
```

---

### [풀이 및 단계별 설명 / Explanation]

16비트 변수(`WORD`)와 16비트 레지스터 간의 연산이므로 16비트 레지스터인 `AX`를 목적지(Destination) 레지스터로 활용합니다.

1. **`mov ax, val2`**
   * 16비트 변수인 `val2`의 값을 `AX` 레지스터로 복사합니다.

2. **`add ax, bx`**
   * `AX`에 `BX` 레지스터의 값을 더합니다.
   * 이 단계까지 실행되면 `AX = val2 + BX`가 됩니다.

3. **`sub ax, val4`**
   * `AX`에서 16비트 변수인 `val4`의 값을 뺍니다.
   * 최종적으로 `AX = (val2 + BX) - val4`의 계산 결과가 `AX` 레지스터에 저장됩니다.
  
---


### 10.[문제 / Question]
Write a sequence of two instructions that set both the Carry and Overflow flags at the same time.
(캐리 플래그(Carry Flag)와 오버플로우 플래그(Overflow Flag)가 동시에 1로 설정되도록 만드는 2줄의 명령어 시퀀스를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov al, 80h         ; AL = 80h (10진수로 -128 또는 128)
add al, 80h         ; AL = 80h + 80h = 100h -> AL에는 00h 저장, CF = 1, OF = 1
```

---

### [풀이 및 설명 / Explanation]

#### 1. 각 플래그의 발생 조건 (8비트 기준)
* **캐리 플래그 (Carry Flag, CF = 1):** 부호 없는 정수(Unsigned) 연산에서 범위를 초과하여 최상위 비트 밖으로 자림올림(Carry)이 발생할 때 ($0 \sim 255$ 범위 초과)
* **오버플로우 플래그 (Overflow Flag, OF = 1):** 부호 있는 정수(Signed) 연산에서 표현 가능한 범위를 초과하여 잘못된 부호의 결과가 나올 때 ($-128 \sim +127$ 범위 초과)

#### 2. 동작 과정 상세 분석
1. **`mov al, 80h`**
   * `AL` 레지스터에 `80h` (`1000 0000b`)를 대입합니다.
   * 부호 없는 정수로 해석하면 **$128$**, 부호 있는 정수로 해석하면 **$-128$**입니다.

2. **`add al, 80h`**
   * `80h + 80h` 연산을 수행합니다.
   * **부호 없는 정수 관점 (CF 검사):**
     * $128 + 128 = 256$이 되며, 8비트 최대 범위인 $255$를 초과합니다.
     * 9번째 비트로 올림수가 넘어가므로 **`CF = 1`**이 됩니다.
   * **부호 있는 정수 관점 (OF 검사):**
     * $(-128) + (-128) = -256$이 되며, 8비트 최솟값인 $-128$보다 작습니다.
     * 두 음수를 더했는데 연산 결과는 `00h` (양수)가 되는 모순이 발생하므로 **`OF = 1`**이 됩니다.

#### 3. 최종 결과
단 2줄의 명령어만으로 **`CF = 1`**과 **`OF = 1`**을 동시에 설정할 수 있습니다.

---

### 11.[문제 / Question]
Write a sequence of instructions showing how the Zero flag could be used to indicate unsigned overflow after executing INC and DEC instructions.

Use the following data definitions for Questions 12–18:
```assembly
.data
myBytes  BYTE 10h,20h,30h,40h
myWords  WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

(11번 문제: `INC` 및 `DEC` 명령어를 실행한 후, 무부호 오버플로우(Unsigned Overflow/Underflow)가 발생했음을 감지하기 위해 제로 플래그(Zero Flag, ZF)를 활용하는 어셈블리 코드를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
; --- 1. INC 명령어 실행 후 오버플로우 감지 ---
mov al, 0FFh        ; 8비트 무부호 최댓값(255) 대입
inc al              ; AL = 00h (결과가 0이 되면서 ZF = 1 설정됨)
jz  IncOverflow     ; ZF = 1 이면 오버플로우 발생으로 판단하여 분기

; --- 2. DEC 명령어 실행 전/후 언더플로우(오버플로우) 감지 ---
mov al, 00h         ; 8비트 무부호 최솟값(0) 대입
cmp al, 0           ; AL이 0인지 확인하여 ZF = 1 설정
jz  DecUnderflow    ; ZF = 1 이면 DEC 수행 시 언더플로우가 발생할 것임을 감지
dec al              ; AL = 0FFh (DEC 수행)
```

---

### [풀이 및 설명 / Explanation]

#### 1. INC/DEC 명령어와 플래그의 특성
* x86 아키텍처에서 `INC`와 `DEC` 명령어는 **캐리 플래그(Carry Flag, CF)에 영향을 주지 않습니다.**
* 따라서 무부호 정수 연산 시 오버플로우/언더플로우를 확인하려면 **제로 플래그(Zero Flag, ZF)**를 활용해야 합니다.

#### 2. INC 명령어에서의 제로 플래그(ZF) 활용
* **상황:** 8비트 무부호 정수의 최댓값인 `0FFh` (255)에 `1`을 더하면 `00h`가 됩니다 (순환 오버플로우).
* **원리:** 연산 결과가 `00h`가 되었으므로 CPU는 **`ZF = 1`**로 설정합니다.
* **판단:** `INC` 실행 직후 `ZF = 1`이면(또는 `JZ` 명령어 사용 시) **오버플로우가 발생함**을 알 수 있습니다.

#### 3. DEC 명령어에서의 제로 플래그(ZF) 활용
* **상황:** 8비트 무부호 정수의 최솟값인 `00h` (0)에서 `1`을 빼면 `0FFh` (255)가 됩니다 (순환 언더플로우).
* **원리:** `00h`에서 `DEC`를 수행하면 결과가 `0FFh`가 되므로, 수행 *직후*에는 `ZF = 0`이 됩니다.
* **판단:** 따라서 `DEC`를 수행하기 **직전의 값이 `0`인지(`ZF = 1`) 검사**하거나, `DEC` 연산 전 상태를 제로 플래그로 확인하여 언더플로우(오버플로우) 발생을 미리 감지할 수 있습니다.

---


### 12.[문제 / Question]
Insert a directive in the given data that aligns `myBytes` to an even-numbered address.

(제시된 데이터 정의에서 `myBytes`가 짝수번지 메모리 주소(Even-numbered address)에 정렬되도록 지시어(Directive)를 삽입하시오.)

---

### [정답 코드 / Solution]

```assembly
.data
ALIGN 2                  ; myBytes를 짝수(2바이트) 경계 주소로 정렬 (또는 EVEN 지시어 사용)
myBytes  BYTE 10h,20h,30h,40h
myWords  WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

*(참고: `ALIGN 2` 대신 **`EVEN`** 지시어를 사용해도 동일한 정답입니다.)*

---

### [풀이 및 설명 / Explanation]

#### 1. 메모리 정렬 지시어 (ALIGN / EVEN)
* **`ALIGN n`**: 다음에 선언될 데이터의 시작 메모리 주소를 $n$바이트의 배수 주소에 맞추도록 메모리를 정렬합니다.
* **`EVEN`**: 다음에 선언될 데이터의 시작 주소를 **짝수(2의 배수) 주소**로 정렬합니다. (`ALIGN 2`와 완전히 동일합니다.)

#### 2. 적용 이유
* CPU가 메모리에서 데이터를 읽어올 때, 데이터를 짝수 번지(2바이트 경계)나 4의 배수 번지(4바이트 경계)에 맞추어 배치하면 **메모리 접근 속도와 연산 효율이 향상**됩니다.
* `myBytes` 선언 바로 위에 `ALIGN 2` (또는 `EVEN`) 지시어를 추가하면, 컴파일러가 필요 시 패딩(Padding) 바이트를 채워 `myBytes`의 시작 주소를 짝수 번지로 맞춰줍니다.

---

### 13.[문제 / Question]
What will be the value of EAX after each of the following instructions execute?

(다음 데이터 정의를 바탕으로 각 명령어가 실행된 후 `EAX` 레지스터에 저장되는 값을 구하시오.)

**[참고 데이터 정의]**
```assembly
.data
myBytes  BYTE 10h,20h,30h,40h
myWords  WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

```assembly
mov eax, TYPE myBytes       ; a.
mov eax, LENGTHOF myBytes   ; b.
mov eax, SIZEOF myBytes     ; c.
mov eax, TYPE myWords       ; d.
mov eax, LENGTHOF myWords   ; e.
mov eax, SIZEOF myWords     ; f.
mov eax, SIZEOF myString    ; g.
```

---

### [정답 / Solution]

| 기호 | 명령어 | EAX 값 (10진수 / 16진수) |
| :---: | :--- | :--- |
| **a.** | `mov eax, TYPE myBytes` | **`1`** (`00000001h`) |
| **b.** | `mov eax, LENGTHOF myBytes` | **`4`** (`00000004h`) |
| **c.** | `mov eax, SIZEOF myBytes` | **`4`** (`00000004h`) |
| **d.** | `mov eax, TYPE myWords` | **`2`** (`00000002h`) |
| **e.** | `mov eax, LENGTHOF myWords` | **`4`** (`00000004h`) |
| **f.** | `mov eax, SIZEOF myWords` | **`8`** (`00000008h`) |
| **g.** | `mov eax, SIZEOF myString` | **`5`** (`00000005h`) |

---

### [풀이 및 연산자 개념 설명 / Explanation]

#### 1. 연산자 개념 정리
* **`TYPE`**: 데이터 타입의 크기를 바이트 단위로 반환합니다.
  * `BYTE` = 1바이트, `WORD` = 2바이트, `DWORD` = 4바이트
* **`LENGTHOF`**: 배열에 정의된 전체 **요소(Element)의 개수**를 반환합니다.
* **`SIZEOF`**: 배열이 차지하는 **전체 메모리 크기(바이트)**를 반환합니다. ($SIZEOF = LENGTHOF \times TYPE$)

---

#### 2. 항목별 세부 풀이

* **a. `TYPE myBytes` ➔ `1`**
  * `BYTE` 타입이므로 요소 1개의 크기는 **1바이트**입니다.

* **b. `LENGTHOF myBytes` ➔ `4`**
  * `10h, 20h, 30h, 40h` 총 **4개**의 요소가 선언되었습니다.

* **c. `SIZEOF myBytes` ➔ `4`**
  * $LENGTHOF(4) \times TYPE(1) = 4$바이트입니다.

* **d. `TYPE myWords` ➔ `2`**
  * `WORD` 타입이므로 요소 1개의 크기는 **2바이트**입니다.

* **e. `LENGTHOF myWords` ➔ `4`**
  * `3 DUP(?)` (3개) + `2000h` (1개) = 총 **4개**의 요소로 구성되어 있습니다.

* **f. `SIZEOF myWords` ➔ `8`**
  * $LENGTHOF(4) \times TYPE(2) = 8$바이트입니다.

* **g. `SIZEOF myString` ➔ `5`**
  * `"ABCDE"` 문자열은 `BYTE` 타입 5개로 구성되어 있으므로 $5 \times 1 = 5$바이트입니다.
 
---


### 14.[문제 / Question]
Write a single instruction that moves the first two bytes in `myBytes` to the `DX` register. The resulting value will be `2010h`.

Use the following data definition:
```assembly
myBytes BYTE 10h, 20h, 30h, 40h
```

(`myBytes` 배열의 첫 두 바이트를 `DX` 레지스터로 이동시켜 `2010h`가 되도록 만드는 단 하나의 어셈블리 명령어를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov dx, WORD PTR myBytes
```

---

### [풀이 및 설명 / Explanation]

#### 1. 타입 재정의 (PTR 연산자)
* `myBytes`는 원래 **`BYTE` (1바이트)** 타입으로 선언되어 있습니다.
* `DX`는 **16비트 (2바이트)** 레지스터이므로, `BYTE` 타입의 데이터를 직접 복사하려 하면 데이터 타입 불일치 에러가 발생합니다.
* 따라서 **`WORD PTR`** 연산자를 사용하여 `myBytes`의 시작 주소부터 2바이트(`WORD`) 만큼을 읽어오도록 지시해야 합니다.

#### 2. 리틀 엔디언(Little-Endian) 저장 방식
* x86 아키텍처는 메모리에 바이트를 저장할 때 하위 바이트를 낮은 주소에 저장하는 **리틀 엔디언** 방식을 사용합니다.
* 메모리 주소 순서: `[myBytes]` = `10h`, `[myBytes + 1]` = `20h`
* `WORD PTR myBytes`로 2바이트를 읽어 16비트 레지스터 `DX`에 로드하면:
  * 하위 8비트 레지스터 (`DL`): 낮은 주소의 값인 **`10h`**
  * 상위 8비트 레지스터 (`DH`): 높은 주소의 값인 **`20h`**
* 결과적으로 `DX` (`DH` + `DL`) 레지스터에는 **`2010h`**가 저장됩니다.

---

### 15.[문제 / Question]
Write an instruction that moves the second byte in `myWords` to the `AL` register.

Use the following data definition:
```assembly
myWords WORD 3 DUP(?), 2000h
```

(`myWords` 배열의 두 번째 바이트(2nd byte)를 `AL` 레지스터로 이동시키는 단 하나의 어셈블리 명령어를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov al, BYTE PTR [myWords + 1]
```
*(또는 `mov al, BYTE PTR myWords[1]` 라 써도 정답입니다.)*

---

### [풀이 및 설명 / Explanation]

#### 1. 바이트 오프셋(Byte Offset) 계산
* 배열의 첫 번째 바이트 오프셋: `myWords + 0` (1st byte)
* 배열의 두 번째 바이트 오프셋: **`myWords + 1`** (2nd byte)

#### 2. 타입 캐스팅 (`BYTE PTR`)
* `myWords` 변수는 원래 **`WORD` (2바이트)** 타입으로 정의되어 있습니다.
* 목적지 레지스터인 `AL`은 **8비트(1바이트)** 레지스터이므로, `WORD` 변수를 직접 대입하려고 하면 크기 불일치 오류가 발생합니다.
* 따라서 **`BYTE PTR`** 연산자를 사용하여 `myWords + 1` 번지의 데이터를 **1바이트 단위로 재정의**하여 `AL` 레지스터로 읽어오도록 처리합니다.


### 16.[문제 / Question]
Write an instruction that moves all four bytes in `myBytes` to the `EAX` register.

Use the following data definition:
```assembly
myBytes BYTE 10h, 20h, 30h, 40h
```

(`myBytes` 배열의 전체 4바이트 데이터를 `EAX` 레지스터로 이동시키는 단 하나의 어셈블리 명령어를 작성하시오.)

---

### [정답 코드 / Solution]

```assembly
mov eax, DWORD PTR myBytes
```

---

### [풀이 및 설명 / Explanation]

#### 1. 타입 캐스팅 (`DWORD PTR`)
* `myBytes`는 originalmente **`BYTE` (1바이트)** 타입의 배열로 정의되어 있습니다.
* `EAX`는 **32비트 (4바이트)** 레지스터입니다.
* `myBytes`의 시작 위치부터 연속된 4바이트 전체를 한 번에 `EAX`로 읽어오기 위해 **`DWORD PTR`** 연산자를 사용하여 메모리 크기를 4바이트(`DWORD`)로 재정의해 줍니다.

#### 2. 메모리 상의 값 저장 결과 (리틀 엔디언)
* `myBytes` 배열 메모리 상태: `10h` (0번지), `20h` (1번지), `30h` (2번지), `40h` (3번지)
* x86 시스템의 리틀 엔디언(Little-Endian) 방식에 의해 `EAX` 레지스터에는 **`40302010h`**의 값으로 복사됩니다.

---

### 17.[문제 / Question]
Insert a `LABEL` directive in the given data that permits `myWords` to be moved directly to a 32-bit register.

Use the following data definitions:
```assembly
.data
myBytes  BYTE 10h,20h,30h,40h
myWords  WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

(`myWords`의 데이터를 `PTR` 연산자 없이 32비트 레지스터로 직접 이동(복사)할 수 있도록 만들기 위해 `LABEL` 지시어를 삽입하시오.)

---

### [정답 코드 / Solution]

```assembly
.data
myBytes   BYTE 10h,20h,30h,40h
myWordsD  LABEL DWORD           ; 32비트(DWORD) 크기의 라벨 선언
myWords   WORD 3 DUP(?),2000h
myString  BYTE "ABCDE"
```

*(참고: 라벨 이름 `myWordsD`는 `myWordsDword` 등 임의의 유효한 식별자로 지정할 수 있습니다.)*

---

### [풀이 및 활용 설명 / Explanation]

#### 1. `LABEL` 지시어의 역할
* **`LABEL`** 지시어는 **새로운 메모리 공간을 할당하지 않고**, 기존에 정의된 메모리 위치에 **새로운 속성(타입과 이름)의 별칭**을 부여할 때 사용합니다.

#### 2. 문제 적용 및 활용
* `myWords`는 원래 `WORD` (16비트) 타입이므로, `mov eax, myWords` 처럼 32비트 레지스터에 직접 대입하려고 하면 크기 불일치 오류가 발생합니다.
* 바로 위에 **`myWordsD LABEL DWORD`**를 선언해 두면, 동일한 메모리 시작 주소를 **`DWORD` (32비트)** 속성으로 참조할 수 있게 됩니다.
* **사용 예시:**
  ```assembly
  mov eax, myWordsD    ; PTR 연산자(DWORD PTR) 없이 32비트 레지스터로 직접 이동 가능!


### 18.[문제 / Question]
Insert a `LABEL` directive in the given data that permits `myBytes` to be moved directly to a 16-bit register.

Use the following data definitions:
```assembly
.data
myBytes  BYTE 10h,20h,30h,40h
myWords  WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

(`myBytes`의 데이터를 `PTR` 연산자 없이 16비트 레지스터로 직접 이동(복사)할 수 있도록 만들기 위해 `LABEL` 지시어를 삽입하시오.)

---

### [정답 코드 / Solution]

```assembly
.data
myBytesW LABEL WORD            ; 16비트(WORD) 크기의 라벨 선언
myBytes  BYTE 10h,20h,30h,40h
myWords  WORD 3 DUP(?),2000h
myString BYTE "ABCDE"
```

*(참고: 라벨 이름 `myBytesW`는 `myBytesWord` 등 임의의 유효한 식별자로 지정할 수 있습니다.)*

---

### [풀이 및 활용 설명 / Explanation]

#### 1. `LABEL` 지시어의 역할
* **`LABEL`** 지시어는 별도의 추가 메모리를 소비하지 않고, 기존 데이터 선언 위치에 **새로운 속성(타입)을 가진 식별자(이름)**를 붙여주는 기능을 합니다.

#### 2. 문제 적용 및 활용
* `myBytes`는 원래 `BYTE` (8비트) 타입이므로 `AX`, `BX`, `DX` 등 **16비트 레지스터**로 값을 직접 이동하려면 `WORD PTR` 키워드가 필요합니다.
* 하지만 `myBytes` 선언 직전에 **`myBytesW LABEL WORD`**를 추가하면, 해당 메모리 위치를 **`WORD` (16비트)** 타입의 변수처럼 직접 다룰 수 있게 됩니다.
* **사용 예시:**
  ```assembly
  mov ax, myBytesW    ; PTR 연산자 없이 16비트 레지스터(AX)로 직접 이동 가능! (AX에는 2010h가 저장됨)
  ```
  ```
