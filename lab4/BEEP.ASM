	.286 
	.model	small
        .stack 256h
        .data

	

msg label byte ;стуктура для ввода символов с клавиатуры
maxnum db 6 ; переменная для перевода символов в число
reallen db (?)
numfld db 6 dup (?)
x dw ?
mult10 dw 1
              
txt db 'введите тон звучания ',10,13,'$'
txt1 db 'введите длительность звуания' 


        .code
asbin proc
  mov MULT10,0001
  mov x,0
  mov cx,10
  lea si,numfld-1
  mov bl,reallen
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

main	proc	far
	pusha

mov ax,@data
mov ds,ax
mov ah,9
lea dx,txt1
int 21h

mov ah,0ah
lea dx,msg
int 21h
call asbin




	mov 	di,x
	mov	bx,500   

	mov 	al,0B6h  ;загрузка управлющего слова в  таймер
	out	43h,al   ;
	mov	dx,0014h ; задание мах периода звука
	mov	ax,4F38h


	div	di       ; вычисление фактиеского преиода звука
	out	42h,al   ;загрузка младшего байта периода звука в таймер
	mov	al,ah
	out	42h,al   ; загрузка старшего 
	in	al,61h  ;чтение порта состояния динамика
	mov	ah,al   ;сохраниение значение порта состояния в 
	or	al,3     ;включение звука установкой 2х младших бит в единицу
	out	61h,al  ;динамик начинает звучать

l1:	mov	cx,2801h  ;задержка в 1 млсек
l2:	loop	l2  ;цикл задержки
	dec	bx ;уменьшение длительности звучания на 1 дискрету
	jnz	l1   ;цикл отработки длительности звучания динамика
	mov	al,ah  ;выключение звука от динамика
	out	61h,al

	popa        ;восстановление из стека регистров 
         mov ah,4ch  ; возврат в ОС
         int 21h
	

main	endp
	end main
