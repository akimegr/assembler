	.286 
	.model	small
        .stack 256h
	.code

 beep	proc	far
	pusha

	;mov 	di,1000
	;mov	bx,65000

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
         ;mov ah,4ch
         ;int 21h
        ret	
   beep	endp

   start: mov ax,@data
          mov ds, ax
       mov ah,0
       int 16h ;
       cmp al,27d;      ��������� ���� ������� � ����� ESC
       jz end2   ;      ����� ��  ESC
       mov cl,10 ;      ��������� 10
       mul cl    ;      ��������� ���� ������� �� 10
       mov  di,ax  ;    ������������ ���� ��������
       mov bx,5000  ;   �������� �����
       call beep    ;   ����� ��������� �����
       ;jmp start

 end2:  mov ah,4cH ;���������� ���������
	int 21H
	end start
