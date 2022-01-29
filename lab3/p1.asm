;Программа перекодировки латинского алфавита

s1 segment stack'stack'
stk db 16 dup(?)
s1 ends
d1 segment 'data'

tab db 'a','b','c','d','e','f','g','h','i','j','k','l'
tab1 db 'абвгдеёжзикл'
  mes1   db "нажмите клавиши от 0....9. Выход- ESC",13,10,"$"
d1 ends
code segment
assume cs:code,ds:code
m1 proc far
mov ax,s1
mov ss,ax
mov ax,offset stk
mov sp,ax
push ds
xor ax,ax
push ax
   mov  ax,d1
   mov ds,ax; 
   mov ah,9
   lea dx,mes1
   int 21h  
start:
push cs
pop ds
mov ah,0
int 16h
cmp al,27d
je end_
cmp al,30h
jl start
cmp al,39h
jg start
sub al,"0"
;lds bx,cs:[200h]
lds bx,cs:[250h]
xlat
mov ah,2
mov dl,al
int 21h
jmp start
end_:
ret
m1 endp
org 200h
ad_off dw offset tab
ad_seg dw seg tab
org 250h
ad1_off dw offset tab1
ad1_seg dw seg tab1
code ends
end m1
