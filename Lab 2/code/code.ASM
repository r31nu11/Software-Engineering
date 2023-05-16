    org 100h

    mov ax, cs
    mov ds, ax

    mov si, 0
    mov cx, 0

    loop1:
    cmp byte [array + si], 0
    je skip
    inc cx
    skip:
    inc si
    cmp si, 10
    jl loop1

    mov dx, msg
    mov ah, 9
    int 21h

    mov ax, cx
    call print_num

    mov dx, msg2
    mov ah, 9
    int 21h

    mov ah, 0
    int 16h

    ret

    print_num:
    push ax
    push bx
    push dx

    mov bx, 10
    xor cx, cx

    divide:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz divide

    print_digit:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_digit

    pop dx
    pop bx
    pop ax

    ret

    array db 1, 0, 3, 4, 0, 6, 7, 0, 9, 10

    msg db 'In array '
    msg2 db ' elements, that dont equal 0', '$'

