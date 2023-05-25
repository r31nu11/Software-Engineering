org 100h

jmp StartN

msg1 db 'Enter string: $'
msg2 db 'Enter symbol: $'
msg3 db 'Changed string: $'
input1 db 80,0,80 dup(0)
char1 db 10,0,10 dup (0)
len1 db 0
str1 db 13, 10, '$', 13, 10

StartN:
mov dx, msg1
mov ah, 09h
int 21h

mov dx, str1
mov ah, 09h
int 21h

mov dx, input1
mov ah, 0Ah
int 21h

mov dx, str1
mov ah, 09h
int 21h

mov al, [input1+1]
mov [len1], al

mov dx, msg2
mov ah, 09h
int 21h

mov dx, str1
mov ah, 09h
int 21

mov ah, 0Ah
mov dx, char1
int 21h

mov dx, str1
mov ah, 09h
int 21h

cld
mov di, input1 + 2
mov al, byte[char1 + 2]

cycle1:
repne scasb
jge change
cmp cx, 0
je endSc
jmp cycle1

change:
dec di
cmp byte[di], 'a'
jle bigger
sub byte[di], 'a'
add byte[di], 'A'
jmp cycle1
bigger:
sub byte[di], 'A'
add byte[di], 'a'
jmp cycle1

endSc:
mov ah, 09h
mov dx, msg3
int 21h

xor di, di
mov cl, byte[len1]
mov di, 2

mov cl, byte[input1 + 1]
mov si, input1 + 2
printt:
lodsb
int 29h
loop printt

mov ah, 08h
int 21h

ret