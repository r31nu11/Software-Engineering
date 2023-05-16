org 100h

everyPoint:
mov ah, 0fh
int 10h
mov [bOldMode], al
mov [bOldPage], bh

mov ax, 0013h
int 10h

push $A000
pop es
mov al, 0fh
mov cx, 320*100

xor di, di

loop1:
stosb
loop loop1

mov cx, 320*100
mov al, 29h

loop2:
stosb
loop loop2

mov cx, 100
mov bx, 100
xor di, di
mov al, 01h

loop3:
stosb
add di, 320
push di
push bx

loop4:
add di, 320
stosb
dec di
dec bx
cmp bx, 0
jne loop4
pop bx
pop di
dec bx
loop loop3

mov cx, 100
mov bx, 0
mov al, 01h
mov di, 320*100

loop5:
stosb

push di
push bx

loop6:
add di, 320
stosb
dec di
inc bx
cmp bx, 100
jne loop6
pop bx
pop di
inc bx
loop loop5

mov ax, 0c08h
int 21h
test al, al
jnz @F
mov ah, 08h
int 21h

@@:
movzx ax, [bOldMode]
int 10h

mov ah, 05h
mov al, [bOldPage]
int 10h

ret

bOldMode: db ?
bOldPage db ?