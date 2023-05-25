;lab 0
org 100h

; выводим поясняющий текст
mov dx, msg
mov ah, 09h
int 21h

mov dx, str1
mov ah, 09h
int 21h


; запрашиваем ввод строки
mov dx, buf
mov ah, 0Ah
int 21h

mov dx, str1
mov ah, 09h
int 21h


;mov dx, buf
;mov ah, 09h
;int 21h

mov dx, msg2
mov ah, 09h
int 21h

mov dx, str1
mov ah, 09h
int 21h

; получаем длину строки
mov si, buf + 1
mov cl, [si]
inc si

; меняем местами S3 и S9
mov al, [si + 2]
mov bl, [si + 8]
xchg al, bl
mov [si + 2], al
mov [si + 8], bl

; вычисляем S2 <- S4 - (S5 - S6)
mov al, [si + 3]
sub al, [si + 4]
add al, [si + 5]
mov [si + 1], al

; выводим полученную строку
mov dx, si
mov ah, 09h
int 21h

; дожидаемся нажатия клавиши
mov ah, 0
int 16h

; завершаем программу
mov ax, 4C00h
int 21h

msg2 db 'Result: $'
msg db 'Enter text: $'
str1 db 13, 10, '$', 13, 10
buf db 80, ?, 80 dup ('$')