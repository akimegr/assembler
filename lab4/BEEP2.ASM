.286 
	    .model	small
        .stack 256h
        .data
msg label byte ;������ ��� ����� ᨬ����� � ����������
maxnum db 6 ; ��६����� ��� ���ᨬ��쭮�� �᫮� ᨬ����� 
reallen db (?) ;
numfld db 6 dup (0);���� ��� ᨬ����� � ����������
x dw ?       ;
mult10 dw 1   ;
              
txt  db '������ ���⥫쭮��� ��㪠:',10,13,'$'
ton   dw 1000
dlit  dw 500

        .code
asbin proc;
  mov MULT10,0001
  mov x,0
  mov cx,10;�� ��� ��᫥���
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
    mov  al,0B6h  ;����㧪� �ࠢ��饣� ᫮�� �  ⠩���
	out	43h,al   ;
	mov	dx,0014h ; ������� ��� ��ਮ�� ��㪠
	mov	ax,4F38h
	div	di       ; ���᫥��� 䠪⨥᪮�� �२��� ��㪠
	out	42h,al   ;����㧪� ����襣� ���� ��ਮ�� ��㪠 � ⠩���
	mov	al,ah
	out	42h,al   ; ����㧪� ���襣� 
	in	al,61h  ;�⥭�� ���� ���ﭨ� ��������
	mov	ah,al   ;��࠭����� ���祭�� ���� ���ﭨ� � ah 
	or	al,3     ;����祭�� ��㪠 ��⠭����� 2� ������ ��� � �������
	out	61h,al  ;������� ��稭��� ������

l1:	mov	cx,2000h  ;����প� � 1 ��ᥪ
mov ah,1
int 16h
cmp al, 27d
je exit
l2:	loop	l2  ;横� ����প�
	dec	bx ;㬥��襭�� ���⥫쭮�� ���砭�� �� 1 ������
	jnz	l1   ;横� ��ࠡ�⪨ ���⥫쭮�� ���砭�� ��������
	mov	al,ah  ;�몫�祭�� ��㪠 �� ��������
	out	61h,al
ret
sound endp


main	proc	far
	pusha

mov ax,@data
mov ds,ax
mov ah,9
lea dx,txt;�ਣ��襭�� � ����� ⮭� ��㪠
int 21h
mov bx, dx
add bx,5
mov ax,bx
mov cx,200
div ax

call asbin; �८�ࠧ������ ⮭� ���砭���� � �᫮
	  mov di,x; ����㧪� ⮭� ���砭�� � �-� di
        mov ton,di;


mov ah,0ah; ���� ���⥫쭮�� ��㪠
lea dx,msg
int 21h

call asbin; �८�ࠧ������ ���⥫쭮�� ���砭�� � �᫮ 
	  mov	bx,x ; ����㧪� ���⥫쭮�� ��㪠
       mov dlit,bx

        mov   di,ton ;����㧪� ⮭� ��㪠
        mov bx,dlit
        call sound  ;1-� ���
; ��㧠

        mov   di,2000 ;����㧪� ⮭� ��㪠 � ��㧥
        mov bx,dlit
        call sound  ;��㧠-� ���
        add ton,500
        mov   di,ton ;����㧪� ⮭� ��㪠
        mov bx,dlit
        call sound  ;2-� ���

	exit:
	
	    popa        ;����⠭������� �� �⥪� ॣ���஢ 
         mov ah,4ch  ; ������ � ��
	mov al,ah
	out 61h, al
         int 21h
		 
	
main	endp
	end main

