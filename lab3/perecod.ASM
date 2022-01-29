;Программа перекодировки латинского алфавита

s1 segment stack'stack'
stk db 16 dup(?)
s1 ends
d1 segment 'data'
tab db ' ','Ў','ў','Ј','¤','Ґ','¦','§','Ё','Є','«','¬'
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
lds bx,cs:[200h]
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
code ends
end m1
