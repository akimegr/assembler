;�ணࠬ�� ��४���஢�� ��⨭᪮�� ��䠢��

   s1 segment stack 'stack'
   stk db 16 dup(?)
   s1 ends
   d1 segment 'data'
   tab1 db '�','�','�','�','�','�','�','�','�','�','�','�'
   tab  db 'a','b','c','d','e','f','g','h','i','j','k','l'

   Hello_msg db ' ���ࠡ�⠫ �ணࠬ�� ������.������ ᨬ��� �� 0 �� 9,��室 �� ESC ',13,10,'$'

 d1 ends
 code segment
 assume cs:code,ds:code
 ml proc far  ;��楤�� � ���ᥣ����� �맮���
 mov ax,s1
 mov ss,ax
 mov ax,offset stk
 mov sp,ax
 push ds ;    ��ନ஢���� ������ � ����樮���� ��⥬�
 xor ax,ax;
 push ax   ;

  mov ax,d1  ;
  mov ds,ax
  mov ah,9
  lea dx,hello_msg
  int 21H

   start:

  push cs         ;����ன�� ᥣ���⭮�� ॣ���� �-� �⥪
  pop ds
 start1:
  ; mov ah,0
  ; int 16h ;       ; ���뢠��� ����� ��� ����� ���� ����⮩ ������
  ; cmp al,27d;     ; �ࠢ����� ���� ������ � ������ ESC
  ; je end_;        ; ���室 �� ���� �ND  �� ����⨨ ESC

 lat: cmp al,'r';
      je rus;

   ;cmp al,'l';
   ;je lat;

  ;jmp start
   ;lat:
  push cs
  pop ds
  mov ah,0
  int 16h
  cmp al,27d;     ; �ࠢ����� ���� ������ � ������ ESC
  je end_;   
  cmp al,30h;     ; �ࠢ����� � ����� 0
  jl start       ; �஢�ઠ ��������� ����� ������ 0 - 9
  cmp al,39h
  jg start      ; ���᫥��� ����� ᨬ���� � ��४���஢�筮� ⠡��� ���
  sub al,"0"
  lds bx,cs:[200h]       ; ����㧪� 㪠��⥫� ��४���஢�筮� ⠡����
  xlat                   ; ������� ��४���஢�� ᨬ�����
  mov ah,2               ;  �뢮� ��४����㥬��� ᨬ���� �� �࠭ ���ᯫ��
  mov dl,al              ;
  int 21h                ;
  jmp lat                ; �࣠������ 横�� �ணࠬ�� ��४����. ��⨭���

  rus:	cmp al,'l';
	je lat;


  push cs
  pop ds
  mov ah,0
  int 16h

  cmp al,27d;     ; �ࠢ����� ���� ������ � ������ ESC
  je end_;        ; ���室 �� ���� �ND  �� ����⨨ ESC
  cmp al,30h;     ; �ࠢ����� � ����� 0
  jl rus          ; �஢�ઠ ��������� ����� ������ 0 - 9
  cmp al,39h
  jg rus      ; ���᫥��� ����� ᨬ���� � ��४���஢�筮� ⠡��� ���1
  sub al,"0"
  lds bx,cs:[250h]        ;����㧪� 㪠��⥫� ��४���஢�筮� ⠡���� ���1
   xlat                   ;������� ��४���஢�� ᨬ�����
   mov ah,2               ;�뢮� ��४����㥬��� ᨬ���� �� �࠭ ��ᯫ��
   mov dl,al              ;
   int 21h                ;
  jmp rus                 ; �࣠������ 横�� �ணࠬ�� ��४����.��ਫ���


   end_:
   ret    ; ������ � ����樮���� ��⥬�
   ml endp

  org 200h   ; �� ���� ᬥ饭�� 200h ��室���� 㪠��⥫� ��
  ad_off dw offset tab ; ��४���஢���� ⠡���� ��� 
  ad_seg dw seg tab

  org 250h
  ad1_off1 dw offset tab1
  ad1_seg1 dw seg tab1
      code ends
      end ml
