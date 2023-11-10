
global _start

section .data
  num1: dd 10
  num2: dd 26

  smallestLine: db " ", 10, "The smallest is: "
  smallestLineLen: equ $-smallestLine

  largestLine: db " ", 10, "The largest is: "
  largestLineLen: equ $-largestLine

section .bss
  largest resd 2
  smallest resd 2
  buffer1 resb 16
  buffer2 resb 16

section .text
_start:

  mov eax, dword [num1]
  mov ebx, dword [num2]
  cmp eax, ebx
  jl endf 
  mov eax, dword [num2]
  mov ebx, dword [num1]
  endf:

  mov dword [smallest], eax
  mov dword [largest], ebx

  mov eax, 4
  mov ebx, 1
  mov ecx, smallestLine
  mov edx, smallestLineLen
  int 80h
  mov eax, dword [smallest]
  lea ecx, [buffer1 + 15]
  call convert_to_str
  mov eax, 4
  mov ebx, 1
  mov edx, 16
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, largestLine
  mov edx, largestLineLen
  int 80h
  mov eax, dword [largest]
  lea ecx, [buffer2 + 15]
  call convert_to_str
  mov eax, 4
  mov ebx, 1
  mov edx, 16
  int 80h

  mov eax, 1
  mov ebx, 0
  int 80h

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