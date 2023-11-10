```section .data
    ms1:     
    db 'ENROLLMENT SYSTEM',10, 
    db 'Programmer: Elijah Rei B. Sabay', 10, 10
	ms1len:  equ $-ms1   
    ms2: db "Input 1ST Year Students Quantity: "
    ms2len: equ $-ms2
    ms3: db "Input 2nd Year Students Quantity:  "
    ms3len: equ $-ms3
    ms4: db "Total Students: "
    ms4len: equ $-ms4

section .bss
    num1 resb 4
    num2 resb 4
    res resb 4
    buffer1 resb 16
    buffer2 resb 16
    buffer3 resb 16

 

 

section .text
    global _start
_start:
    call _writehello
    call _writeMsg1
    call _readNum1
    call _writeMsg2
    call _readNum2
    call _addNums
    call _writeMsg3
    call _writeRes
    call _exit


_writehello:
    mov eax, 4  
    mov ebx, 1 
    mov ecx, ms1
    mov edx, ms1len 
    int 80h 
    ret

 

 

_writeMsg1:
    mov eax, 4
    mov ebx, 1
    mov ecx, ms2
    mov edx, ms2len
    int 80h
    ret

 

_readNum1:
    mov eax, 3
    mov ebx, 0
    lea ecx, [buffer1]
    mov edx, 16
    int 80h

 

    xor eax, eax
    lea esi, [buffer1]
    convert1:
        movzx edx, byte [esi]
        cmp dl, 10
        je done1
        sub edx, '0'
        imul eax, 10
        add eax, edx
        inc esi
        jmp convert1
    done1:
        mov edi, num1
        mov [edi], eax
        ret
_writeMsg2:
    mov eax, 4
    mov ebx, 1
    mov ecx, ms3
    mov edx, ms3len
    int 80h
    ret

 

_readNum2:
    mov eax, 3
    mov ebx, 0
    lea ecx, [buffer2]
    mov edx, 16
    int 80h

 

    xor eax, eax
    lea esi, [buffer2]
    convert2:
        movzx edx, byte [esi]
        cmp dl, 10
        je done2
        sub edx, '0'
        imul eax, 10
        add eax, edx
        inc esi
        jmp convert2
    done2:
        mov edi, num2
        mov [edi], eax
    ret
_addNums:
    mov eax, [num1]
    mov ebx, [num2]
    add eax, ebx
    mov [res], eax
    ret

 

_writeMsg3:
    mov eax, 4
    mov ebx, 1
    mov ecx, ms4
    mov edx, ms4len
    int 80h
    ret

 

_writeRes:
    mov eax, [res]
    lea edi, [buffer3+15]
    mov byte [edi], 10
    convert3:
        dec edi
        xor edx, edx
        mov ecx, 10
        div ecx
        add dl, '0'
        mov [edi], dl
        test eax, eax
        jnz convert3
    mov eax, 4
    mov ebx, 1
    lea ecx, [edi]
    lea edx, [buffer3+16]
    sub edx, ecx
    int 80h
    ret

 

_exit:
    mov eax, 1
    mov ebx, 0
    int 80h
    ret

```