.286 
	    .model	small
        .stack 256h
        .data
msg label byte ;стуктура для ввода символов с клавиатуры
maxnum db 6 ; переменная для максимального числоа символов 
reallen db (?) ;
numfld db 6 dup (0);буфер для символов с клавиатуры
x dw ?       ;
mult10 dw 1   ;
              
txt  db 'Введите длительность звука:',10,13,'$'
ton   dw 1000
dlit  dw 500

        .code
asbin proc;
  mov MULT10,0001
  mov x,0
  mov cx,10;осн сист счисления
  lea si,numfld-1;
  mov bl,reallen;
  sub bh,bh
b20:
    mov al,[si+bx]
	and ax,000fh
	mul MULT10
	add X,ax
	mov ax,MULT10
	mul cx
	mov MULT10,ax
	dec bx
	jnz b20
	ret
asbin endp 

sound proc
    mov  al,0B6h  ;загрузка управлющего слова в  таймер
	out	43h,al   ;
	mov	dx,0014h ; задание мах периода звука
	mov	ax,4F38h
	div	di       ; вычисление фактиеского преиода звука
	out	42h,al   ;загрузка младшего байта периода звука в таймер
	mov	al,ah
	out	42h,al   ; загрузка старшего 
	in	al,61h  ;чтение порта состояния динамика
	mov	ah,al   ;сохраниение значение порта состояния в ah 
	or	al,3     ;включение звука установкой 2х младших бит в единицу
	out	61h,al  ;динамик начинает звучать

l1:	mov	cx,2000h  ;задержка в 1 млсек
mov ah,1
int 16h
cmp al, 27d
je exit
l2:	loop	l2  ;цикл задержки
	dec	bx ;уменьшение длительности звучания на 1 дискрету
	jnz	l1   ;цикл отработки длительности звучания динамика
	mov	al,ah  ;выключение звука от динамика
	out	61h,al
ret
sound endp


main	proc	far
	pusha

mov ax,@data
mov ds,ax
mov ah,9
lea dx,txt;приглашение к вводу тона звука
int 21h
mov bx, dx
add bx,5
mov ax,bx
mov cx,200
div ax

call asbin; преобразование тона звучанения в число
	  mov di,x; загрузка тона звучания в р-р di
        mov ton,di;


mov ah,0ah; ввод длительности звука
lea dx,msg
int 21h

call asbin; преобразование длительности звучания в число 
	  mov	bx,x ; загрузка длительности звука
       mov dlit,bx

        mov   di,ton ;загрузка тона звука
        mov bx,dlit
        call sound  ;1-й звук
; пауза

        mov   di,2000 ;загрузка тона звука в паузе
        mov bx,dlit
        call sound  ;пауза-й звук
        add ton,500
        mov   di,ton ;загрузка тона звука
        mov bx,dlit
        call sound  ;2-й звук

	exit:
	
	    popa        ;восстановление из стека регистров 
         mov ah,4ch  ; возврат в ОС
	mov al,ah
	out 61h, al
         int 21h
		 
	
main	endp
	end main

