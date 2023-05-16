; создаем COM программу дл€ DOS
org 100h

; читаем строку с клавиатуры
mov ah, 0Ah
mov dx, buffer
int 21h

; провер€ем длину строки
mov al, byte[buffer+1] ; al = длина строки
cmp al, 5 ; если меньше 5 символов
jb error ; то ошибка
cmp al, 8 ; если больше 8 символов
ja error ; то ошибка

; провер€ем второй и третий символы
mov bl, [buffer+3] ; bl = второй символ
cmp bl, [buffer+4] ; если не равен третьему символу
jne error ; то ошибка

; провер€ем первый символ
mov cl, [buffer+2] ; cl = первый символ
cmp cl, 'A' ; если меньше 'A'
jb error ; то ошибка
cmp cl, 'Z' ; если больше 'Z'
ja check_lower ; то провер€ем строчные буквы
jmp ok ; иначе все хорошо

check_lower:
cmp cl, 'a' ; если меньше 'a'
jb error ; то ошибка
cmp cl, 'z' ; если больше 'z'
ja error ; то ошибка

ok:
; провер€ем предпредпоследний символ
;push ax ; сохран€ем значение al в стеке
xor bx, bx

cbw
xor si, si
add si, ax

add si, 1
mov bl, byte[buffer + si]



;mov bl, byte[buffer+2] ; si = первый символ строки
;cbw ; расшир€ем al до ax (добавл€ем нули в ah)
;add bl, al ; прибавл€ем к si значение ax (длину строки)
;dec bl ; уменьшаем на единицу (предпредпоследний символ)

;mov bl, word[buffer+si] ; si = предпредпоследний символ строки
;pop ax ; восстанавливаем значение al из стека
cmp bl, '0' ; если меньше '0'
jb error ; то ошибка
cmp si, '9' ; если больше '9'
ja error ; то ошибка

; выводим сообщение об успехе
mov ah, 09h
mov dx, success_msg
int 21h

mov ah, 08h
int 21h

; завершаем программу
mov ah, 4Ch
int 21h

error:
; выводим сообщение об ошибке
mov ah, 09h
mov dx, error_msg
int 21h

mov ah, 08h
int 21h

; завершаем программу с кодом ошибки 1
mov ah, 4Ch
mov al, 1
int 21h


; объ€вл€ем буфер дл€ ввода строки (максимум 10 символов)
buffer db 10, ?, 10 dup(0)
; объ€вл€ем сообщени€ дл€ вывода на экран
success_msg db "Correct.$"
error_msg db "Incorrect$"