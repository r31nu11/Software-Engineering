format MZ
entry Main:Start

Segment Main
Start:
mov ax, Main
mov ds, ax

push cs
push Str1
push SkipStr
push num
call far Library:EnterNumber

push numX
call StrToInt
mov [numX], ax

push cs
push Str2
push SkipStr
push num
call far Library:EnterNumber

push numY
call StrToInt
mov [numY], ax


; Task 1
; Передача через регистры
; Тип процедуры - дальний

mov ax, [numX]
mov dx, [numY]
mov bx, [numY]
call far Library:Task1
mov [result], ax

push ax
push Tsk1
call ShowResult

; Task 2
; Передача через глобальные переменные
; Тип процедуры - дальний

push cs
call far Library:Task2
mov [result], ax

push ax
push Tsk2
call ShowResult

; Task 3
; Передача через стек
; Тип процедуры - ближний

push [numX]
push [numY]
call Task3
mov [result], ax

push ax
push Tsk3
call ShowResult

call far Library:ReadKey

mov ax, $4c00
int 21h

Task3:
push bp
mov bp, sp

mov ax, [bp + 6]
imul ax, ax
mov dx, [bp + 4]
mov bx, [bp + 4]
imul bx, bx
imul bx, dx
add ax, bx

pop bp
ret 4

ShowResult:
push bp
mov bp, sp

mov dx, [bp + 4]
mov ah, $09
int 21h

mov ax, [bp + 6]

mov bx, 10
xor cx, cx
@@:
xor dx, dx
div bx
push dx
inc cx
or ax, ax
jnz @B
@@:
pop dx
cmp dx, 9
jle NoPerenos
add dx, 7
NoPerenos:
add dx, '0'
mov ah, 02h
int 21h
loop @B

mov dx, SkipStr
mov ah, $09
int 21h

pop bp
ret 2

StrToInt:
push bp
mov bp, sp
mov word [bp + 4], 0

xor cx, cx
mov bx, num
mov cl, [ds:bx + 1]
lea si, [ds:bx + 2]

Calc:
xor ax, ax
lodsb
cmp al,'9'
ja Wrong
cmp al,'0'
jb Wrong

sub al, '0'
push cx
dec cx
test cx, cx
je LastNum
@@:
imul ax, 10
loop @B
LastNum:
pop cx
add [bp + 4], ax
loop Calc
jmp OK
Wrong:
mov ah, $09
mov dx, Error
int 21h

mov ah, 09h
mov dx, SkipStr
int 21h
OK:
mov ax, [bp + 4]
pop bp
ret 2

Str1 db 'Enter X number: $'
Str2 db 'Enter Y number: $'
Tsk1 db 'Result of Task #1: $'
Tsk2 db 'Result of Task #2: $'
Tsk3 db 'Result of Task #3: $'
Error db 'Error number$'
SkipStr db 13, 10, '$'
numX dw 0
numY dw 0
tmpS dw 0
result dw 0
num db 4, 0, 4 dup ?

Segment Library

EnterNumber:
push bp
mov bp, sp
push ds

mov ah, $09
mov dx, [bp + 10]
mov ds, [bp + 12]
int 21h

mov ah, $09
mov dx, [bp + 8]
mov ds, [bp + 12]
int 21h

mov ah, $0A
mov dx, [bp + 6]
mov ds, [bp + 12]
int 21h

mov ah, $09
mov dx, [bp + 8]
mov ds, [bp + 12]
int 21h

pop ds
pop bp
retf 8

Task1:
imul ax, ax
imul bx, bx
imul bx, dx
add ax, bx
retf

Task2:
push bp
mov bp, sp
push ds

mov ds, [bp + 4]
mov ax, [numX]
imul ax, ax
mov dx, [numY]
mov bx, [numY]
imul bx, bx
imul bx, dx
add ax, bx

pop ds
pop bp
retf 2

ReadKey:
mov ax, $0c08
int 21h
test al, al
jne @F
mov ah, $08
int 21h
@@:
retf