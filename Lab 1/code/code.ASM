;lab 1

org 100h

Instr:
    mov dx, msgI
    mov ah, 09h
    int 21h

    mov dx, str1
    mov ah, 09h
    int 21h

; ������ ������ � ����������
mov ah, 0Ah
mov dx, buffer
int 21h

;DubStr:
;        mov dx, buffer
;        mov ah, 09h
;        int 21h

        mov dx, str1
        mov ah, 09h
        int 21h

; ��������� ����� ������
mov al, byte[buffer+1] ; al = ����� ������
cmp al, 5 ; ���� ������ 5 ��������
jb error ; �� ������
cmp al, 8 ; ���� ������ 8 ��������
ja error ; �� ������

; ��������� ������ � ������ �������
mov bl, [buffer+3] ; bl = ������ ������
cmp bl, [buffer+4] ; ���� �� ����� �������� �������
jne error ; �� ������

; ��������� ������ ������
mov cl, [buffer+2] ; cl = ������ ������
cmp cl, 'A' ; ���� ������ 'A'
jb error ; �� ������
cmp cl, 'Z' ; ���� ������ 'Z'
ja check_lower ; �� ��������� �������� �����
jmp ok ; ����� ��� ������

check_lower:
cmp cl, 'a' ; ���� ������ 'a'
jb error ; �� ������
cmp cl, 'z' ; ���� ������ 'z'
ja error ; �� ������

ok:
; ��������� ����������������� ������
;push ax ; ��������� �������� al � �����
xor bx, bx

cbw
xor si, si
add si, ax

add si, 1
mov bl, byte[buffer + si]



;mov bl, byte[buffer+2] ; si = ������ ������ ������
;cbw ; ��������� al �� ax (��������� ���� � ah)
;add bl, al ; ���������� � si �������� ax (����� ������)
;dec bl ; ��������� �� ������� (����������������� ������)

;mov bl, word[buffer+si] ; si = ����������������� ������ ������
;pop ax ; ��������������� �������� al �� �����
cmp bl, '0' ; ���� ������ '0'
jb error ; �� ������
cmp si, '9' ; ���� ������ '9'
ja error ; �� ������

mov ah, 09h
mov dx, success_msg
int 21h
; ������� ��������� �� ������

jmp endprog
; ��������� ���������

error:
; ������� ��������� �� ������
mov ah, 09h
mov dx, error_msg
int 21h

; ��������� ��������� � ����� ������ 1
endprog:

mov ah, 08h
int 21h

ret

; ��������� ����� ��� ����� ������ (�������� 10 ��������)
buffer db 10, 0, 10 dup(0)
; ��������� ��������� ��� ������ �� �����
msgI db "Enter text: $"
str1 db 13, 10, '$', 13, 10
success_msg db "Correct.$"
error_msg db "Incorrect.$"