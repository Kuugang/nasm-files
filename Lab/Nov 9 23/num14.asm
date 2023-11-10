section .data
    headerLine db " ", 10, "Input a number: "
    headerLineLen equ $-headerLine

    choiceLine db "", 10, "Again? Y/N: "
    choiceLineLen equ $-choiceLine

    thankYou db "Thank you."
    thankYouLen equ $-thankYou

    geaterOrEqualLine db " ", 10, "The number is equal to or greater than than 10"
    geaterOrEqualLineLen equ $-geaterOrEqualLine
    lessThanLine db " ", 10, "The number is less that 10."
    lessThanLineLen equ $-lessThanLine

section .bss
    input resd 16
    num resd 2
    first resd 2
    buffer resb 16
    choice resb 2

section .text
    global _start

_start:

    again:

    mov eax, 4
    mov ebx, 1
    mov ecx, headerLine
    mov edx, headerLineLen
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 16
    int 80h
  
    xor eax, eax
    lea esi, [input]
    call convert_to_int

    cmp eax, 10

    jge greater
    mov eax, 4
    mov ebx, 1
    mov ecx, lessThanLine
    mov edx, lessThanLineLen
    int 80h
    jmp endf
    greater:
    mov eax, 4
    mov ebx, 1
    mov ecx, geaterOrEqualLine
    mov edx, geaterOrEqualLineLen
    int 80h
    endf:

    mov eax, 4
    mov ebx, 1
    mov ecx, choiceLine
    mov edx, choiceLineLen
    int 80h
    mov eax, 3
    mov ebx, 0
    mov ecx, choice
    mov edx, 2
    int 80h

    lea esi, [choice]
    movzx edx, byte [esi]
    cmp edx, 0x59
    je again
  
    mov eax, 4
    mov ebx, 1
    mov ecx, thankYou
    mov edx, thankYouLen
    int 80h
    mov eax, 1
    mov ebx, 0
    int 80h

convert_to_int:
    movzx edx, byte [esi]
    cmp edx, 0xA
    je return 

    imul eax, 10
    sub edx, '0'
    add eax, edx
    inc esi
    jmp convert_to_int

convert_to_str:
    xor edx, edx 
    mov ebx, 10
    div ebx
    add edx, '0'
    mov [ecx], dl
    dec ecx

    test eax, eax
    jnz convert_to_str
    jmp return

return:
    ret