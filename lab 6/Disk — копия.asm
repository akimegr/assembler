; ���᫨�� ��ࠦ����  a*b/c-d � ������� १���� � 䠩�  RES.TXT.
;��ନ஢��� ��� ���⮩  1000 �� ,� ���⥫쭮��� ����� �� 䠩�� SOUND.TXT
.286
.model small
.stack 256
.data
	an db 250  ;�६����
	bn db 10
	cn db 15
	dn db 3
	dlit dw 0
	buffer db 3 dup(?)           ; ���� ��� ��४���஢��
	filename db 'RES.TXT',0      ; ������� १����
	soundfile db 'SOUND.TXT',0   ; 䠩� ��㤠 �⠥� ���⥫쭮��� ��㪠
.code
	include common.inc     ;
start:                         ;
	mov ax,@data
	mov ds,ax
	mov al,an
	mul bn                 ; 㬭������ �ᥫ a*b
	div cn                 ; ������� a*b/c
	sub al,dn              ; ���⠭��    a*b/c-d
	xor ah,ah              ; ���⪠ ���⪠ �� �������(� �� - १����)
;
	push 10                ; ��ॢ�� �᫠ � ��ப�
	push offset buffer+3   ;  �������� � �⥪
	push ax                ; १���� ���᫥���
	mov ah,3Ch             ; ᮧ����� 䠩��
	xor cx,cx              ; 
	mov dx,offset filename ;����㧪� 㪠��⥫� �� ��� 䠩��
	int 21h
	mov bx,ax              ; ����㦠�� ���ਯ�� 䠩�� � bx
	call num2str           ; ��ॢ�� �᫠ � ��ப�
	add sp,6               ;
	mov cx,offset buffer+3 ;����㧪� �᫠ �����뢠���� � ����
	sub cx,ax  ;  
	mov dx,ax              ; ���c ���� � ����묨
	mov ah,40h             ; ����� �㭪樨 ����� �  䠩�
	int 21h
	mov ah,3Eh             ;����뢠�� 䠩� res.txt
	int 21h

	mov ax,3D00h           ; ���뢠�� 䠩� sound.txt
	mov dx,offset soundfile   ; ���� ����� 䠩��
	xor cl,cl
	int 21h
	mov ah,3Fh             ; �⠥� c���ন��� 䠩��
	mov dx,offset buffer   ; ���� ���� �㤠 ���� ������ �����
	mov cx,4               ; �᫮ ���뢠���� ����
	int 21h
	push 10                ; �ॢ�� ��ப� � �᫮(��⥬� ��᫥���)
	push offset buffer  ;
	push 4               ;   ����� ��ப�
	call str2num           ; ��ॢ�� ��ப� � �᫮
	add sp,6
	
	mov dlit,ax
	mov ax,3D00h           ; ���뢠�� 䠩� sound.txt
	mov dx,offset soundfile   ; ���� ����� 䠩��
	xor cl,cl
	int 21h
	mov ah,3Fh             ; �⠥� c���ন��� 䠩��
	mov dx,offset buffer   ; ���� ���� �㤠 ���� ������ �����
	mov cx,4               ; �᫮ ���뢠���� ����
	int 21h
	push 10                ; �ॢ�� ��ப� � �᫮(��⥬� ��᫥���)
	push offset buffer  ;
	push 4               ;   ����� ��ப�
	call str2num           ; ��ॢ�� ��ப� � �᫮
	add sp,6
	
	push ax              ;���� ���砭��
	call sound
	add sp,2
	push 0                  ;
	push dlit   ;
	call pause ;
	add sp,4               ;
	call nosound
	mov ah,3Eh             ; ����뢠�� 䠩�
	int 21h
	call exit              ; ��室 �� �ணࠬ��
end start