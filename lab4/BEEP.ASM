	.286 
	.model	small
        .stack 256h
        .data

	

msg label byte ;������ ��� ����� ᨬ����� � ����������
maxnum db 6 ; ��६����� ��� ��ॢ��� ᨬ����� � �᫮
reallen db (?)
numfld db 6 dup (?)
x dw ?
mult10 dw 1
              
txt db '������ ⮭ ���砭�� ',10,13,'$'
txt1 db '������ ���⥫쭮��� ��㠭��' 


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

	mov 	al,0B6h  ;����㧪� �ࠢ��饣� ᫮�� �  ⠩���
	out	43h,al   ;
	mov	dx,0014h ; ������� ��� ��ਮ�� ��㪠
	mov	ax,4F38h


	div	di       ; ���᫥��� 䠪⨥᪮�� �२��� ��㪠
	out	42h,al   ;����㧪� ����襣� ���� ��ਮ�� ��㪠 � ⠩���
	mov	al,ah
	out	42h,al   ; ����㧪� ���襣� 
	in	al,61h  ;�⥭�� ���� ���ﭨ� ��������
	mov	ah,al   ;��࠭����� ���祭�� ���� ���ﭨ� � 
	or	al,3     ;����祭�� ��㪠 ��⠭����� 2� ������ ��� � �������
	out	61h,al  ;������� ��稭��� ������

l1:	mov	cx,2801h  ;����প� � 1 ��ᥪ
l2:	loop	l2  ;横� ����প�
	dec	bx ;㬥��襭�� ���⥫쭮�� ���砭�� �� 1 ������
	jnz	l1   ;横� ��ࠡ�⪨ ���⥫쭮�� ���砭�� ��������
	mov	al,ah  ;�몫�祭�� ��㪠 �� ��������
	out	61h,al

	popa        ;����⠭������� �� �⥪� ॣ���஢ 
         mov ah,4ch  ; ������ � ��
         int 21h
	

main	endp
	end main
