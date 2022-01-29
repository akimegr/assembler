	.286 
	.model	small
        .stack 256h
	.data
	msg label byte
	maxnum db 5
	reallen db ?
	numfld db 5 dup(?)
	x dw ?
	MULT10 dw 1
	.code
asbin proc
	mov MULT10,0001
	mov X,0
	mov cx,10
	lea si, numfld-1
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
	mov ah,0ah
	lea dx,msg
	int 21h
main	proc	far
	pusha

	mov 	di,2000
	mov	bx,5000

	mov 	al,0B6h
	out	43h,al
	mov	dx,0014h
	mov	ax,4F38h
	div	di
	out	42h,al
	mov	al,ah
	out	42h,al
	in	al,61h
	mov	ah,al
	or	al,3
	out	61h,al

l1:	mov	cx,2801h
l2:	loop	l2
	dec	bx
	jnz	l1
	mov	al,ah
	out	61h,al

	popa
         mov ah,4ch
         int 21h
	
main	endp
	end main
